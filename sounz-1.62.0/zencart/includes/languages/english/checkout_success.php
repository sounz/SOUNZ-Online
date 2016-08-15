<?php
/**
 * @package languageDefines
 * @copyright Copyright 2003-2006 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: checkout_success.php 5407 2006-12-27 01:35:37Z drbyte $
 */

define('NAVBAR_TITLE_1', 'Checkout');
define('NAVBAR_TITLE_2', 'Success - Thank You');

define('HEADING_TITLE', 'Thank you for shopping at SOUNZ');

define('TEXT_SUCCESS', '');
define('TEXT_NOTIFY_PRODUCTS', 'Please notify me of updates to these products');
define('TEXT_SEE_ORDERS', 'You can view your order history by going to the <a href="' . zen_href_link(FILENAME_ACCOUNT, '', 'SSL') . '">My Account</a> page and by clicking on \'Show all orders\'.');
define('TEXT_CONTACT_STORE_OWNER', 'Please direct any questions you have to <a href="mailto:info@sounz.org.nz">info@sounz.org.nz</a> or call us on (04) 801 8602.');
define('TEXT_THANKS_FOR_SHOPPING', 'Thanks for supporting New Zealand music!');

define('TABLE_HEADING_COMMENTS', '');

define('FOOTER_DOWNLOAD', 'You can also download files at the following link \'%s\'');

define('TEXT_YOUR_ORDER_NUMBER', '<strong>Your order number is:</strong> ');

define('TEXT_CHECKOUT_LOGOFF_GUEST', 'NOTE: To complete your order, a temporary account was created. You may close this account by clicking Log Off. Clicking Log Off also ensures that your receipt and purchase information is not visible to the next person using this computer. If you wish to continue shopping, feel free! You may log off at anytime using the link at the top of the page.');
define('TEXT_CHECKOUT_LOGOFF_CUSTOMER', 'Thank you for shopping. Click <a href="*FIXME*">here</a> to return to the SOUNZ Music Search');
?>
