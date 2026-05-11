<?php

namespace App\Services\MailchimpServices;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class WebhookService
{
    public static function send($eventName, $payload)
    {
        $url = env('MAILCHIMP_MIDDLEWARE_URL');


        if(!$url){
            Log::error("Middleware URL not set");
            return false;
        }

        $body = [
            "event" => $eventName,
            "data"  => $payload
        ];

        try {
          return Http::post($url, $body);
        } catch (\Exception $e) {
            Log::error("Webhook send error: " . $e->getMessage());
        }
    }
}
