<?php
/**
 * @package languageDefines
 * @copyright Copyright 2003-2006 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: index.php 6531 2007-06-26 00:55:30Z drbyte $
 */

define('TEXT_MAIN','This is the main define statement for the page for english when no template defined file exists. It is located in: <strong>/includes/languages/english/index.php</strong>');

// Showcase vs Store
if (STORE_STATUS == '0') {
  define('TEXT_GREETING_GUEST', 'Your session has timed out. Please return to the SOUNZ Music Search and try checking out again.');
} else {
  define('TEXT_GREETING_GUEST', '');
}

define('TEXT_GREETING_PERSONAL', 'Hello <span class="greetUser">%s, You have reached the SOUNZ Online store.<p> Your session has timed out, or you have reached this page in error. Please return to the SOUNZ Music Search and try checking out again.</span>');

define('TEXT_INFORMATION', 'Click the link above to return to the SOUNZ Music Search');

//moved to english
//define('TABLE_HEADING_FEATURED_PRODUCTS','Featured Products');

//define('TABLE_HEADING_NEW_PRODUCTS', 'New Products For %s');
//define('TABLE_HEADING_UPCOMING_PRODUCTS', 'Upcoming Products');
//define('TABLE_HEADING_DATE_EXPECTED', 'Date Expected');

if ( ($category_depth == 'products') || (zen_check_url_get_terms()) ) {
  // This section deals with product-listing page contents
  define('HEADING_TITLE', 'Available Products');
  define('TABLE_HEADING_IMAGE', 'Product Image');
  define('TABLE_HEADING_MODEL', 'Model');
  define('TABLE_HEADING_PRODUCTS', 'Product Name');
  define('TABLE_HEADING_MANUFACTURER', 'Manufacturer');
  define('TABLE_HEADING_QUANTITY', 'Quantity');
  define('TABLE_HEADING_PRICE', 'Price');
  define('TABLE_HEADING_WEIGHT', 'Weight');
  define('TABLE_HEADING_BUY_NOW', 'Buy Now');
  define('TEXT_NO_PRODUCTS', 'There are no products to list in this category.');
  define('TEXT_NO_PRODUCTS2', 'There is no product available from this manufacturer.');
  define('TEXT_NUMBER_OF_PRODUCTS', 'Number of Products: ');
  define('TEXT_SHOW', 'Filter Results by:');
  define('TEXT_BUY', 'Buy 1 \'');
  define('TEXT_NOW', '\' now');
  define('TEXT_ALL_CATEGORIES', 'All Categories');
  define('TEXT_ALL_MANUFACTURERS', 'All Manufacturers');
} elseif ($category_depth == 'top') {
  // This section deals with the "home" page at the top level with no options/products selected
  /*Replace this text with the headline you would like for your shop. For example: 'Welcome to My SHOP!'*/
  define('HEADING_TITLE', 'SOUNZ Online Store');
} elseif ($category_depth == 'nested') {
  // This section deals with displaying a subcategory
  /*Replace this line with the headline you would like for your shop. For example: 'Welcome to My SHOP!'*/
  define('HEADING_TITLE', 'SOUNZ Online Store'); 
}
?>
