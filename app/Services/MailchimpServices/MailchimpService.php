<?php
namespace App\Services\MailchimpServices;

use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Bus;

class MailchimpService
{
    public static function dispatchEvent(array $payload)
    {
        // نضع المهمة فالـ queue باش المعالجة تكون async
        \App\Jobs\ProcessWebhookEvent::dispatch($payload);
    }

    public static function handleEvent(array $payload)
    {
        $event = $payload['event'] ?? null;
        $data  = $payload['data'] ?? [];

        switch ($event) {
            case 'user_registered':
                self::sendWelcomeEmail($data);
                break;
            // add more events...
            default:
                Log::info("Unhandled event: $event");
                break;
        }
    }

    protected static function sendWelcomeEmail(array $data)
    {
        $mandrillKey = env('MAILCHIMP_TRANSACTIONAL_KEY');
        if (! $mandrillKey) {
            Log::error('Mandrill key not set');
            return false;
        }

        $message = [
            "key" => $mandrillKey,
            "message" => [
                "from_email" => "no-reply@siematplus.nidamk.com",
                "from_name" => "SamatPlus",
                "to" => [
                    ["email" => $data['user_email'], "type" => "to"]
                ],
                "subject" => "تأكيد إنشاء الحساب - SamatPlus",
                "html" => "<p>سلام {$data['user_name']},</p><p>تم إنشاء حسابك بنجاح...</p>",
            ]
        ];

        try {
            $response = Http::post('https://mandrillapp.com/api/1.0/messages/send.json', $message);
            if ($response->successful()) {
                return true;
            } else {
                Log::error('Mandrill response: '.$response->body());
                return false;
            }
        } catch (\Exception $e) {
            Log::error('Mandrill exception: '.$e->getMessage());
            return false;
        }
    }
}
