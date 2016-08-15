<?php
/*
  $Id: nochex.php,v 1.12 2003/01/29 19:57:15 hpdl Exp $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2003 osCommerce

  Released under the GNU General Public License
*/
include_once "pxaccess.inc";
  class dpsaccess {
    
    var $code, $title, $description, $enabled;
   
// class constructor
    function dpsaccess() {
      global $order;

      $this->code = 'dpsaccess';
      $this->title = MODULE_PAYMENT_DPSACCESS_TEXT_TITLE;
      $this->description = MODULE_PAYMENT_DPSACCESS_TEXT_DESCRIPTION;
      $this->sort_order = MODULE_PAYMENT_DPSACCESS_SORT_ORDER;
      $this->enabled = ((MODULE_PAYMENT_DPSACCESS_STATUS == 'True') ? true : false);

      if ((int)MODULE_PAYMENT_DPSACCESS_ORDER_STATUS_ID > 0) {
        $this->order_status = MODULE_PAYMENT_DPSACCESS_ORDER_STATUS_ID;
      }

      if (is_object($order)) $this->update_status();
        
      $this->form_action_url = MODULE_PAYMENT_DPSACCESS_URL;
    }

// class methods
    function update_status() {
      global $order;
	  global $db;

      if ( ($this->enabled == true) && ((int)MODULE_PAYMENT_DPSACCESS_ZONE > 0) ) {
        $check_flag = false;
        if ($order->billing['country']['id']=='' )
		{
		$check_query = $db->Execute("select zone_id from " . TABLE_ZONES_TO_GEO_ZONES . " where geo_zone_id = '" . MODULE_PAYMENT_DPSACCESS_ZONE . "' order by zone_id");
		}
		else
		{
		$check_query = $db->Execute("select zone_id from " . TABLE_ZONES_TO_GEO_ZONES . " where geo_zone_id = '" . MODULE_PAYMENT_DPSACCESS_ZONE . "' and zone_country_id = '" . $order->billing['country']['id'] . "' order by zone_id");
        }
		while (!$check_query->EOF) 
		{
       if ($check_query['zone_id'] < 1) 
			{
            $check_flag = true;
        	break;
			}
	   elseif ($check_query['zone_id'] == $order->billing['zone_id']) 
			{
            $check_flag = true;
            break;
			}
		$check_query->MoveNext();
		}

        if ($check_flag == false) {
          $this->enabled = false;
        }
      }
    }

    function javascript_validation() {
      return false;
    }

    function selection() {
      return array('id' => $this->code,
                   'module' => $this->title);
    }

    function pre_confirmation_check() {
      return false;
    }

    function confirmation() {
      
      $this->form_action_url=MODULE_PAYMENT_DPSACCESS_URL;
      return false;
    }

    function process_button() {
      global $order, $currencies, $customer_id,$session;

  $pxaccess = new PxAccess(MODULE_PAYMENT_DPSACCESS_URL,MODULE_PAYMENT_DPSACCESS_USERID,MODULE_PAYMENT_DPSACCESS_DESKEY,MODULE_PAYMENT_DPSACCESS_MACKEY);
  $request = new PxPayRequest();
  
  $http_host   = getenv("HTTP_HOST");
  $server_url  = "http://$http_host";
//  $script_url = (version_compare(PHP_VERSION, "4.3.4", ">=")) ? "$server_url" : "$server_url/";
  $script_url = $server_url;
  $script_url .= DIR_WS_CATALOG . "payment_response.php";
//  $script_url .= DIR_WS_HTTP_CATALOG . "includes/PXAccess_Sample.php";

  
  # the following variables are read from the form
  #Set up PxPayRequest Object
  $request->setAmountInput( number_format($order->info['total'] * $currencies->currencies['NZD']['value'], $currencies->currencies['NZD']['decimal_places']) );
  $request->setTxnData1( STORE_NAME . ' order' );# whatever you want to appear
  $request->setTxnData2( $_SESSION['zen_id'] );		# whatever you want to appear
  $request->setTxnData3('working');		# whatever you want to appear
  $request->setTxnType("Purchase");
  $request->setInputCurrency("NZD");
  $request->setMerchantReference( STORE_NAME . $customer_id . '-' . date('Ymdhis') ); # fill this with your order number
  $request->setEmailAddress( '' ); // RGS Not right, but hey
  $request->setUrlFail($script_url);
  $request->setUrlSuccess($script_url);
  
  
  #Call makeResponse of PxAccess object to obtain the 3-DES encrypted payment request 
  $request_string = $pxaccess->makeRequest($request);

//      $process_button_string = '</form><form action="'.$request_string.'" method="GET"><INPUT TYPE="HIDDEN" NAME="userid" VALUE="'.MODULE_PAYMENT_DPSACCESS_USERID.'"><INPUT TYPE="HIDDEN" NAME="request" VALUE="'.$request_string.'">';
//      $process_button_string = '</form>';
      $process_button_string .= '<a href="' . $request_string . '">';
//      $process_button_string .= '<form action="'.$request_string.'" method="POST">';

      return $process_button_string;
    }

    function before_process() {
      
      return false;
    }

    function after_process() {
      
      return false;
    }

    function output_error() {
      return false;
    }

    function check() {
		global $db;
      if (!isset($this->_check)) {
        $check_query = $db->Execute("select configuration_value from " . TABLE_CONFIGURATION . " where configuration_key = 'MODULE_PAYMENT_DPSACCESS_STATUS'");
        $this->_check = $check_query->RecordCount();
      }
      return $this->_check;
    }

    function install() {
	  global $db;
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('Enable DPS ACCESS Module', 'MODULE_PAYMENT_DPSACCESS_STATUS', 'True', 'Do you want to accept DPS ACCESS payments?', '6', '3', 'zen_cfg_select_option(array(\'True\', \'False\'), ', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('DPS Access URL', 'MODULE_PAYMENT_DPSACCESS_URL', 'supplied by DPS', 'The URL for the PxAccess service', '6', '4', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('DPS Access UserID', 'MODULE_PAYMENT_DPSACCESS_USERID', 'supplied by DPS', 'The User ID for your online store', '6', '4', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('DPS Access DES Key', 'MODULE_PAYMENT_DPSACCESS_DESKEY', 'supplied by DPS', 'The DES Key for your online store', '6', '4', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('DPS Access MAC Key', 'MODULE_PAYMENT_DPSACCESS_MACKEY', 'supplied by DPS', 'The MAC Key for your online store', '6', '4', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort order of display.', 'MODULE_PAYMENT_DPSACCESS_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', '6', '0', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('Payment Zone', 'MODULE_PAYMENT_DPSACCESS_ZONE', '0', 'If a zone is selected, only enable this payment method for that zone.', '6', '2', 'zen_get_zone_class_title', 'zen_cfg_pull_down_zone_classes(', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added) values ('Set Order Status', 'MODULE_PAYMENT_DPSACCESS_ORDER_STATUS_ID', '0', 'Set the status of orders made with this payment module to this value', '6', '0', 'zen_cfg_pull_down_order_statuses(', 'zen_get_order_status_name', now())");
    }

    function remove() {
      global $db;
		$db->Execute("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULE_PAYMENT_DPSACCESS_STATUS', 'MODULE_PAYMENT_DPSACCESS_URL','MODULE_PAYMENT_DPSACCESS_USERID', 'MODULE_PAYMENT_DPSACCESS_DESKEY', 'MODULE_PAYMENT_DPSACCESS_MACKEY', 'MODULE_PAYMENT_DPSACCESS_ZONE', 'MODULE_PAYMENT_DPSACCESS_ORDER_STATUS_ID', 'MODULE_PAYMENT_DPSACCESS_SORT_ORDER');
    }
  }
?>
