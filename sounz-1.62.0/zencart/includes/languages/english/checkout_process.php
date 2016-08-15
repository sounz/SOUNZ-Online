<?php
//
// +----------------------------------------------------------------------+
// |zen-cart Open Source E-commerce                                       |
// +----------------------------------------------------------------------+
// | Copyright (c) 2003 The zen-cart developers                           |
// |                                                                      |
// | http://www.zen-cart.com/index.php                                    |
// |                                                                      |
// | Portions Copyright (c) 2003 osCommerce                               |
// +----------------------------------------------------------------------+
// | This source file is subject to version 2.0 of the GPL license,       |
// | that is bundled with this package in the file LICENSE, and is        |
// | available through the world-wide-web at the following url:           |
// | http://www.zen-cart.com/license/2_0.txt.                             |
// | If you did not receive a copy of the zen-cart license and are unable |
// | to obtain it through the world-wide-web, please send a note to       |
// | license@zen-cart.com so we can mail you a copy immediately.          |
// +----------------------------------------------------------------------+
// $Id: checkout_process.php 1969 2005-09-13 06:57:21Z drbyte $
//

define('EMAIL_TEXT_SUBJECT', 'Order Confirmation');
define('EMAIL_TEXT_HEADER', 'Order Confirmation');
define('EMAIL_TEXT_FROM',' from ');  //added to the EMAIL_TEXT_HEADER, above on text-only emails
define('EMAIL_THANKS_FOR_SHOPPING','Thank you for supporting the music of New Zealand composers');
define('EMAIL_DOWNLOAD_PREAMBLE','<p>For each score or recording purchased a commission is paid to the composer and other copyright owners.</p> 
<p>Please note that payment for this download constitutes your agreement to the <a href="http://www.sounz.org.nz/cm_contents/show/11">Terms and Conditions of Online Membership</a> which are available on the SOUNZ website. We recommend reading these carefully.</p>
<p>You will have three days in which to action your download purchase and will be allowed three attempts. If you experience any difficulties in obtaining the files then please contact us. Details are in the signature of this email or on the SOUNZ website.</p>');

define ('EMAIL_DOWNLOAD_POST','<p>If you are involved in performances of this work(s), then we appreciate your advising SOUNZ (<a href="mailto://info@sounz.org.nz">info@sounz.org.nz</a>) and the Australasian Performing Rights Association (<a href="mailto://nz@apra.com.au">nz@apra.com.au</a> or <a href="http://www.apra.co.nz">www.apra.co.nz</a>)</p>
<p>Warm regards,<br/>
SOUNZ Information Services Team</p>
<hr/>
<p>SOUNZ, the Centre for New Zealand Music<br/>
Promoting the music of New Zealand\'s composers</p>
<p>
<table>
<tr><td>Mail:</td><td>PO Box 27347, Marion Square, Wellington 6141</td></tr>
<tr><td>Visit:</td><td>Level 3, Toi Poneke Arts Centre, 61 Abel Smith Street, Te Aro, Wellington 6011</td></tr>
<tr><td>Phone:</td><td>(64 4) 801 8602 Fax: (64 4) 801 8604</td></tr>
<tr><td>Email:</td><td><a href="mailto://info@sounz.org.nz">info@sounz.org.nz</a></td></tr>
<tr><td>Website:</td><td>< a href="http://www.sounz.org.nz">www.sounz.org.nz</a></td></tr>
</table>
<p><b>Created in New Zealand, heard around the world!<br/> 
Toi Te Arapuoru - tipua i Aotearoa, rangona e te ao!</b></p>');

define('EMAIL_DETAILS_FOLLOW','The following are the details of your order.');
define('EMAIL_TEXT_ORDER_NUMBER', 'Order Number:');
define('EMAIL_TEXT_INVOICE_URL', 'Detailed Invoice/ Download page):');
define('EMAIL_TEXT_INVOICE_URL_CLICK', 'Click here for a Detailed Invoice');
define('EMAIL_TEXT_DATE_ORDERED', 'Date Ordered:');
define('EMAIL_TEXT_PRODUCTS', 'Products');
define('EMAIL_TEXT_SUBTOTAL', 'Sub-Total:');
define('EMAIL_TEXT_TAX', 'Tax:        ');
define('EMAIL_TEXT_SHIPPING', 'Shipping: ');
define('EMAIL_TEXT_TOTAL', 'Total:    ');
define('EMAIL_TEXT_DELIVERY_ADDRESS', 'Delivery Address');
define('EMAIL_TEXT_BILLING_ADDRESS', 'Billing Address');
define('EMAIL_TEXT_PAYMENT_METHOD', 'Payment Method');

define('EMAIL_SEPARATOR', '------------------------------------------------------');
define('TEXT_EMAIL_VIA', 'via');

// suggest not using # vs No as some spamm protection block emails with these subjects
define('EMAIL_ORDER_NUMBER_SUBJECT', ' No: ');
define('HEADING_ADDRESS_INFORMATION','Address Information');
define('HEADING_SHIPPING_METHOD','Shipping Method');
?>