<?php

if (IS_LOGGED != true) {
	header("Location: $site_url/welcome");
	exit;
}


if (!empty($_GET['user']) && User::userNameExists($_GET['user'])) {
	if ($user->isAdmin()) {
		$user->setUserByName($_GET['user']);
		$me = $user->userData($user->getUser());
		$me = o2array($me);
	}
}

$page   = 'general';
$pages  = array(
	'delete',
	'password',
	'general',
	'profile',
	'privacy',
	'notifications',
	'verification',
	'blocked',
	'manage_sessions'
);

if (!empty($_GET['page']) && in_array($_GET['page'], $pages)) {
	$page = $_GET['page'];
}

if ($page == 'delete' && $config['delete_account'] != 'on') {
	$page = 'general';
}

$context['page_title'] = lang('profile_settings');
$context['page'] = $page;
$context['me'] = $me;
$context['settings'] = $me;

if ($page == 'blocked') {
	$blocked = $user->getBlockedUsers();
	$blocked = (is_array($blocked) == true) ? $blocked : array();
	$context['blocked_users'] = o2array($blocked);
}
if ($page == 'verification') {
	$context['is_verified'] = $user->isVerificationRequested();
	if ($me['verified']) {
		header("Location: $site_url/welcome");
	    exit;
	}
}

if ($page == 'manage_sessions') {
	$context['sessions'] = o2array($user->getUserSessions());
	
}
$context['app_name'] = 'settings';
$context['xhr_url'] = "$site_url/aj/settings";
$context['content'] = $pixelphoto->PX_LoadPage('settings/templates/settings/index');