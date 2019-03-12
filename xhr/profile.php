<?php 

if ($action == 'load-user-followers') {
	$vl1 = (!empty($_GET['offset']) && is_numeric($_GET['offset']));
	$vl2 = (!empty($_GET['user_id']) && is_numeric($_GET['user_id']));

	if ($vl1 && $vl2) {
		$offset  = $_GET['offset'];
		$user_id = $_GET['user_id'];

		$user->setUserById($user_id);
		$following_ls   = $user->getFollowers($offset,50);
		$data['status'] = 404;

		if (!empty($following_ls)) {
			$data['html']   = "";
			$data['status'] = 200;
			$following_ls   = o2array($following_ls);

			foreach ($following_ls as $udata) {
				$data['html']    .= $pixelphoto->PX_LoadPage('profile/templates/profile/includes/followers-ls-item');
			}
		}
	}
}

if ($action == 'load-user-following') {
	$vl1 = (!empty($_GET['offset']) && is_numeric($_GET['offset']));
	$vl2 = (!empty($_GET['user_id']) && is_numeric($_GET['user_id']));

	if ($vl1 && $vl2) {
		$offset  = $_GET['offset'];
		$user_id = $_GET['user_id'];

		$user->setUserById($user_id);
		$following_ls   = $user->getFollowing($offset,50);
		$data['status'] = 404;

		if (!empty($following_ls)) {
			$data['html']   = "";
			$data['status'] = 200;
			$following_ls   = o2array($following_ls);

			foreach ($following_ls as $udata) {
				$data['html']    .= $pixelphoto->PX_LoadPage('profile/templates/profile/includes/following-ls-item');
			}
		}
	}
}