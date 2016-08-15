<?php
/**
 * checkout_success header_php.php
 *
 * @package page
 * @copyright Copyright 2003-2006 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: header_php.php 3160 2006-03-11 01:37:18Z drbyte $
 */

// This should be first line of the script:
$zco_notifier->notify('NOTIFY_HEADER_START_SPECIAL_ORDER');

require(DIR_WS_MODULES . zen_get_module_directory('require_languages.php'));

// if the customer is not logged on, redirect them to the shopping cart page
if (!$_SESSION['customer_id']) {
  zen_redirect(zen_href_link(FILENAME_TIME_OUT));
}

require(DIR_WS_CLASSES . 'order.php');
$order = new order;

if (sizeof($order->products) < 1) {
  zen_redirect(zen_href_link(FILENAME_SHOPPING_CART));
}

require(DIR_WS_CLASSES . 'order_total.php');
$order_total_modules = new order_total;

$zco_notifier->notify('NOTIFY_CHECKOUT_PROCESS_BEFORE_ORDER_TOTALS_PRE_CONFIRMATION_CHECK');

$order_totals = $order_total_modules->pre_confirmation_check();

$zco_notifier->notify('NOTIFY_CHECKOUT_PROCESS_BEFORE_ORDER_TOTALS_PROCESS');
$order_totals = $order_total_modules->process();


$order->info['order_status']=5;
$insert_id = $order->create($order_totals, 2);
$zco_notifier->notify('NOTIFY_CHECKOUT_PROCESS_AFTER_ORDER_CREATE');

// store the product info to the order
$order->create_add_products($insert_id);
$_SESSION['order_number_created'] = $insert_id;
$zco_notifier->notify('NOTIFY_CHECKOUT_PROCESS_AFTER_ORDER_CREATE_ADD_PRODUCTS');

$order->send_order_email($insert_id, 2);
$zco_notifier->notify('NOTIFY_CHECKOUT_PROCESS_AFTER_SEND_ORDER_EMAIL');

$_SESSION['cart']->reset(true);


#$define_page = zen_get_file_directory(DIR_WS_LANGUAGES . $_SESSION['language'] . '/html_includes/', FILENAME_SPECIAL_ORDER, 'false');
$breadcrumb->add(NAVBAR_TITLE);

?>
