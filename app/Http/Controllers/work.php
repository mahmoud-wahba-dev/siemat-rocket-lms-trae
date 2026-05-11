<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use MailchimpMarketing\ApiClient;
use App\Services\MailchimpServices\MailchimpEventFormatter;
use App\Services\MailchimpServices\MailchimpSender;
use MailchimpMarketing\ApiException;
use Illuminate\Http\Request;

class TestMailController extends Controller
{
    public function send(Request $request)
    {

        $payload = $request->all();   // Raw POST data من Rocket LMS



        $apiKey = env('MAILCHIMP_API_KEY');
        $server = env('MAILCHIMP_SERVER_PREFIX');
        $listId = env('MAILCHIMP_LIST_ID');


        // 1) تحويل الحدث الخام → Mailchimp Event
        //$formatted = MailchimpEventFormatter::format($payload);

        $email  = $payload["email"];
        //$tags   = $payload["tags"];
        //$fname   = $payload["properties"]["FNAME"];
        //$lname   = $payload["properties"]["LNAME"];
        //$phone   = $payload["properties"]["PHONE"];
        $mcEvent = $payload["name"];
        $properties = $payload["properties"];


//return ($tags);



        //self::triggerEvent($email, $mcEvent, $properties,$listId, $server, $apiKey);
        // $this->addToAudience($email,$tags , $fname,$lname, $listId, $server, $apiKey,$phone);

        $this->upsertSubscriber($email, $properties, $listId, $server, $apiKey);
        $this->triggerEvent($email, $mcEvent, $properties, $listId, $server, $apiKey);


        return ("Event send");
    }
    private static function addToAudience($email, $tags ,$fname,$lname , $listId, $server, $apiKey,$phone)
    {

        try {
            $mailchimp = new ApiClient();
            $mailchimp->setConfig([
                'apiKey' => $apiKey,
                'server' => $server,
            ]);

            // تقسيم الاسم إلى First + Last
           // $parts = explode(' ', $name);
            //$firstName = $parts[0] ?? '';
            //$lastName  = $parts[1] ?? '';

            // إضافة المستخدم للائحة
            $mailchimp->lists->addListMember($listId, [
                "email_address" => $email,
                "status" => "subscribed",
                "tags" => [
                   $tags
                ],
                "merge_fields"  => [
                    "FNAME" => $fname,
                    "LNAME" => $lname,
                ]
            ]);

        } catch (ApiException $e) {
            \Log::error("Mailchimp add subscriber error: " . $e->getMessage());
        }
    }


    private function upsertSubscriber($email, $properties, $listId, $server, $apiKey)
    {
         $subscriberHash = md5(strtolower($email));

    // تنظيف القيم الفارغة
    $mergeFields = array_filter($properties, function ($value) {
        return !is_null($value) && $value !== '';
    });

    Http::withBasicAuth('any', $apiKey)
        ->put("https://{$server}.api.mailchimp.com/3.0/lists/{$listId}/members/{$subscriberHash}", [
            "email_address" => $email,
            "status_if_new" => "subscribed",
            "merge_fields"  => $mergeFields
        ]);
    }


    private static function triggerEvent($email, $eventName, $properties, $listId, $server, $apiKey)
    {
        // إنشاء الـ subscriber hash
        $subscriberHash = md5(strtolower($email));

        try {
            $response = Http::withBasicAuth('any', $apiKey)
                ->post("https://{$server}.api.mailchimp.com/3.0/lists/{$listId}/members/{$subscriberHash}/events", [
                    'name' => $eventName,
                    'properties' => $properties,
                ]);

            if (!$response->successful()) {
                \Log::error('Mailchimp triggerEvent error: ' . $response->body());
            }
        } catch (\Exception $e) {
            \Log::error("Mailchimp triggerEvent exception: " . $e->getMessage());
        }
    }

    // public  function test()
    // {

    //     $eventName = "trainer_created";

    //     $payload = [
    //         'user_email' => "imadeddine91@gmail.com",
    //         'user_name'  => "IMAD EDDINE",
    //         'user_id'    => 4,
    //         'mobile'     => "+21261134258",
    //         'date'       => "08/25",
    //          "tags"        => "Trainer",
    //     ];


    //     $url = env('MAILCHIMP_MIDDLEWARE_URL');

    //     if (!$url) {
    //         Log::error("MAILCHIMP_MIDDLEWARE_URL not set");
    //         return false;
    //     }

    //     $body = [
    //         'event' => $eventName,
    //         'data'  => $payload
    //     ];

    //     try {
    //         $response = Http::post($url, $body);


    //         if ($response->failed()) {
    //             Log::error('Webhook failed', [
    //                 'status' => $response->status(),
    //                 'body'   => $response->body(),
    //             ]);
    //             return false;
    //         }

    //         return true;

    //     } catch (\Throwable $e) {
    //         Log::error("Webhook send error: " . $e->getMessage());
    //         return false;
    //     }
    // }
}
