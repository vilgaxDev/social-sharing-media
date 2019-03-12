<?php
ini_set('display_errors', 0);
ini_set('display_startup_errors', 0);
error_reporting(0);

define("ROOTPATH", dirname(dirname(__FILE__)) );

session_start();
require_once('sys/server/tables.php');
require_once('sys/db.php');
require_once('sys/context_data.php');
require_once('sys/pxp-autoload.php');
require_once('sys/server/utils.php');
require_once('sys/import3p/s3/aws-autoloader.php');
require_once('sys/import3p/ftp/vendor/autoload.php');
require_once('sys/import3p/ffmpeg-php/vendor/autoload.php');
require_once('sys/import3p/youtube-sdk/vendor/autoload.php');
require_once('sys/import3p/getID3-1.9.14/getid3/getid3.php');
require_once('sys/import3p/SimpleImage-master/src/claviska/SimpleImage.php');
require_once('sys/settings.php');
require_once('sys/import3p/PHPMailer/PHPMailerAutoload.php');


$generic_init = array(
	'db' => $db,
	'site_url' => $site_url,
	'config' => $config,
	'mysqli' => $mysqli,
);


$pixelphoto = new Generic($generic_init);
$user  = new User();
$me    = array();
$langs = $user->getLangs();

$context['theme_url'] = $site_url.'/apps/'.$config['theme'];
$context['loggedin'] = $user->isLogged();
$context['is_admin'] = false;
$context['langs']    = $langs;
$context['site_url']    = $site_url;
$context['config']    = $config;
$context['dirname_theme']    = dirname(__dir__).'/apps/'.$config['theme'];
$context['images']    = sprintf('%s/media/img',$config['site_url']);


if ($context['loggedin'] === true) {

	$context['user'] = $user->getLoggedInUser();
	$context['user'] = Generic::toArray($context['user']);
	$me        = $context['user'];
	$user_lang = $context['user']['language'];
	$countries = "lang/countries/english.php";
	if (file_exists($countries)) {
		$countries = "lang/countries/$user_lang.php";
	}
	
	$user->updateLastSeen();

	
	require_once($countries);
	
	$context['countries_name'] = $countries_name; 
	$context['is_admin']       = (($me['admin'] == 1) ? true : false);
	$_SESSION['lang']          = $me['language'];
}

if (!empty($_GET['lang']) && in_array($_GET['lang'], array_keys($langs))) {

    $lang_name = $user::secure(strtolower($_GET['lang']));    
    $_SESSION['lang'] = $lang_name;

    if ($context['loggedin'] === true) {
        $db->where('user_id', $me['user_id'])->update(T_USERS, array('language' => $lang_name));
    }
}

if (empty($_SESSION['lang'])) {
    $_SESSION['lang'] = $config['language'];
}
$context['language'] = $_SESSION['lang'];
$lang                = $user->fetchLanguage($context['language']);
$context['lang']     = $lang; 
$context['csrf_token']  = pxp_gencsrf_token(); 


define('IS_LOGGED', $context['loggedin']);
define('IS_ADMIN', $context['is_admin']);

require_once('sys/cron_job.php');
require_once('sys/onesignal_config.php');