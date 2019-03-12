<?php
require_once('./sys/init.php');

$app      = (!empty($_GET['app'])) ? $_GET['app'] : '';
$action   = (!empty($_GET['a'])) ? $_GET['a'] : '';
$rhandler = "xhr/$app.php";
$data     = array();
$root     = __DIR__;
$hash     = (!empty($_GET['hash'])) ? $_GET['hash'] : '';
if (empty($hash)) {
    $hash = (!empty($_POST['hash'])) ? $_POST['hash'] : '';
}

define('ROOT', $root);

header("Content-type: application/json");

if (empty(IS_ADMIN) && (empty($hash) || empty(pxp_verifcsrf_token($hash))) && $action != 'contact_us') {
	$data = array(
        'status'   => '400',
        'message'  => 'ERROR: Invalid or missing CSRF token'
    );

    echo json_encode($data, JSON_PRETTY_PRINT);
	exit();
}

else if (!file_exists($rhandler)) {
    $data = array(
        'status'   => '404',
        'message'  => 'Not Found'
    );

    echo json_encode($data, JSON_PRETTY_PRINT);
	exit();
}

else {	
	require_once($rhandler);
	echo json_encode($data, JSON_PRETTY_PRINT);
	$db->disconnect();
	unset($context);
	exit();
}
?>