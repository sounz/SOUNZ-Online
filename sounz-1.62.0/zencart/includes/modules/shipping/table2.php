<?php
/**
 * @package shippingMethod
 * @copyright Copyright 2003-2005 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: table.php 4184 2006-08-21 03:36:36Z ajeh $
 */
/**
 * Enter description here...
 *
 */
class table2 extends base {
  /**
   * Enter description here...
   *
   * @var unknown_type
   */
  var $code;
  /**
   * Enter description here...
   *
   * @var unknown_type
   */
  var $title;
  /**
   * Enter description here...
   *
   * @var unknown_type
   */
  var $description;
  /**
   * Enter description here...
   *
   * @var unknown_type
   */
  var $icon;
  /**
   * Enter description here...
   *
   * @var unknown_type
   */
  var $enabled;
  /**
   * Enter description here...
   *
   * @return table
   */
  function table2() {
    global $order, $db;

    $this->code = 'table2';
    $this->title = MODULE_SHIPPING_TABLE2_TEXT_TITLE;
    $this->description = MODULE_SHIPPING_TABLE2_TEXT_DESCRIPTION;
    $this->sort_order = MODULE_SHIPPING_TABLE2_SORT_ORDER;
    $this->icon = '';
    $this->tax_class = MODULE_SHIPPING_TABLE2_TAX_CLASS;
    $this->tax_basis = MODULE_SHIPPING_TABLE2_TAX_BASIS;
    // disable only when entire cart is free shipping
    if (zen_get_shipping_enabled($this->code)) {
      $this->enabled = ((MODULE_SHIPPING_TABLE2_STATUS == 'True') ? true : false);
    }

    if ( ($this->enabled == true) && ((int)MODULE_SHIPPING_TABLE2_ZONE > 0) ) {
      $check_flag = false;
    	if ($order->delivery['country']['id'] != '')
		{
	  $check = $db->Execute("select zone_id from " . TABLE_ZONES_TO_GEO_ZONES . " where geo_zone_id = '" . MODULE_SHIPPING_TABLE2_ZONE . "' and zone_country_id = '" . $order->delivery['country']['id'] . "' order by zone_id");
      }
		else
		{
		$check = $db->Execute("select zone_id from " . TABLE_ZONES_TO_GEO_ZONES . " where geo_zone_id = '" . MODULE_SHIPPING_TABLE2_ZONE . "' order by zone_id");
		}

	while (!$check->EOF) {
        if ($check->fields['zone_id'] < 1) {
          $check_flag = true;
          break;
        } elseif ($check->fields['zone_id'] == $order->delivery['zone_id']) {
          $check_flag = true;
          break;
        }
        $check->MoveNext();
      }

      if ($check_flag == false) {
        $this->enabled = false;
      }
    }
  }
  /**
   * Enter description here...
   *
   * @param unknown_type $method
   * @return unknown
   */
  function quote($method = '') {
    global $order, $shipping_weight, $shipping_num_boxes, $total_count;

    // shipping adjustment
    switch (MODULE_SHIPPING_TABLE2_MODE) {
      case ('price'):
        $order_total = $_SESSION['cart']->show_total() - $_SESSION['cart']->free_shipping_prices() ;
        break;
      case ('weight'):
        $order_total = $shipping_weight;
        break;
      case ('item'):
        $order_total = $total_count - $_SESSION['cart']->free_shipping_items();
        break;
    }

    $table_cost = preg_split("/[:,]/" , MODULE_SHIPPING_TABLE2_COST);
    $size = sizeof($table_cost);
    for ($i=0, $n=$size; $i<$n; $i+=2) {
      if (round($order_total,9) <= $table_cost[$i]) {
        $shipping = $table_cost[$i+1];
        break;
      }
    }

    if (MODULE_SHIPPING_TABLE2_MODE == 'weight') {
      $shipping = $shipping * $shipping_num_boxes;
      // show boxes if weight
      switch (SHIPPING_BOX_WEIGHT_DISPLAY) {
        case (0):
        $show_box_weight = '';
        break;
        case (1):
        $show_box_weight = ' (' . $shipping_num_boxes . ' ' . TEXT_SHIPPING_BOXES . ')';
        break;
        case (2):
        $show_box_weight = ' (' . number_format($shipping_weight * $shipping_num_boxes,2) . TEXT_SHIPPING_WEIGHT . ')';
        break;
        default:
        $show_box_weight = ' (' . $shipping_num_boxes . ' x ' . number_format($shipping_weight,2) . TEXT_SHIPPING_WEIGHT . ')';
        break;
      }
    }

    $this->quotes = array('id' => $this->code,
    'module' => MODULE_SHIPPING_TABLE2_TEXT_TITLE . $show_box_weight,
    'methods' => array(array('id' => $this->code,
    'title' => MODULE_SHIPPING_TABLE2_TEXT_WAY,
    'cost' => $shipping + MODULE_SHIPPING_TABLE2_HANDLING)));

    if ($this->tax_class > 0) {
      $this->quotes['tax'] = zen_get_tax_rate($this->tax_class, $order->delivery['country']['id'], $order->delivery['zone_id']);
    }

    if (zen_not_null($this->icon)) $this->quotes['icon'] = zen_image($this->icon, $this->title);

    return $this->quotes;
  }
  /**
   * Enter description here...
   *
   * @return unknown
   */
  function check() {
    global $db;
    if (!isset($this->_check)) {
      $check_query = $db->Execute("select configuration_value from " . TABLE_CONFIGURATION . " where configuration_key = 'MODULE_SHIPPING_TABLE2_STATUS'");
      $this->_check = $check_query->RecordCount();
    }
    return $this->_check;
  }
  /**
   * Enter description here...
   *
   */
  function install() {
    global $db;
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Enable Table Method', 'MODULE_SHIPPING_TABLE2_STATUS', 'True', 'Do you want to offer table rate shipping?', '6', '0', 'zen_cfg_select_option(array(\'True\', \'False\'), ', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Shipping Table', 'MODULE_SHIPPING_TABLE2_COST', '25:8.50,50:5.50,10000:0.00', 'The shipping cost is based on the total cost or weight of items or count of the items. Example: 25:8.50,50:5.50,etc.. Up to 25 charge 8.50, from there to 50 charge 5.50, etc', '6', '0', 'zen_cfg_textarea(', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Table Method', 'MODULE_SHIPPING_TABLE2_MODE', 'weight', 'The shipping cost is based on the order total or the total weight of the items ordered or the total number of items orderd.', '6', '0', 'zen_cfg_select_option(array(\'weight\', \'price\', \'item\'), ', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Handling Fee', 'MODULE_SHIPPING_TABLE2_HANDLING', '0', 'Handling fee for this shipping method.', '6', '0', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('Tax Class', 'MODULE_SHIPPING_TABLE2_TAX_CLASS', '0', 'Use the following tax class on the shipping fee.', '6', '0', 'zen_get_tax_class_title', 'zen_cfg_pull_down_tax_classes(', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Tax Basis', 'MODULE_SHIPPING_TABLE2_TAX_BASIS', 'Shipping', 'On what basis is Shipping Tax calculated. Options are<br />Shipping - Based on customers Shipping Address<br />Billing Based on customers Billing address<br />Store - Based on Store address if Billing/Shipping Zone equals Store zone', '6', '0', 'zen_cfg_select_option(array(\'Shipping\', \'Billing\', \'Store\'), ', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('Shipping Zone', 'MODULE_SHIPPING_TABLE2_ZONE', '0', 'If a zone is selected, only enable this shipping method for that zone.', '6', '0', 'zen_get_zone_class_title', 'zen_cfg_pull_down_zone_classes(', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_SHIPPING_TABLE2_SORT_ORDER', '0', 'Sort order of display.', '6', '0', now())");
  }
  /**
   * Enter description here...
   *
   */
  function remove() {
    global $db;
    $db->Execute("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
  }
  /**
   * Enter description here...
   *
   * @return unknown
   */
  function keys() {
    return array('MODULE_SHIPPING_TABLE2_STATUS', 'MODULE_SHIPPING_TABLE2_COST', 'MODULE_SHIPPING_TABLE2_MODE', 'MODULE_SHIPPING_TABLE2_HANDLING', 'MODULE_SHIPPING_TABLE2_TAX_CLASS', 'MODULE_SHIPPING_TABLE2_TAX_BASIS', 'MODULE_SHIPPING_TABLE2_ZONE', 'MODULE_SHIPPING_TABLE2_SORT_ORDER');
  }
}
?>