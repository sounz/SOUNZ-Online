<?php

include "pxaccess.inc";

require('includes/application_top.php');

  //
  // MAIN
  //
  $pxaccess = new PxAccess(MODULE_PAYMENT_DPSACCESS_URL,MODULE_PAYMENT_DPSACCESS_USERID,MODULE_PAYMENT_DPSACCESS_DESKEY,MODULE_PAYMENT_DPSACCESS_MACKEY);
  
  //we need to unpack our response var, retrieve the session id passed through, and set the location header to the correct destination url.
  $enc_hex = $_REQUEST['result'];
  //getResponse method in PxAccess object returns PxPayResponse object 
  //which encapsulates all the response data
  $rsp = $pxaccess->getResponse($enc_hex);
  
  if ($rsp->getStatusRequired() == "1")
  {
    $result = "An error has occurred.";
  }
  elseif ($rsp->getSuccess() == "1")
  {
    $result = "The transaction was approved.";
  }
  else
  {
    $result = "The transaction was declined.";
  }

  // the following are the fields available in the PxPayResponse object
  $Success           = $rsp->getSuccess();   // =1 when request succeeds
  $Retry             = $rsp->getRetry();     // =1 when a retry might help
  $StatusRequired    = $rsp->getStatusRequired();      // =1 when transaction "lost"
  $AmountSettlement  = $rsp->getAmountSettlement();    
  $AuthCode          = $rsp->getAuthCode();  // from bank
  $CardName          = $rsp->getCardName();  // e.g. "Visa"
  $DpsTxnRef         = $rsp->getDpsTxnRef();

  // the following values are returned, but are from the original request
  $TxnType           = $rsp->getTxnType();
  $TxnData1          = $rsp->getTxnData1();
  $TxnData2          = $rsp->getTxnData2();
  $TxnData3          = $rsp->getTxnData3();
  $CurrencyInput     = $rsp->getCurrencyInput();
  $EmailAddress      = $rsp->getEmailAddress();
  $MerchantReference = $rsp->getMerchantReference();

  // is there a nice way to print all the XML values returned?
  // We used TxnData2 to store the session id
  //  we'll use it to rest up the session
  if ( isset( $TxnData2 ) )
  {   
  session_id( $TxnData2 );
  zen_session_id( $TxnData2 );
  //tep_session_start();
  }
  else
  {
    $Success = 0;
  }

	if ( $Success == 1 )
  { 
    $redirect_url= HTTP_SERVER . DIR_WS_CATALOG . 'index.php?main_page=checkout_process';
  }
	else
  {
    $redirect_url= HTTP_SERVER . DIR_WS_CATALOG . 'index.php?main_page=checkout_confirmation';
  }
zen_redirect($redirect_url, 'zenid=' . $session , 'SSL', false, false);

?>
