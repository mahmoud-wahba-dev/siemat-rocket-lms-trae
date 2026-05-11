<?php

return [

    'driver' => env('NEWSLETTER_DRIVER', Spatie\Newsletter\Drivers\MailchimpDriver::class),

    'driver_arguments' => [
        'api_key' => env('NEWSLETTER_API_KEY'),
        'server_prefix' => env('NEWSLETTER_SERVER_PREFIX'),
    ],

    'default_list_name' => 'subscribers',

    'lists' => [
        'subscribers' => [
            'id' => env('NEWSLETTER_LIST_ID'),
        ],
    ],
];
