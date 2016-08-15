<?php
/**
 * single_sidebox.php used to display a Zen Cart sidebox on some external resource
 *
 * @package general
 * @copyright Copyright 2003-2007 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: single_sidebox.php 2006-10-01 04:41:23Z drbyte $
 */
/*
 *   USAGE INSTRUCTIONS:
 *   1. Upload this single_sidebox.php file to the same folder as your Zen Cart files.
 *   2. On a PHP page where you desire to show Zen Cart sidebox content, insert the following code:
 *        $zcSBmodule = 'name.php';  // name of sidebox or centerbox to be displayed (see filenames in the /includes/modules/sideboxes folder) (if not set, uses "whats_new.php")
 *        $zcSBlayout = 'left';      // 'left' or 'right' sidebox template style (if not specified, uses 'left')
 *        require ("path/to/zencart/single_sidebox.php");
 *
 *
 *   DEFAULTS:
 *   $zcSBmodule = (if not set, uses "whats_new.php")
 *   $zcSBlayout = (optional) (if not specified, uses 'one')
 *   $zcSBwidth  = (optional) If not specified, uses Zen Cart store defaults
 *
*/
/******************** SINGLE_SIDEBOX.PHP SCRIPT CODE ********************/
/*
 * Determine working directory
 */
  $startingDir = getcwd();
  $zcDir = realpath(dirname(__FILE__));
  chdir($zcDir);
	define('STRICT_ERROR_REPORTING', false);
/*
 * Set default image dir, which overrides the usual Zen Cart settings in case the working dir is not the same
 */
  define('DIR_WS_IMAGES', $zcDir . '/images/');
/**
 * Load common library stuff 
 */
  require('includes/application_top.php');

 /**
  *   module and layout determination
	*/
  if (!isset($zcSBmodule)) $zcSBmodule = (isset($_GET['module'])) ? zen_db_input($_GET['module']) : 'whats_new.php';
  if (!isset($zcSBcolumn)) $zcSBcolumn = (isset($_GET['layout'])) ? zen_db_input($_GET['layout']) : 'left';
  if (!isset($zcSBwidth)) $zcSBwidth  = zen_db_input($_GET['width']);
  if (substr($zcSBmodule, -4) != '.php') $zcSBmodule .= '.php';
  $column_width = (int)$zcSBwidth;
  if ($column_width == 0) $column_width = ($zcSBcolumn == 'right') ? COLUMN_WIDTH_RIGHT : COLUMN_WIDTH_LEFT;
  $column_box_default = ($zcSBcolumn == 'right') ? 'tpl_box_default_right.php' : 'tpl_box_default_left.php';

/**
 * Load required functions and processing to generate the output:
 */
  $language_page_directory = DIR_WS_LANGUAGES . $_SESSION['language'] . '/';
  $box_id = zen_get_box_id($zcSBmodule);
/**
 * Cycle through possible override options, first for sideboxes, and then for modules if no matching sidebox found
 */
  $paths_to_try = array();
  $paths_to_try[] = DIR_WS_MODULES . 'sideboxes/' . $template_dir . '/' . $zcSBmodule;
  $paths_to_try[] = DIR_WS_MODULES . 'sideboxes/' . $zcSBmodule;
  $paths_to_try[] = DIR_WS_MODULES . $template_dir . '/' . $zcSBmodule;
  $paths_to_try[] = DIR_WS_MODULES . $zcSBmodule;
  $found_object = false;
  for ($i=0, $n=sizeof($paths_to_try); $i < $n; $i++) {
    if ( file_exists($zcDir . '/' . $paths_to_try[$i]) ) {
      $found_object = true;
      require($paths_to_try[$i]);
      break;
    }
  }
/**
 * If nothing found yet, assume regular template
 */
  if (!$found_object && file_exists($template->get_template_dir($zcSBmodule, DIR_WS_TEMPLATE, 'index', 'templates') . '/' . $zcSBmodule)) {
    require($template->get_template_dir($zcSBmodule, DIR_WS_TEMPLATE, 'index', 'templates') . '/' . $zcSBmodule);
  }
/**
 * Load general code which runs before page closes
 */
  require(DIR_WS_INCLUDES . 'application_bottom.php'); 
  chdir($startingDir);
?>