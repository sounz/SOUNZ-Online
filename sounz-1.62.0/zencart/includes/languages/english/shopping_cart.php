<?php
/**
 * @package languageDefines
 * @copyright Copyright 2003-2006 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: shopping_cart.php 3183 2006-03-14 07:58:59Z birdbrain $
 */

define('NAVBAR_TITLE', 'The Shopping Cart');
define('HEADING_TITLE', 'Your Shopping Cart Contents');
define('HEADING_TITLE_EMPTY', 'Your Shopping Cart');
define('TEXT_INFORMATION', '<p>Credit Card payments on this site are processed by DPS Ltd. We accept Mastercard or Visa</p><p>All prices on this site are listed in New Zealand Dollars. Please read the <a href="http://'.SOUNZ_SERVER.'/cm_contents/show/12" target="_new">terms and conditions</a> for sales from this site before making an order.</p>
<p>You can contact SOUNZ by phone: +64 4 801 8602 or email: <a href="mailto:info@sounz.org.nz">info@sounz.org.nz</a>.</p>
<p>For full contact details, please <a href="http://'.SOUNZ_SERVER.'/content/contact" target="_new">click here</a>.</p>
<p>If you have items marked \'<b><font color="#f00">Special Order Only</font></b>\' in your cart, or your total order exceeds 2kg in weight, you can still proceed by clicking \'Checkout\' below.</p>
<p>A Special Order will be raised, and a member of SOUNZ staff will be in contact to confirm and arrange details.</p>
');
define('TABLE_HEADING_REMOVE', 'Remove');
define('TABLE_HEADING_QUANTITY', 'Qty.');
define('TABLE_HEADING_MODEL', 'Model');
define('TABLE_HEADING_PRICE','Unit');
define('TEXT_CART_EMPTY', 'Your Shopping Cart is empty.');
define('SUB_TITLE_SUB_TOTAL', 'Sub-Total:');
define('SUB_TITLE_TOTAL', 'Total:');

define('OUT_OF_STOCK_CANT_CHECKOUT', 'Products marked with ' . STOCK_MARK_PRODUCT_OUT_OF_STOCK . ' are out of stock or there are not enough in stock to fill your order.<br />Please change the quantity of products marked with (' . STOCK_MARK_PRODUCT_OUT_OF_STOCK . '). Thank you');
define('OUT_OF_STOCK_CAN_CHECKOUT', 'Products marked with ' . STOCK_MARK_PRODUCT_OUT_OF_STOCK . ' are out of stock.<br />Items not in stock will be placed on backorder.');

define('TEXT_TOTAL_ITEMS', 'Total Items: ');
define('TEXT_TOTAL_WEIGHT', '&nbsp;&nbsp;Weight: ');
define('TEXT_TOTAL_AMOUNT', '&nbsp;&nbsp;Amount: ');

define('TEXT_VISITORS_CART', '');
define('TEXT_OPTION_DIVIDER', '&nbsp;-&nbsp;');
?>
