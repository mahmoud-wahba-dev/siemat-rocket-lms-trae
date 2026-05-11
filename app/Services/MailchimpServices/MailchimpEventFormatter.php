<?php

namespace App\Services\MailchimpServices;

class MailchimpEventFormatter
{
    public static function format($payload)
    {
        $event = $payload['event'];
        $data  = $payload['data'];

        // Split full name into first and last name
        $fullName = trim($data['user_name'] ?? '');
        $nameParts = explode(' ', $fullName, 2);

        $firstName = $nameParts[0] ?? null;
        $lastName  = $nameParts[1] ?? null;

        return [
            "event_name" => $event,
            "email"      => $data['user_email'],
            "tags"       => $data['tags'] ?? null,
            "properties" => [
                "FNAME" => $firstName,
                "LNAME" => $lastName,
                "PHONE"        => $data['mobile'] ?? null,
                "date"        => $data['date'] ?? null,

            ]
        ];
    }
}
