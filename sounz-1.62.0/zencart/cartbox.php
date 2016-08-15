<?php
$zcSBmodule = 'shopping_cart.php';  // name of sidebox or centerbox to be displayed (see filenames in the /includes/modules/sideboxes folder) (if not set, uses "whats_new.php")
$zcSBlayout = 'left';      // 'left' or 'right' sidebox template style (if not specified, uses 'left')
#require ("/var/www/zencart/single_sidebox.php");
require dirname(__FILE__) . "/single_sidebox.php";
?>
