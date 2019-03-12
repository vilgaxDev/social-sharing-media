<?php 

if ($action == 'follow' && IS_LOGGED) {
	if (!empty($_GET['user_id']) && is_numeric($_GET['user_id'])) {
		$follower_id  = $me['user_id'];
		$following_id = Generic::secure($_GET['user_id']);
		$notif        = new Notifications();
		$user->setUserById($follower_id);
		$status       = $user->follow($following_id);
		$data['status'] = 400;
		if ($status === 1) {
			$data['status'] = 200;
			$data['code'] = 1;

			#Notify post owner
			$notif_conf = $notif->notifSettings($following_id,'on_follow');
			if ($notif_conf) {
				$re_data = array(
					'notifier_id' => $me['user_id'],
					'recipient_id' => $following_id,
					'type' => 'followed_u',
					'url' => un2url($me['username']),
					'time' => time()
				);
				
				$notif->notify($re_data);
			}	
		}

		else if($status === -1){
			$data['status'] = 200;
			$data['code'] = 0;
		}

		goto exit_xhr;
	}
}

else if($action == 'get_notif' && IS_LOGGED){
	$notif = new Notifications();
	$data  = array();

	$notif->setUserById($me['user_id']);
	$notif->type    = 'all';
	$notif->limit   = 1000;
	$queryset       = $notif->getNotifications();

	if (!empty($queryset) && is_array($queryset)) {
		$new_notif      = o2array($queryset);
		$context['notifications'] = $new_notif;
		$data['html']    = $pixelphoto->PX_LoadPage('main/templates/header/notifications');
		$data['status'] = 200;
	}

	else{
		$data['status']  = 304;
		$data['message'] = lang('u_dont_have_notif');
	}
}

elseif ($action == 'update-data' && IS_LOGGED) {
	$data  = array();
	$notif = new Notifications();

	$notif->setUserById($me['user_id']);
	$notif->type    = 'new';
	$new_notif      = $notif->getNotifications();
	$data['notif']  = (is_numeric($new_notif)) ? $new_notif : 0;

	if (!empty($_GET['new_messages'])) {
		$messages     = new Messages();
		$messages->setUserById($me['user_id']);
		$new_messages = $messages->countNewMessages();
		$data['new_messages'] = $new_messages;
	}
}

elseif ($action == 'explore-people' && IS_LOGGED) {
	if (!empty($_GET['offset']) && is_numeric($_GET['offset'])) {
		$user->limit = 100;
		$offset      = $_GET['offset'];
		$users       = $user->explorePeople($offset);
		$data        = array('status' => 404);

		if (!empty($users)) {
			$users = o2array($users);
			$html  = "";

			foreach ($users as $udata) {
				$html    .= $pixelphoto->PX_LoadPage('explore/templates/explore/includes/row');
			}

			$data = array(
				'status' => 200,
				'html' => $html
			);
		}
	}
}

elseif ($action == 'report-profile' && IS_LOGGED && !empty($_POST['id'])){
	if (is_numeric($_POST['id']) && !empty($_POST['t'])) {
		$user_id = $_POST['id'];
		$type    = $_POST['t'];
		$data    = array('status' => 304);
		if (in_array($type, range(1, 8)) || $type == -1) {
			$code = $user->reportUser($user_id,$type);
			$code = ($code == -1) ? 0 : 1;
			$data = array(
				'status' => 200,
				'code' => $code,
			);

			if ($code == 0) {
				$data['message'] = lang('report_canceled');
			}

			else if($code == 1){
				$data['message'] = lang('report_sent');
			}
		}
	}
}

elseif ($action == 'block-user' && IS_LOGGED && !empty($_POST['id'])){
	if (is_numeric($_POST['id'])) {
		$user_id = $_POST['id'];
		$data    = array('status' => 304);
		$notif   = new Notifications();
		$code    = $user->blockUser($user_id);
		$code    = ($code == -1) ? 0 : 1;

		if (in_array($code, array(0,1))) {
			$data    = array(
				'status' => 200,
				'code' => $code,
			);

			if ($code == 0) {
				$data['message'] = lang('user_unblocked');
			}

			else if($code == 1){
				$data['message']    = lang('user_blocked');
				$notif->notifier_id = $user_id; 
				$notif->setUserById($me['user_id'])->clearNotifications();
			}
		}
	}
}

elseif ($action == 'search-users' && !empty($_POST['kw'])){
	if (len($_POST['kw']) >= 0) {
		$kword    = $_POST['kw'];
		$data     = array('status' => 304);
		$queryset = $user->seachUsers($kword);
		$html     = "";

		if(!empty($queryset)){
			$queryset = o2array($queryset);

			foreach ($queryset as $udata) {
				$html .= $pixelphoto->PX_LoadPage('main/templates/header/search-usrls');
			}

			$data['status'] = 200;
			$data['html']   = $html;
		}
	}
}

elseif ($action == 'search-posts' && !empty($_POST['kw'])){
	if (len($_POST['kw']) >= 0) {
		$posts    = new Posts();
		$kword    = $_POST['kw'];
		$data     = array('status' => 304);
		$queryset = $posts->searchPosts($kword);
		$html     = "";

		if(!empty($queryset)){
			$queryset = o2array($queryset);

			foreach ($queryset as $htag) {
				$htag['url'] = sprintf('%s/explore/tags/%s',$site_url,$htag['tag']);
				$context['htag'] = $htag;
				$html    .= $pixelphoto->PX_LoadPage('main/templates/header/search-posts');
			}

			$data['status'] = 200;
			$data['html']   = $html;
		}
	}
}
elseif ($action == 'contact_us'){
	$data['status'] = 400;
	if (empty($_POST['first_name']) || empty($_POST['last_name']) || empty($_POST['email']) || empty($_POST['message'])) {
		$data['message'] = lang('please_check_details');
	}
	else if (!filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
        $data['message'] = lang('email_invalid_characters');
    }
	else{
		$first_name        = Generic::secure($_POST['first_name']);
        $last_name         = Generic::secure($_POST['last_name']);
        $email             = Generic::secure($_POST['email']);
        $message           = Generic::secure($_POST['message']);
        $name              = $first_name . ' ' . $last_name;
		$message_text = "<p><strong>Name</strong> : {$name}</p>
						 <br>
						 <p><strong>Email</strong> : {$email}</p>
						 <br>
						 <p><strong>Message</strong> : {$message}</p>
						 ";

        $send_email_data = array(
            'from_email' => $config->site_email,
            'from_name' => $name,
            'reply-to' => $email,
            'to_email' => $config->site_email,
            'to_name' => $user_data->name,
            'subject' => 'Contact us new message',
            'charSet' => 'UTF-8',
            'message_body' => $message_text,
            'is_html' => true
        );
        $send_message = Generic::sendMail($send_email_data);
        if ($send_message) {
            $data['status'] = 200;
            $data['message'] = lang('email_sent');
        }else{
        	$data['message'] = lang('unknown_error');
        }
	}
}

elseif ($action == 'change_mode') {

	if ($_COOKIE['mode'] == 'day') {
		setcookie("mode", 'night', time() + (10 * 365 * 24 * 60 * 60), "/");
		$data = array('status' => 200,
	                  'type' => 'night',
	                  'link' => $config['site_url'].'/apps/'.$config['theme'].'/main/static/css/styles.master_night.css');
	}
	else{
		setcookie("mode", 'day', time() + (10 * 365 * 24 * 60 * 60), "/");
		$data = array('status' => 200,
	                  'type' => 'day');
	}
}

elseif ($action == 'get_more_activities') {
	$data = array('status' => 400);

	if (!empty($_POST['id']) && is_numeric($_POST['id'])) {
		$html = '';
		$posts  = new Posts();
		$offset = Generic::secure($_POST['id']);
		$activities = $posts->getUsersActivities($offset,5);
		$activities = o2array($activities);
		if (!empty($activities)) {
			foreach ($activities as $key => $value) {
				$context['activity'] = $value;
				$html    .= $pixelphoto->PX_LoadPage('home/templates/home/includes/activity');
			}
			$data = array('status' => 200,
		                  'html'   => $html);
		}
		else{
			$data['text'] = lang('no_more_activities');
		}
	}
	
}
elseif ($action == 'update_user_lastseen') {
	if (isset($_SESSION['user_id']) && !empty($_SESSION['user_id'])) {
        $db->where('session_id', $_SESSION['user_id'])->update(T_SESSIONS, array('time' => time()));
    } else if (!empty($_COOKIE['user_id']) && !empty($_COOKIE['user_id'])) {
    	$db->where('session_id', $_COOKIE['user_id'])->update(T_SESSIONS, array('time' => time()));
	}
	
	$data = array('status' => 200);
}

exit_xhr: