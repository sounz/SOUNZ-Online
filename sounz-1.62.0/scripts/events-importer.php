#!/usr/bin/php -q
<?php

/**
 * Events importer - takes a CSV file and imports the events found there
 * Usage:
 *   events-importer.php --csv=path/to/csvfile --db=dbname [--insert] [--commit]
 */
$AXCONF = "/etc/axyl/axyl.conf";
$fp = fopen($AXCONF, "r");
if ($fp === false) {
  echo "Axyl configuration file $AXCONF not found.\n";
  echo "Please install Axyl first.\n";
  exit;
}
else {
  $config = fread($fp, filesize($AXCONF));
  if (preg_match("/AXYL_HOME=([\S]+)/", $config, $matches)) {
    $AXYL_HOME = $matches[1];
    ini_set("include_path", "$AXYL_HOME/lib");
  }
  else {
    echo "error: failed to parse Axyl configuration file $AXCONF\n";
    echo "Please check contents of this file for AXYL_HOME setting.\n";
    exit;
  }
}

// ----------------------------------------------------------------------
// INCLUDES
include_once("optlist-defs.php");
include_once("response-defs.php");

$RESPONSE = new response();
$RESPONSE->datasource = new datasources();

debug_on(DBG_DIAGNOSTIC);

$opts = new optlist();
if ($opts->optcount > 0 && $opts->opt_exists("csv") && $opts->opt_exists("db")) {

  #database name
  $dbname = $opts->opt_value("db");
  
  #username
  if ($opts->opt_exists("user")) {
    $user = $opts->opt_value("user");
  }
  else {
    $ubits = explode(" ", exec("who -m"));
    if ($ubits[0] != "") $user = $ubits[0];
    else $user = "postgres";
  }
  
  $RESPONSE->datasource->add_database(
    "postgres",         // Database type eg: postgres, mssql_server, oracle etc.
    $dbname,            // Database name
    $user,              // Name of user with access to the database
    "",                 // Password for this user
    "",                 // Host machine name
    "",                 // Port number
    "","ISO",           // Char encoding and datestyle
    DEFAULT_DATASOURCE
    );
  $RESPONSE->datasource->connect();
  if (!$RESPONSE->datasource->connected($dbname)) {
    die("ERROR: could not connect to database '$dbname'\n");
  }

  #grab other options  
  $csvfile = strval($opts->opt_value("csv"));
  $commit = $opts->opt_exists("commit");
  $insert = $opts->opt_exists("insert");

  $importF = new csv_inputfile($csvfile);
  if ($importF->opened) {
    $lineno = 0;
    do {
      $event = $importF->readln();
      if ($event) {
        #current line number
        $lineno += 1;
        $lineno_s = sprintf("%03d", $lineno);
        
        #flag to indicate crap data-line
        $bogus = false;
  
        #holds error details for bogus lines
        $msgs = array();
  
        #event_title
        $event_title = $event[0];
        if ($event_title == "") {
          $msgs[] = "missing event title";
          $bogus = true;
        }
  
        #region_id
        if ($event[1] != "") {
          $region_id = intval($event[1]);
        }
        else {
          $region_id = NULLVALUE;
        }

        #locality
        $locality = $event[2];
        
        #country_id
        $country_id = NULLVALUE;
        $country_abbrev = $event[3];
        if ($country_abbrev == "") {
          if (is_int($region_id)) {
            $country_abbrev = "NZ";
          }
          else {
            $msgs = "missing country abbrev";
            $bogus = true;
          }
        }
        if ($country_abbrev != "") {
          $cQ = dbrecordset("SELECT country_id FROM countries WHERE country_abbrev='$country_abbrev'");
          if ($cQ->rowcount == 1) {
            $country_id = intval($cQ->field("country_id"));
          }
          else {
            $msgs[] = "country not found for abbrev [$country_abbrev]";
            $bogus = true;
          }
        }
        
        #event_start
        $event_start = $event[4];
        if ($event_start == "") {
          $event_start = NULLVALUE;
        }

        #event_finish
        $event_finish = $event[5];
        if ($event_finish == "") {
          $event_finish = NULLVALUE;
        }

        #general_note
        $general_note = $event[6];

        #internal_note - composite of final 5 fields
        $notes = array();
        $label = array("Comp", "Work", "Prem", "Perf", "Venu");
        for ($ix=7; $ix <= 11; $ix++) {
          if ($event[$ix] != "") {
            $notes[] = $label[$ix - 7] . ": " . $event[$ix];
          }
        }
        $internal_note = implode("\n", $notes);
  
        #bogus lines get a message
        if ($bogus) {
          debugbr("line $lineno_s: bogus data found:");
          debugbr(implode("\n", $msgs));
          debugbr(implode(",", $event));
        }
        else {
          if ($insert) {
            begin_transaction();
            $result = false;
            
            #create new contactinfo record
            $cins = new dbinsert("contactinfos");
            $cins->set("region_id",        $region_id);
            $cins->set("country_id",       $country_id);
            $cins->set("locality",         $locality);
            $cins->set("created_at",       timestamp_to_datetime());
            $cins->set("updated_at",       timestamp_to_datetime());
            $cins->set("updated_by",       1000);
            if ($cins->execute()) {
              $seq = dbrecordset("SELECT currval('contactinfos_contactinfo_id_seq') AS cinfo_id");
              $cinfo_id = intval($seq->field("cinfo_id"));
              
              # create new event record
              $eins = new dbinsert("events");
              $eins->set("event_type_id",    1);              // concert
              $eins->set("status_id",        3);              // published
              $eins->set("contactinfo_id",   $cinfo_id);
              $eins->set("event_title",      $event_title);
              $eins->set("event_start",      $event_start);
              $eins->set("event_finish",     $event_finish);
              $eins->set("supress_times",    false);
              $eins->set("general_note",     $general_note);
              $eins->set("internal_note",    $internal_note);
              $eins->set("created_at",       timestamp_to_datetime());
              $eins->set("updated_at",       timestamp_to_datetime());
              $eins->set("updated_by",       1000);
              $result = $eins->execute();
              if (!$result) {
                $msgs[] = $eins->$last_errormsg;
              }
            }
            else {
              $msgs[] = $cins->$last_errormsg;
            }
                        
            if ($commit) {
              $status = "[commit]";
              commit();
            }
            else {
              $status = "[trial]";
              rollback();
            }          
            
            #report to stdout
            if ($result) {
              $status .= "[insert ok]";
              debugbr("line $lineno_s: $status $event_title");
            }
            else {
              $status .= "[db error]";
              debugbr("line $lineno_s: $status $event_title");
              if (count($msgs) > 0) {
                debugbr("DB error: " . implode(" ", $msgs));
              }
            }
          }
          else {
            debugbr("line $lineno_s: [no inserts] $event_title");
          }
        }
      }
    }
    while ( $event );

    // Close the file..
    $importF->closefile();
  }
  else {
    debugbr("ERROR: failed to open $csvfile\n");
  }  
}
else {
  echo "usage: import-events.php --csv=path/to/csvfile --db=dbname [--insert] [--commit]\n\n" 
     . "If the --insert option is given then database insert statements will be done.\n"
     . "However, if the --commit option is not given, then the script will execute the\n"
     . "database inserts, but will then roll them back and will as a result only do\n"
     . "a dry-run, reporting the event titles done to stdout."
     ;
}
?>
