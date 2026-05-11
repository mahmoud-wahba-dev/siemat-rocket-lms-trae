<?php

namespace App\PaymentChannels\Drivers\MyFatoorah;

use App\Models\Order;
use App\Models\PaymentChannel;
use App\PaymentChannels\BasePaymentChannel;
use App\PaymentChannels\IChannel;
use Illuminate\Http\Request;

class Channel extends BasePaymentChannel implements IChannel
{
    protected $currency;
    protected $test_mode;
    protected $api_key;
    protected $base_url;
    protected $order_session_key;

    protected array $credentialItems = [
        'api_key',
        'base_url',
    ];

    /**
     * Channel constructor.
     * @param PaymentChannel $paymentChannel
     */
    public function __construct(PaymentChannel $paymentChannel)
    {
        $this->currency = currency();
        $this->order_session_key = 'myfatoorah.payments.order_id';
        $this->setCredentialItems($paymentChannel);
    }

    public function paymentRequest(Order $order)
    {
        $price = $this->makeAmountByCurrency($order->total_amount, $this->currency);
        $generalSettings = getGeneralSettings();

        // Sanitize mobile: strip non-digits, remove country code prefix, cap at 11 chars
        $rawMobile  = $order->user->mobile ?? $order->user->phone ?? '';
        $mobile     = preg_replace('/\D/', '', $rawMobile);          // digits only
        $mobile     = preg_replace('/^(00966|966|00965|965|00968|968|00971|971|00973|973|00974|974|00966|2|20)/', '', $mobile);
        $mobile     = substr($mobile, -11);                           // max 11 chars

        $data = [
            "InvoiceValue"       => $price,
            "CustomerName"       => $order->user->name ?? 'Customer',
            "CustomerEmail"      => $order->user->email ?? '',
            "CustomerMobile"     => $mobile,
            "NotificationOption" => "ALL",
            "InvoiceItems" => [
                [
                    "ItemName"  => $generalSettings['site_name'] . ' payment',
                    "Quantity"  => 1,
                    "UnitPrice" => $price
                ]
            ],
            "CallBackUrl" => $this->makeCallbackUrl('success'),
            "ErrorUrl"    => $this->makeCallbackUrl('cancel'),
        ];

        $response = $this->callApi("/v2/SendPayment", $data);

        if (!empty($response['Data']['InvoiceURL'])) {
            session()->put($this->order_session_key, $order->id);
            return redirect($response['Data']['InvoiceURL']);
        }

        throw new \Exception($response['Message'] ?? 'Payment failed');
    }

    private function makeCallbackUrl($status)
    {
        return url("/payments/verify/MyFatoorah?status=$status");
    }

    public function verify(Request $request)
    {
        $data = $request->all();
        $status = $data['status'] ?? null;
        $paymentId = $request->input('paymentId');

        $order_id = session()->get($this->order_session_key, null);
        session()->forget($this->order_session_key);

        $user = auth()->user();

        if (!$user || !$order_id) {
            return null;
        }

        $order = Order::where('id', $order_id)
            ->where('user_id', $user->id)
            ->first();

        if ($status == 'success' && !empty($paymentId) && !empty($order)) {
            $apiData = [
                "Key" => $paymentId,
                "KeyType" => "PaymentId"
            ];

            try {
                $response = $this->callApi("/v2/GetPaymentStatus", $apiData);

                if (
                    isset($response['Data']['InvoiceStatus']) &&
                    $response['Data']['InvoiceStatus'] === 'Paid'
                ) {
                    $order->update([
                        'status' => Order::$paying
                    ]);

                    return $order;
                }
            } catch (\Exception $e) {
                \Log::error('MyFatoorah verify error: ' . $e->getMessage());
            }
        }

        if (!empty($order)) {
            $order->update(['status' => Order::$fail]);
        }

        return $order;
    }

    private function callApi($endpoint, $data)
    {
        $baseUrl = rtrim($this->base_url ?? '', '/');
        $ch = curl_init($baseUrl . $endpoint);

        curl_setopt_array($ch, [
            CURLOPT_CUSTOMREQUEST => "POST",
            CURLOPT_POSTFIELDS => json_encode($data),
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_HTTPHEADER => [
                "Authorization: Bearer " . $this->api_key,
                "Content-Type: application/json"
            ],
        ]);

        $result = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);

        if (curl_errno($ch)) {
            throw new \Exception(curl_error($ch));
        }

        if ($httpCode !== 200) {
            throw new \Exception("MyFatoorah API HTTP Error: $httpCode");
        }

        curl_close($ch);

        return json_decode($result, true);
    }
}
