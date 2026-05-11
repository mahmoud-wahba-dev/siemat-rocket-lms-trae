<?php
namespace App\Http\Controllers\webhook;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use App\Services\MailchimpServices\MailchimpEventFormatter;
use App\Services\MailchimpServices\MailchimpSender;
use App\Http\Controllers\Controller;
use App\Models\WebhookEvent; // optional

class WebhookController extends Controller
{
    public function handle(Request $request)
    {

        $payload = $request->all();   // Raw POST data من Rocket LMS

        // 1) تحويل الحدث الخام → Mailchimp Event
        $formatted = MailchimpEventFormatter::format($payload);

        // 2) إرسال الحدث إلى Mailchimp Audience + Events API
        MailchimpSender::subscribed($formatted);

        return response()->json(['status' => 'ok'], 200);
    }
}
