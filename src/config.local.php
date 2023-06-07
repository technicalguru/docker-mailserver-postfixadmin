<?php
/** 
 * Postfix Admin Configuration file for docker-mailserver-postfixadmin
 */

$CONF['configured'] = true;

$PFA_VARS = array('PFA_SETUP_PASS', 'PFA_DB_USER', 'PFA_DB_HOST', 'PFA_DB_PASS', 'PFA_DB_NAME', 'PFA_POSTFIX_SERVER', 'PFA_ABUSE_EMAIL', 'PFA_HOSTMASTER_EMAIL', 'PFA_POSTMASTER_EMAIL', 'PFA_WEBMASTER_EMAIL');
$PFA_ERROR = false;
foreach ($PFA_VARS AS $PFA_VAR) {
	if (!isset($_ENV[$PFA_VAR])) {
		$PFA_ERROR = true;
		break;
	}
}
if ($PFA_ERROR) {
	echo '<h1>Configuration Error</h1>You must set environment these variables:<ul>';
	foreach ($PFA_VARS AS $PFA_VAR) {
		echo '<li>'.$PFA_VAR.': '.(isset($_ENV[$PFA_VAR]) ? '<span style="color: green; font-weight: bold;">configured</span>' : '<span style="color: red; font-weight: bold;">missing</span>').'</li>';
	}
	echo '</ul>';
	exit(1);
}

// In order to setup Postfixadmin, you MUST specify a hashed password here.
// To create the hash, visit setup.php in a browser and type a password into the field,
// on submission it will be echoed out to you as a hashed value.
$PFA_SALT = md5(time() . '*' . $_SERVER['REMOTE_ADDR'] . '*' . mt_rand(0, 60000));
$CONF['setup_password'] = password_hash(($_ENV['PFA_SETUP_PASS'] ? $_ENV['PFA_SETUP_PASS'] : $_ENV['PFA_DB_PASS']), PASSWORD_DEFAULT);

// Database Config
$CONF['database_type'] = 'mysqli';
$CONF['database_host'] = $_ENV['PFA_DB_HOST'];
$CONF['database_user'] = $_ENV['PFA_DB_USER'];
$CONF['database_password'] = $_ENV['PFA_DB_PASS'];
$CONF['database_name'] = $_ENV['PFA_DB_NAME'];

// Mail Server
// Hostname (FQDN) of your mail server.
// This is used to send email to Postfix in order to create mailboxes.
$CONF['smtp_server'] = $_ENV['PFA_POSTFIX_SERVER'];
$CONF['smtp_port'] = isset($_ENV['PFA_POSTFIX_PORT']) ? $_ENV['PFA_POSTFIX_PORT'] : 25;

// SMTP Client
// Hostname (FQDN) of the server hosting Postfix Admin
// Used in the HELO when sending emails from Postfix Admin
$CONF['smtp_client'] = $_ENV['HOSTNAME'].'.localdomain';

// Default Aliases
$CONF['default_aliases'] = array (
    'abuse'      => $_ENV['PFA_ABUSE_EMAIL'],
    'hostmaster' => $_ENV['PFA_HOSTMASTER_EMAIL'],
    'postmaster' => $_ENV['PFA_POSTMASTER_EMAIL'],
    'webmaster'  => $_ENV['PFA_WEBMASTER_EMAIL']
);

if (file_exists(dirname(__FILE__) . '/config.site.php')) {
    require_once(dirname(__FILE__) . '/config.site.php');
}

//
// END OF CONFIG FILE
//
/* vim: set expandtab softtabstop=4 tabstop=4 shiftwidth=4: */
