#! /bin/bash
#
# Configure apache for SOUNZ
# P Waite
set -e

# Name of this script
SCRIPTNAME=${0##*/}

# Get common funcs and config vars etc.
# Acquire the local configuration..
CONFDIR=/etc/sounz
CONF=${CONFDIR}/sounz.conf
if [ ! -f $CONF ] ; then
  echo "SOUNZ configuration file $CONF not found!"
  exit 10
else
  . $CONF
  if [ ! -d $SOUNZ_HOME ] ; then
    echo "FATAL: the SOUNZ home directory '$SOUNZ_HOME' does not exist."
    exit 11
  fi
  # Grab SOUNZ common functions..
  if [ -f ${SOUNZ_HOME}/install/install-funcs.sh ] ; then
    . ${SOUNZ_HOME}/install/install-funcs.sh
  else
    echo "Error: failed to load SOUNZ common functions from ${SOUNZ_HOME}/install"
    exit 12
  fi  
  # Detect the APACHE configuration settings. Sets up the following vars:
  # APACHE_NAME     # Name of the apache instance eg. 'apache2'
  # APACHE_CONFDIR  # Configuration files live here
  # APACHE_CONFSYS  # Type of config system: 'ap2', 'confd' or 'httpd'
  # APACHE_CONF     # Path to main apache configuration file
  # APACHE_USER     # User apache runs as eg. 'www-data'
  # APACHE_GROUP    # Group apache runs under eg. 'www-data'
  if [ -f ${SOUNZ_HOME}/install/detect-apache.sh ] ; then
      . ${SOUNZ_HOME}/install/detect-apache.sh
  fi
fi

# Parameters..
if [ $# -lt 6 ] ; then
  echo "usage: $SCRIPTNAME vhost servername admin_email documentroot mongrelhost mongrelports"
  exit 13
fi

VHOST=$1 ; shift
VHOST_MATCH=`echo $VHOST | sed -e "s;\*;\\\\\*;g"`
VSERVERNAME=$1 ; shift
SERVERALIASES=`echo $1|tr '|' ' '` ; shift
ADMIN_EMAIL=$1 ; shift
DOCROOT=$1 ; shift
MONGREL_HOST=$1 ; shift
MONGREL_PORTS=$*
MODE="interactive"

# Setup CONF depending on the apache config system..
case $APACHE_CONFSYS in
  ap2)
    CONF=${APACHE_CONFDIR}/sites-available/${VSERVERNAME}.conf
    ;;
  confd)
    CONF=${APACHE_CONFDIR}/conf.d/${VSERVERNAME}.conf
    ;;
  httpd)
    CONF=${APACHE_CONFDIR}/httpd.conf
    cp $CONF ${CONF}.sounz-old
    ;;
esac  

conf_create=1
conf_exists=0
[ -f $CONF ] && conf_exists=1

# Assert DocumentRoot
mkthisdir $DOCROOT

# Work file..
CONF_NEW=`tempfile -s sounz-apache-vh`
apache_reload=0
if [ "$APACHE_CONFSYS" = "ap2" -o "$APACHE_CONFSYS" = "confd" ] ; then
  if [ $conf_exists -eq 1 ] ; then
    #tell "WARNING: existing SOUNZ $APACHE_NAME configuration found"
    #tell -n "delete and re-create existing ${VSERVERNAME}.conf? [Ny]:"
    #getans "n"
    #if [ "$ANS" != "y" ] ; then
    #  # skip creation
    #  conf_create=0
    #fi
     
    # 29-11-2007 paul
    # commented out the above - we never overwrite if conf exists
    conf_create=0
  fi
  if [ $conf_create -eq 1 ] ; then
    echo "# SOUNZ virtual host: $VSERVERNAME" >${CONF_NEW}
    echo "# Created:" `date` >>${CONF_NEW}
  fi
else
  A=`perl -n -e "m;ServerName $VSERVERNAME; && print;" $CONF`
  if [ "$A" != "" ] ; then
    ${SOUNZ_HOME}/install/remove-apache-vh.sh $VSERVERNAME $MODE
  fi
  cp -a $CONF $CONF_NEW
  conf_create=1
fi

# Logging directory. We use a SOUNZ location, since various distros
# have an assortment of locations in use and it is impossible to
# be sure of finding the correct area otherwise..
if [ -z $SOUNZ_LOGS ] ; then
  SOUNZ_LOGS="/var/log/sounz"
fi
APACHE_LOGS=${SOUNZ_LOGS}/${APACHE_NAME}
mkthisdir $APACHE_LOGS

if [ $conf_create -eq 1 ] ; then

  # Insert the virtual host definition..
  tell "adding vhost $VSERVERNAME"
  echo "<VirtualHost ${VHOST}>" >>${CONF_NEW}
  echo "  ServerName ${VSERVERNAME}" >>${CONF_NEW}
  if [ "$SERVERALIASES" != "" ] ; then
    for ALIAS in $SERVERALIASES ; do
      echo "  ServerAlias ${ALIAS}" >>${CONF_NEW}
    done
  fi
  echo "  ServerAdmin ${ADMIN_EMAIL}" >>${CONF_NEW}
  echo "  ErrorLog ${APACHE_LOGS}/${VSERVERNAME}-error.log" >>${CONF_NEW}
  echo "  CustomLog ${APACHE_LOGS}/${VSERVERNAME}-access.log common" >>${CONF_NEW}
  echo "" >>${CONF_NEW}
  echo "  DocumentRoot ${DOCROOT}" >>${CONF_NEW}
  echo "" >>${CONF_NEW}
  echo "  <Directory ${DOCROOT}/>" >>${CONF_NEW}
  echo "    Options FollowSymLinks" >>${CONF_NEW}
  echo "    AllowOverride None" >>${CONF_NEW}
  echo "    Order Allow,Deny" >>${CONF_NEW}
  echo "    Allow from All" >>${CONF_NEW}
  echo "  </Directory>" >>${CONF_NEW}
  echo "  Options FollowSymLinks" >>${CONF_NEW}
  echo "" >>${CONF_NEW}
  echo "  Alias /icons/ \"${DOCROOT}/icons/\"" >>${CONF_NEW}
  echo "" >>${CONF_NEW}
  echo "  # some php settings" >>${CONF_NEW}
  echo "  php_value include_path \".:${SOUNZ_HOME}/zencart/php_includes\"" >>${CONF_NEW}
  echo "  php_flag register_globals on" >>${CONF_NEW}
  echo "  php_flag display_errors off" >>${CONF_NEW}
  echo "  php_flag log_errors on" >>${CONF_NEW}
  echo "  php_flag magic_quotes_gpc off" >>${CONF_NEW}
  echo "  php_value memory_limit 256M" >>${CONF_NEW}
  echo "  php_value upload_max_filesize 5M" >>${CONF_NEW}
  echo "  php_value post_max_size 5M" >>${CONF_NEW}
  echo "  php_value session.gc_maxlifetime 43200" >>${CONF_NEW}
  echo "" >>${CONF_NEW}
  echo "  # mongrel cluster" >>${CONF_NEW}
  echo "  <Proxy *>" >>${CONF_NEW}
  echo "    Order allow,deny" >>${CONF_NEW}
  echo "    Allow from all" >>${CONF_NEW}
  echo "  </Proxy>" >>${CONF_NEW}
  echo "  ProxyRequests Off" >>${CONF_NEW}
  echo "  <Proxy balancer://mongrel_cluster>" >>${CONF_NEW}
  for MONGREL_PORT in $MONGREL_PORTS ; do
    echo "    BalancerMember http://${MONGREL_HOST}:${MONGREL_PORT}" >>${CONF_NEW}
  done
  echo "  </Proxy>" >>${CONF_NEW}
  echo "" >>${CONF_NEW}
  echo "  RewriteEngine On" >>${CONF_NEW}
  echo "" >>${CONF_NEW}
  echo "  # Force all urls to conform to http://${VSERVERNAME}" >>${CONF_NEW}
  echo "  # to ensure browser/app cookie sync" >>${CONF_NEW}
  echo "  RewriteCond %{HTTP_HOST} !^sounz\.org\.nz [NC]" >>${CONF_NEW}
  echo "  RewriteRule ^/(.*) http://${VSERVERNAME}/$1" >>${CONF_NEW}
  echo "" >>${CONF_NEW}
  echo "  # Check for maintenance file and redirect all requests " >>${CONF_NEW}
  echo "  # if it is present." >>${CONF_NEW}
  echo "  RewriteCond %{DOCUMENT_ROOT}/maintenance.html -f" >>${CONF_NEW}
  echo "  RewriteCond %{SCRIPT_FILENAME} !maintenance.html" >>${CONF_NEW}
  echo "  RewriteRule ^.*$ /maintenance.html [L]" >>${CONF_NEW}
  echo "" >>${CONF_NEW}
  echo "  # static content" >>${CONF_NEW}
  echo "  RewriteRule ^/icons(.*) /icons\$1 [PT]" >>${CONF_NEW}
  echo "  RewriteRule ^/images(.*) /images\$1 [PT]" >>${CONF_NEW}
  echo "  RewriteRule ^/includes(.*) /includes\$1 [PT]" >>${CONF_NEW}
  echo "  RewriteRule ^/javascripts(.*) /javascripts\$1 [PT]" >>${CONF_NEW}
  echo "  RewriteRule ^/stylesheets(.*) /stylesheets\$1 [PT]" >>${CONF_NEW}
  echo "  RewriteRule ^/swf(.*) /swf\$1 [PT]" >>${CONF_NEW}
  echo "  RewriteRule ^/zencart(.*) /zencart\$1 [PT]" >>${CONF_NEW}
  echo "" >>${CONF_NEW}
  echo "  # URLs from the old site, with all php pages other than" >>${CONF_NEW}
  echo "  # zencart going to front page" >>${CONF_NEW}
  echo "  RewriteCond %{REQUEST_URI} !^/zencart(.*)$" >>${CONF_NEW}
  echo "  RewriteRule ^(.*\.php)$ http://${VSERVERNAME} [L,R=301]" >>${CONF_NEW}
  echo "" >>${CONF_NEW}
  echo "  # Media offshore content handling" >>${CONF_NEW}
  echo "  # If a file called offshore_media_enabled exists, then" >>${CONF_NEW}
  echo "  # route the binaries through a remote squid proxy" >>${CONF_NEW}
  echo "  RewriteCond %{DOCUMENT_ROOT}/offshore_media_enabled -f" >>${CONF_NEW}
  echo "  RewriteCond %{SCRIPT_FILENAME} !offshore_media_enabled" >>${CONF_NEW}
  echo "  RewriteRule ^/media_items/(.*) http://media.${VSERVERNAME}:3128/media_items/\$1 [R,L]" >>${CONF_NEW}
  echo "" >>${CONF_NEW}
  echo "  # else use local apache" >>${CONF_NEW}
  echo "  RewriteRule ^/media_items(.*) /media_items\$1 [PT]" >>${CONF_NEW}
  echo "" >>${CONF_NEW}
  echo "  # rails cached pages" >>${CONF_NEW}
  echo "  RewriteRule ^([^.]+)$ \$1.html [QSA]" >>${CONF_NEW}
  echo "" >>${CONF_NEW}
  echo "  #redirect non-static requests to cluster " >>${CONF_NEW}
  echo "  RewriteCond %{DOCUMENT_ROOT}/%{REQUEST_FILENAME} !-f" >>${CONF_NEW}
  echo "  RewriteRule ^/(.*)$ balancer://mongrel_cluster%{REQUEST_URI} [P,QSA,L]" >>${CONF_NEW}
  echo "" >>${CONF_NEW}
  echo "  <Location /zencart>" >>${CONF_NEW}
  echo "    Satisfy Any" >>${CONF_NEW}
  echo "    AuthType None" >>${CONF_NEW}
  echo "    Order Deny,Allow" >>${CONF_NEW}
  echo "    Allow from All" >>${CONF_NEW}
  echo "  </Location>" >>${CONF_NEW}
  echo "" >>${CONF_NEW}
  echo "</VirtualHost>" >>${CONF_NEW}
  
  # Move new contents to applicable destination..
  mv $CONF_NEW $CONF
fi
  
# Apache2 site needs enabling now..
if [ "$APACHE_CONFSYS" = "ap2" ] ; then
  if [ -x /usr/sbin/a2ensite ] ; then
    /usr/sbin/a2ensite ${VSERVERNAME}.conf || true
  else
    if [ -d ${APACHE_CONFDIR}/sites-enabled ] ; then
      ln -s ${APACHE_CONFDIR}/sites-available/${VSERVERNAME}.conf ${APACHE_CONFDIR}/sites-enabled/${VSERVERNAME}.conf
    fi
  fi
fi

# Make sure Apache modules are enabled
if [ "$APACHE_CONFSYS" = "ap2" ] ; then
  a2enmod proxy >/dev/null 2>&1 || true
  a2enmod proxy_balancer >/dev/null 2>&1 || true
  a2enmod proxy_connect >/dev/null 2>&1 || true
  a2enmod proxy_ftp >/dev/null 2>&1 || true
  a2enmod proxy_http >/dev/null 2>&1 || true
  a2enmod rewrite >/dev/null 2>&1 || true
else
  APACHE_MODCONF=/usr/sbin/modules-config
  if [ -x ${APACHE_MODCONF} ] ; then
    APACHEID=`basename ${APACHE_CONFDIR}`
    EXISTS=`${APACHE_MODCONF} ${APACHEID} query mod_proxy`
    [ "$EXISTS" = "" ] && ${APACHE_MODCONF} ${APACHEID} enable mod_proxy || true
    EXISTS=`${APACHE_MODCONF} ${APACHEID} query mod_rewrite`
    [ "$EXISTS" = "" ] && ${APACHE_MODCONF} ${APACHEID} enable mod_rewrite || true
  fi
fi
apache_reload=1
rm -f $CONF_NEW

# Restart apache..
if [ $apache_reload -eq 1 ] ; then
  tell "reloading apache config.."
  ${SOUNZ_HOME}/install/prod-apache.sh reload $APACHE_NAME || true
fi

# END
