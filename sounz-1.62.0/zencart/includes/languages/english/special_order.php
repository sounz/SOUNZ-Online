<?php
/**
 * @package languageDefines
 * @copyright Copyright 2003-2006 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: shopping_cart.php 3183 2006-03-14 07:58:59Z birdbrain $
 */

define('NAVBAR_TITLE', 'Special Order');
define('HEADING_TITLE', 'Special Order');

define('EMAIL_TEXT_SUBJECT', 'Special Order Confirmation');
define('EMAIL_TEXT_HEADER', 'Special Order Confirmation');
define('EMAIL_TEXT_FROM',' from ');  //added to the EMAIL_TEXT_HEADER, above on text-only emails
define('EMAIL_THANKS_FOR_SHOPPING','Thank you for supporting the music of New Zealand composers');

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
define('SPECIAL_ORDER_NOTE', 'A Special Order has been raised for one of the following reasons:
- your order exceeded 2kg in weight
- the item/s requested require/s special shipping
- you are borrowing library item/s which need to be shipped outside NZ

A member of SOUNZ staff will be in contact to confirm and arrange details.');

define('EMAIL_SEPARATOR', '------------------------------------------------------');
define('TEXT_EMAIL_VIA', 'via');

// suggest not using # vs No as some spamm protection block emails with these subjects
define('EMAIL_ORDER_NUMBER_SUBJECT', ' No: ');
define('HEADING_ADDRESS_INFORMATION','Address Information');
define('HEADING_SHIPPING_METHOD','Shipping Method');

?>
