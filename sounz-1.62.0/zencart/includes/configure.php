<?php
/**
 *
 * @package Configuration Settings
 * @copyright Copyright 2003-2006 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 */


/*************** NOTE: This file is similar, but DIFFERENT from the "admin" version of configure.php. ***********/
/***************       The 2 files should be kept separate and not used to overwrite each other.      ***********/

// Define the webserver and path parameters
  // HTTP_SERVER is your Main webserver: eg, http://www.yourdomain.com
  // HTTPS_SERVER is your Secure webserver: eg, https://www.yourdomain.com
  define('HTTP_SERVER', 'http://'.$_SERVER['SERVER_NAME']);
  define('HTTPS_SERVER', 'http://'.$_SERVER['SERVER_NAME']);
  define('SOUNZ_SERVER', $_SERVER['SERVER_NAME']);
  // Use secure webserver for checkout procedure?
  define('ENABLE_SSL', 'false');

  define('SOUNZ_BORROWED_ITEMS_TABLE','borrowed_items');
  define('SOUNZ_SERVICES_TABLE','sounz_services');
  define('SOUNZ_LOAN_PERIOD','60d');	
  
  #temporary setting
  define ('MONEYWORKS_EXPORT_FOLDER','/tmp');
	 
  #DEPRECATED - see application_top.php	 
  #define('SOUNZ_TEST_MODE','false');


  // NOTE: be sure to leave the trailing '/' at the end of these lines if you make changes!
  // * DIR_WS_* = Webserver directories (virtual/URL)
  // these paths are relative to top of your webspace ... (ie: under the public_html or httpdocs folder)
  define('DIR_WS_CATALOG', '/zencart/');
  define('DIR_WS_HTTPS_CATALOG', '/zencart/');

  define('DIR_WS_IMAGES', 'images/');
  define('DIR_WS_INCLUDES', 'includes/');
  define('DIR_WS_FUNCTIONS', DIR_WS_INCLUDES . 'functions/');
  define('DIR_WS_CLASSES', DIR_WS_INCLUDES . 'classes/');
  define('DIR_WS_MODULES', DIR_WS_INCLUDES . 'modules/');
  define('DIR_WS_LANGUAGES', DIR_WS_INCLUDES . 'languages/');
  define('DIR_WS_DOWNLOAD_PUBLIC', DIR_WS_CATALOG . 'pub/');
  define('DIR_WS_TEMPLATES', DIR_WS_INCLUDES . 'templates/');

  define('DIR_WS_PHPBB', '/');

  // * DIR_FS_* = Filesystem directories (local/physical)
  //the following path is a COMPLETE path to your Zen Cart files. eg: /var/www/vhost/accountname/public_html/store/
  define('DIR_FS_CATALOG', '/data/sounz/htdocs/zencart/');

  define('DIR_FS_DOWNLOAD', DIR_FS_CATALOG . 'download/');
  define('DIR_FS_DOWNLOAD_PUBLIC', DIR_FS_CATALOG . 'pub/');
  define('DIR_WS_UPLOADS', DIR_WS_IMAGES . 'uploads/');
  define('DIR_FS_UPLOADS', DIR_FS_CATALOG . DIR_WS_UPLOADS);
  define('DIR_FS_EMAIL_TEMPLATES', DIR_FS_CATALOG . 'email/');

  // define our database connection
  define('DB_TYPE', 'pgsql');
  define('DB_PREFIX', 'zencart');
  define('DB_SERVER', 'localhost');
  define('DB_SERVER_USERNAME', 'sounz');
  define('DB_SERVER_PASSWORD', 's0unz');
  define('DB_DATABASE', 'sounz');
  define('USE_PCONNECT', 'false'); // use persistent connections?
  define('STORE_SESSIONS', 'db'); // use 'db' for best support, or '' for file-based storage

  // The next 2 "defines" are for SQL cache support.
  // For SQL_CACHE_METHOD, you can select from:  none, database, or file
  // If you choose "file", then you need to set the DIR_FS_SQL_CACHE to a directory where your apache 
  // or webserver user has write privileges (chmod 666 or 777). We recommend using the "cache" folder inside the Zen Cart folder
  // ie: /path/to/your/webspace/public_html/zen/cache   -- leave no trailing slash  
  define('SQL_CACHE_METHOD', 'none'); 
  define('DIR_FS_SQL_CACHE', '/data/sounz/htdocs/zencart/cache');

  // Added by Liuba to avoid database errors to be displayed to users on production,
  // set it to 'true' for debugging
  // see includes/classes/db/pgsql/query_factory.php - show_error() for details
  define('DB_ERROR_REPORTING', 'false');

?>
