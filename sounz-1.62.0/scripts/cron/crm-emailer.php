#!/usr/bin/php -q
<?php
/**
*  Emailer - process marketing campaigns mailing
*  All parameters are read from the SOUNZ configuration which is
*  found in /etc/sounz/sounz.conf.
*/

// Acquire the emailer library. This is located in
// SOUNZ_HOME/scripts/php/swiftemailer
require_once dirname(__FILE__) . "/../php/swiftemailer/Swift.php"; 
require_once dirname(__FILE__) . "/../php/swiftemailer/Swift/Connection/SMTP.php"; 


// ----------------------------------------------------------------------
/**
 * A system configuration file in the form of a shell script. These are
 * in the standard NAME=VALUE format, but implemented as 'sh' scripts so
 * that other scripts can use them via '.'. This class is provided to
 * allow Php scripts to easily access the config settings in these too.
 * NOTE: this does not cope with run-time settings in shell format. Eg.
 * entries of the form: MYVAR=${OTHERVAR}/mydir. Ie. it doesn't expand
 * the value of ${OTHERVAR} to produce the final setting.  
 * Use the 'getvalue()' method to access the read-in vars.
 */
class shellconfigfile {
  /** Path to the config file */
  var $path;
  /** Config settings as an associative array (name=value) */
  var $settings = array();
  /** True if config is read in & valid */
  var $valid = false;
  // ....................................................................
  function shellconfigfile($path) {
    $this->path = $path;
    $this->import_settings();
  } // shellconfigfile
  // ....................................................................
  /** Process the configfile. */
  function import_settings() {
    $this->settings = array();
    $config = file_get_contents($this->path);
    if ($config !== false) {
      $this->valid = true;
      $pattern = "/([\\w\\S]+=[\"']*.+[\"'\w]*)/";
      $matched = preg_match_all($pattern, $config, $matches);
      if ($matched > 0 && count($matches[1]) > 0) {
        foreach ($matches[1] as $match) {
          $bits  = explode("=", $match);
          $name  = $bits[0];
          $value = trim($bits[1], "\"' ");
          $this->settings[$name] = $value;
        } // foreach
      }
    }
  } // import_settings
  // ....................................................................
  /** Return value of  named setting, if it exists.. */ 
  function getvalue($name) {
    $val = "";
    if ($this->valid && $this->settingexists($name)) {
      $val = $this->settings[$name];
    }
    return $val;
  } // getvalue
  // ....................................................................
  /** Return true if named setting is defined */
  function settingexists($name) {
    return isset($this->settings[$name]);
  }
} // shellconfigfile class

// ---------------------------------------------------------------------
// Acquire our runtime parameters from SOUNZ config

$configfile = "/etc/sounz/sounz.conf";
if (!file_exists($configfile)) {
  logecho("fatal: no configuration found!");
  die;
}

// Grab configuration
$conf = new shellconfigfile($configfile);

// Mandatory database name
if ($conf->settingexists("DB_NAME")) {
  $db = strval($conf->getvalue("DB_NAME"));
}
else {
  logecho("fatal: no database name was provided");
  die;
}
// Optional host and port
if ($conf->settingexists("DB_HOST")) {
  $host = strval($conf->getvalue("DB_HOST"));
}
if ($conf->settingexists("DB_PORT")) {
  $port = intval($conf->getvalue("DB_PORT"));
  if ($port == 0) {
    logecho("warning: illegal port value given: " . $conf->getvalue("DB_PORT"));
    unset($port);
  }
}
// Mandatory user - fallback to 'postgres'
if ($conf->settingexists("DB_USER")) {
  $user = strval($conf->getvalue("DB_USER"));
}
else {
  $user = "postgres";
}
// Optional password
if ($conf->settingexists("DB_PASSWD")) {
  $password = strval($conf->getvalue("DB_PASSWD"));
}
// Environment - if the env is anything other than 'production', then
// emails will not be sent out to genuine e-mail addresses, and debug
// mode is forced ON
$debug = false;
$environment = "development";
if ($conf->settingexists("ENVIRONMENT")) {
  $environment = strval($conf->getvalue("ENVIRONMENT"));
}
if ($environment != "production") {
  $debug = true;
}

// Administrator email setting
if ($conf->settingexists("ADMIN_EMAIL")) {
  $admin_email = strval($conf->getvalue("ADMIN_EMAIL"));
}
else {
  $admin_email = "pete@catalyst.net.nz";
}

// Email connection settings
if ($conf->settingexists("EMAIL_SMTP_SERVER")) {
  $EMAIL_SMTP_SERVER = strval($conf->getvalue("EMAIL_SMTP_SERVER"));
}
else {
  logecho("fatal: no SMTP mailserver was provided");
  die;
}
$EMAIL_DOMAIN = "";
if ($conf->settingexists("EMAIL_DOMAIN")) {
  $EMAIL_DOMAIN = strval($conf->getvalue("EMAIL_DOMAIN"));
}
$EMAIL_AUTH = "";
if ($conf->settingexists("EMAIL_AUTH")) {
  $EMAIL_AUTH = strval($conf->getvalue("EMAIL_AUTH"));
}
$EMAIL_USER = "";
if ($conf->settingexists("EMAIL_USER")) {
  $EMAIL_USER = strval($conf->getvalue("EMAIL_USER"));
}
$EMAIL_PASSWORD = "";
if ($conf->settingexists("EMAIL_PASSWORD")) {
  $EMAIL_PASSWORD = strval($conf->getvalue("EMAIL_PASSWORD"));
}
if ($conf->settingexists("EMAIL_TLS")) {
  $EMAIL_TLS = ($conf->getvalue("EMAIL_TLS") == "true");
}
$EMAIL_PORT = 25;
if ($conf->settingexists("EMAIL_PORT")) {
  $EMAIL_PORT = intval($conf->getvalue("EMAIL_PORT"));
  if ($EMAIL_PORT == 0) {
    $EMAIL_PORT = 25;
  }
}

// Debugging announcements
logecho("crm-emailer ($environment)");
if ($debug) {
  $msg = "database: $db";
  if ($host) {
    $msg .= "($host:$port)";
  }
  else {
    $msg .= "(local)";
  }
  $msg .= " user: $user";
  if ($password) {
    $msg .= "(with password)";
  }
  else {
    $msg .= "(no password)";
  }
  logecho($msg);
  $msg = "connecting to mailserver: $EMAIL_SMTP_SERVER on port $EMAIL_PORT";
  if ($EMAIL_TLS) {
    $msg .= " (TLS)";
  }
  if ($EMAIL_AUTH != "" && $EMAIL_USER != "") {
    $msg .= " user: $EMAIL_USER";
    if ($EMAIL_PASSWORD) {
      $msg .= "(with password)";
    }
    else {
      $msg .= "(no password)";
    }
  }
  logecho($msg);
}

// ---------------------------------------------------------------------
// Setting variables
define("EMAIL_LIMIT",     50);
define("NAME",            "%name%");              # These placeholders will be 
define("CURRENT_DATE",    "%date%");              # substituted for the appropriate
define("CONTACT_DETAILS", "%contact details%");   # content. Note: they are case-
define("SALUTATION",      "%salutation%");        # insensitive.
define("FROM",            "info@sounz.org.nz");   # email sender address
define("FROM_NAME",       "SOUNZ");               # email sender name
define("DEFAULT_CHARSET", "us-ascii");
// MIME encoding
define("ENC_BIT7",        "7bit");                # 7-bit Encoding
define("ENC_BASE64",      "base64");              # Base-64 Encoding
define("ENC_QUOTP",       "quoted-printable");    # Quoted-Printable Encoding

// ----------------------------------------------------------------------
// Process campaign_mailouts which have a 'Send in progress' mailout status
$mailout_status = "i";
process_mailing($mailout_status, $db, $host, $port, $user, $password, $debug, $admin_email);

// ----------------------------------------------------------------------
// Process campaign_mailouts which have a 'Send requested' mailout status
$mailout_status = "r";
process_mailing($mailout_status, $db, $host, $port, $user, $password, $debug, $admin_email);


// ----------------------------------------------------------------------
/** Process mailouts by
*   preparing and sending out mailing for the campaign mailouts with the requested
*   mailout status
*   @param string $mailout_status
*/
function process_mailing(
  $mailout_status="i",
  $db,
  $host,
  $port,
  $user,
  $password,
  $debug,
  $admin_email
  )
{
 
  // Connecting, selecting database
  $connstr = "dbname=$db"
           . (($host != "")     ? " host=$host" : "")
           . (($port != "")     ? " port=$port" : "")
           . (($user != "")     ? " user=$user" : "")
           . (($password != "") ? " password=$password" : "")
           ;
  $dbconn = pg_connect($connstr);
  if ($dbconn === false ) {
    logecho("database connect failed: [$connstr]: " . pg_last_error());
    die;
  }

  // Campaign mailouts with the requested mailout status ---------------------------------
  $campaign_mailouts_query =
       "SELECT m.campaign_mailout_id, m.mailout_description, m.main_content, m.secondary_content"
      ."  FROM campaign_mailouts m "
      ." WHERE mailout_status='".$mailout_status."'"
      ."   AND mailout_type='e'"
      ." ORDER BY m.updated_at";
  $campaign_mailouts = pgexec($campaign_mailouts_query);

  if ($debug) {
    logecho("found "
        . pg_num_rows($campaign_mailouts)
        . ($mailout_status == "i" ? " in-progress " : " requested ")
        . "campaign mailouts to process."
        );
  }

  // Process each campaign mailout
  while ($campaign_mailout = pg_fetch_object($campaign_mailouts)) {
    # campaign mailout id
    $campaign_mailout_id = $campaign_mailout->campaign_mailout_id;

    # set mailout status to 'Send in progress' if processing campaign mailouts with 'Send requested' status
    if ($mailout_status == "r") {
      $update_campaign_mailout_query =
           "UPDATE campaign_mailouts SET mailout_status = 'i' "
          ."  WHERE campaign_mailout_id = ".$campaign_mailout_id;
      pgexec($update_campaign_mailout_query);
      if ($debug) {
        logecho("Mailout '" . $campaign_mailout->mailout_description . "': (id=$campaign_mailout_id) now in-progress");
      }
    }

    # set email $subject
    $subject = $campaign_mailout->mailout_description;

    # set $html_content
    $html_content  = "<html>\n<body>\n";
    $html_content .= $campaign_mailout->main_content;
    $html_content .= "\n</body>\n</html>\n";

    # set $plain_text
    $plain_text   = $campaign_mailout->secondary_content;

    // Contacts who have not been mailed yet ------------------------------------------
    $mailout_contacts_query =
      "SELECT * FROM mailout_contacts "
     ."  WHERE campaign_mailout_id=".$campaign_mailout_id
     ."   AND delivery_timestamp IS NULL "
     ." LIMIT ".EMAIL_LIMIT;

    $mailout_contacts = pgexec($mailout_contacts_query);
    if ($debug) {
      logecho("Mailout '" . $campaign_mailout->mailout_description . "': " . pg_num_rows($mailout_contacts) . " contacts to process.");
    }

    // Process each contact
    while ($mailout_contact = pg_fetch_object($mailout_contacts)) {

      // Prepare an email for every contact --------------------------------------------
      $mailout_contact_id = $mailout_contact->mailout_contact_id;

      # use actual contact email address only if in production mode
      # else use testing default
      $to = ($debug) ? $admin_email : $mailout_contact->email;

      # prepare contact details if needed
      $contact_details = "";
      if (preg_match('/'.CONTACT_DETAILS.'/', $html_content) || preg_match('/'.CONTACT_DETAILS.'/', $plain_text)) {

        // contact name
        $contact_details = $mailout_contact->name;

        if (trim($mailout_contact->address_line1) != "")
          $contact_details .= ", ".$mailout_contact->address_line1;

        if (trim($mailout_contact->address_line2) != "")
          $contact_details .= ", ".$mailout_contact->address_line2;

        if (trim($mailout_contact->address_line3) != "")
          $contact_details .= ", ".$mailout_contact->address_line3;

        if (trim($mailout_contact->address_line4) != "")
          $contact_details .= ", ".$mailout_contact->address_line4;

        if (trim($mailout_contact->address_line5) != "")
          $contact_details .= "  ".$mailout_contact->address_line5;   #post code if any

        if (trim($mailout_contact->address_line6) != "")
          $contact_details .= ", ".$mailout_contact->address_line6;

        if (trim($mailout_contact->address_line7) != "")
          $contact_details .= ", ".$mailout_contact->address_line7;
      }

      # personalize email content
      # html version
      $personalized_html_content = personalize_content($html_content,
                                                       $mailout_contact->salutation,
                                                       $mailout_contact->name,
                                                       $contact_details
                                                       );
      $personalized_html_content = strip_illegal_characters($personalized_html_content, "html");

      # plain text version
      if (trim($plain_text) != "") {
        $personalized_plain_text = personalize_content($plain_text,
                                                       $mailout_contact->salutation,
                                                       $mailout_contact->name,
                                                       $contact_details
                                                       );
      }
      # if there is no plain text version, get html version
      else {
        $personalized_plain_text = $personalized_html_content;
      }
      $personalized_plain_text = strip_illegal_characters($personalized_plain_text);

      // Send email --------------------------------------------------------------------
      $email_sent = send_mail(
                      $to,
                      $mailout_contact->name,
                      FROM,
                      FROM_NAME,
                      $subject,
                      $personalized_html_content,
                      $personalized_plain_text
                      );


      // Update db --------------------------------------------------------------------
      // An email attempt was made - set delivery_timestamp to 'now'
      $now   = date("Y-m-d H:i:s");
      $update_contact_query = "UPDATE mailout_contacts SET delivery_timestamp='".$now."'";
      if ($email_sent) {
        logecho("Mailout '" . $campaign_mailout->mailout_description. "': mailout to '" . $mailout_contact->name . "' ($to) OK");
      }
      else {
        # email failed - set delivery_failed to 'true'
        $update_contact_query .= ", delivery_failed=TRUE";
        logecho("Mailout '" . $campaign_mailout->mailout_description . "': mailout to '" . $mailout_contact->name . "' ($to) FAILED");
      }
      $update_contact_query .= " WHERE campaign_mailout_id =".$campaign_mailout_id." AND mailout_contact_id =".$mailout_contact_id;

      # process update
      $res = pgexec($update_contact_query);
    }

    # any more campaign_mailout contacts to process?
    $mailout_contacts = pgexec($mailout_contacts_query);

    # if not, set mailout_status to 's' - Sent
    if ( pg_num_rows($mailout_contacts) == 0 ) {
       $update_campaign_mailout_query = "UPDATE campaign_mailouts SET mailout_status = 's' "
                                       ." WHERE campaign_mailout_id = ".$campaign_mailout_id;
       $res = pgexec($update_campaign_mailout_query); 
       if ($debug) {
         logecho("Mailout '" . $campaign_mailout->mailout_description . "': marked as sent");
       }
    }
  }
  // Closing connection
  pg_close($dbconn);
}

// ---------------------------------------------------------------------
/** 
 * Echo a message prefixed with a timestamp. Used for echoing stuff
 * to a logfile.
 */
function logecho($msg) {
  $stamp = date("Y-m-d H:i:s");
  echo "$stamp $msg\n";
}

// ---------------------------------------------------------------------
/** 
 * Execute a query to Postgres using the current database connection.
 * Note that this assumes a connection has been made.
 * @return resource $res The returned results/resource
 */
function pgexec($query) {
  $res = pg_query($query);
  if ($res === false) {
    logecho("QFAIL: " . pg_last_error() . "\n");
    logecho("$query\n");
    die;
  }
  return $res;
}

// ----------------------------------------------------------------------
/** 
 * Personilize content by replacing SALUTATION, NAME, CURRENT_DATE
 * and CONTACT_DETAILS tags if any with appropriate contact details.
 * Note that the placeholders are case-insensitive, ie. %name% is
 * the same as %NAME% etc.
 * @param string $content
 * @param string $salutation
 * @param string $name
 * @param string $contact_details
 */
function personalize_content($content, $salutation, $name, $contact_details)
{
  # replace salutation tags with the salutation
  $content = preg_replace('/'.SALUTATION.'/i', $salutation, $content);
  
  # replace name tags with the recipient name
  $content = preg_replace('/'.NAME.'/i', $name, $content);

  # replace date tags with 'today' date
  $content = preg_replace('/'.CURRENT_DATE.'/i', date("j F Y"), $content);
  
  # replace contact details tags with appropriate details
  $content = preg_replace('/'.CONTACT_DETAILS.'/i', $contact_details, $content);

  return $content;
}

// ----------------------------------------------------------------------
/**
 * Strip illegal characters
 * @param string $content
 * @param string $format
 */
function strip_illegal_characters($content, $format="plain")
{
  # replace any extra ('user-defined') tags
  $content = preg_replace('/%+\S*%+/', " ", $content);

  if (preg_match('/plain/', $format)) {
    $content = strip_tags($content);
  }

  return $content;
}

// ----------------------------------------------------------------------
/**
 * Compile and send email using multipart/alternative MIME content-type
 * @param string $toaddress
 * @param string $toname
 * @param string $fromaddress
 * @param string $fromname
 * @param string $subject
 * @param string $html_content
 * @param string $text_content
 * @param string $charset
 * @param string $encoding
 */
function send_mail(
     $toaddress,
     $toname,
     $fromaddress,
     $fromname,
     $subject,
     $html_content,
     $text_content,
     $charset=DEFAULT_CHARSET,
     $encoding=ENC_QUOTP)
{
  global $EMAIL_SMTP_SERVER,
         $EMAIL_DOMAIN,
         $EMAIL_AUTH,
         $EMAIL_USER,
         $EMAIL_PASSWORD,
         $EMAIL_TLS,
         $EMAIL_PORT;

  // Create SMTP connection
  $smtpconn = new Swift_Connection_SMTP(
                   $EMAIL_SMTP_SERVER,
                   $EMAIL_PORT,
                   (($EMAIL_TLS) ? ENC_TLS : ENC_OFF)
                   );
  // Add in authenticator if required..
  if ($EMAIL_AUTH == "login" && $EMAIL_USER != "") {
    $smtpconn->setUsername("$EMAIL_USER");
    $smtpconn->setPassword("$EMAIL_PASSWORD");
  }
  
  // Default timeout of 15s is too long
  $smtpconn->setTimeout(2);

  // Create the email object
  $email = new Swift($smtpconn);

  //Create the message
  $message = new Swift_Message($subject);
  $message->attach(new Swift_Message_Part($text_content, "text/plain", $encoding, $charset));
  $message->attach(new Swift_Message_Part($html_content, "text/html", $encoding, $charset));
  $message->headers->setCharset($charset);
  if ($EMAIL_DOMAIN != "") {
    $message->setReturnPath("bounces@$EMAIL_DOMAIN");
  }
  
  // Now send the message out
  $num_sent = $email->send(
                      $message,
                      new Swift_Address($toaddress, $toname),
                      new Swift_Address($fromaddress, $fromname)
                      );
  $email->disconnect();
  
  return ($num_sent > 0);
}
?>
