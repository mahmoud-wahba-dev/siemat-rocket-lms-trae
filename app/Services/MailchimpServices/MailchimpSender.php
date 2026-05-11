<?php

namespace App\Services\MailchimpServices;
use MailchimpMarketing\ApiClient;
use MailchimpMarketing\ApiException;
use Illuminate\Support\Facades\Http;

class MailchimpSender
{
    public static function subscribed($payload)
    {
        $apiKey = env('MAILCHIMP_API_KEY');
        $server = env('MAILCHIMP_SERVER_PREFIX');
        $listId = env('MAILCHIMP_LIST_ID');

        $email  = $payload["email"];
        $tags   = $payload["tags"];
        $fname   = $payload["properties"]["FNAME"];
        $lname   = $payload["properties"]["LNAME"];
        $phone   = $payload["properties"]["PHONE"];
        $mcEvent = $payload["event_name"];
        $properties = $payload["properties"];

        self::addToAudience($email,$tags  ,$fname,$lname, $listId, $server, $apiKey,$phone);
        //$this->triggerEvent($email, $mcEvent, $properties, $listId, $server, $apiKey);
    }
    public static function sendEvent($event)
    {
        $apiKey = env('MAILCHIMP_API_KEY');
        $server = env('MAILCHIMP_SERVER_PREFIX');
        $listId = env('MAILCHIMP_LIST_ID');

        $email  = $event["email"];
        $mcEvent = $event["event_name"];
        $properties = $payload["properties"];



        $this->upsertSubscriber($email, $properties, $listId, $server, $apiKey);
        $this->triggerEvent($email, $mcEvent, $properties, $listId, $server, $apiKey);
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
           $status = $mailchimp->lists->addListMember($listId, [
                "email_address" => $email,
                "status" => "subscribed",
                "tags" => [
                   $tags
                ],
                "merge_fields"  => [
                    "FNAME" => $fname,
                    "LNAME" => $lname,
                    "PHONE" => $phone,
                    "COMPANY" => "Siematplus"
                ],

            ]);
            return $status;

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

    // https://us1.api.mailchimp.com/3.0/lists/7fd34fd7a3/members/{subscriber_hash}/events
}
