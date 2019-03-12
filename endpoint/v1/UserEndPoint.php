<?php 

class UserEndPoint extends Generic {



	public function __construct($api_resource_id)
	{
		switch ($api_resource_id) {
			case 'fetch_blocked_users':
				self::fetch_blocked_users();
				break;
			case 'block':
				self::block_user();
				break;
			case 'report_user':
				self::_report_user();
				break;
			case 'follow':
				self::follow_();
				break;
			case 'followers':
				self::followers_();
				break;
			case 'following':
				self::following_();
				break;
			case 'fetch_suggestions':
				self::fetch_suggestions_();
				break;
			case 'fetch_notifications':
				self::fetch_notifications_();
				break;
			case 'fetch_userdata':
				self::fetch_userdata_();
				break;
			case 'fetch_activities':
				self::fetch_activities_();
				break;
			case 'search':
				self::search_();
				break;
			default:
				$response_data = array(
			        'code'     => '400',
			        'status'   => 'Bad Request',
			        'errors'         => array(
			            'error_id'   => '1',
			            'error_text' => 'Error: 404 API Version Not Found'
			        )
			    );
			    self::json($response_data);
				break;
		}
	}


	    private function fetch_blocked_users() {
	    	if (IS_LOGGED == false) {
	    		$response_data       = array(
			        'code'     => '400',
				    'status'   => 'Bad Request',
			        'errors'         => array(
			            'error_id'   => '17',
			            'error_text' => 'Please Login And Try Again'
			        )
			    );
			    self::json($response_data);
	    	}
	    	else{
	    		$user = new User();
	    		$blocked = $user->getBlockedUsers();
	    		foreach ($blocked as $value) {
	    			$value->avatar = media($value->avatar);
	    		}
				$response_data       = array(
			        'code'     => '200',
				    'status'   => 'OK',
			        'data'         => $blocked
			    );
			    self::json($response_data);
	    	}

	    }



	    private function block_user() {
	    	global $me;
	    	if (IS_LOGGED == false) {
	    		$response_data       = array(
			        'code'     => '400',
				    'status'   => 'Bad Request',
			        'errors'         => array(
			            'error_id'   => '17',
			            'error_text' => 'Please Login And Try Again'
			        )
			    );
			    self::json($response_data);
	    	}
	    	elseif (empty($_POST['user_id'])) {
	    		$response_data       = array(
			        'code'     => '400',
				    'status'   => 'Bad Request',
			        'errors'         => array(
			            'error_id'   => '20',
			            'error_text' => 'Please Enter the user id'
			        )
			    );
			    self::json($response_data);
	    	}
	    	else{
	    		if (is_numeric($_POST['user_id'])) {
	    			$user = new User();
					$user_id = $_POST['user_id'];
					$notif   = new Notifications();
					$code    = $user->blockUser($user_id);
					$code    = ($code == -1) ? 0 : 1;

					if (in_array($code, array(0,1))) {

						if ($code == 0) {
							$response_data       = array(
						        'code'     => '200',
							    'status'   => 'OK',
						        'data'         => array(
						            'message'   => 'This profile has been unblocked, You can block them anytime from their profile.',
						            'code'      => $code
						        )
						    );
						    self::json($response_data);
						}
						else if($code == 1){
							$notif->notifier_id = $user_id; 
							$notif->setUserById($me['user_id'])->clearNotifications();
							$response_data       = array(
						        'code'     => '200',
							    'status'   => 'OK',
						        'data'         => array(
						            'message'   => 'This profile has been blocked, You can unblock them anytime from their profile.',
						            'code'      => $code
						        )
						    );
						    self::json($response_data);
						}
					}
				}
	    	}

	    }


	    private function _report_user() {
	    	if (IS_LOGGED == false) {
	    		$response_data       = array(
			        'code'     => '400',
				    'status'   => 'Bad Request',
			        'errors'         => array(
			            'error_id'   => '17',
			            'error_text' => 'Please Login And Try Again'
			        )
			    );
			    self::json($response_data);
	    	}
	    	elseif (empty($_POST['user_id']) || (!in_array($_POST['type'], range(1, 8)) && $_POST['type'] != -1 ) ) {
	    		$response_data       = array(
			        'code'     => '400',
				    'status'   => 'Bad Request',
			        'errors'         => array(
			            'error_id'   => '16',
			            'error_text' => 'please check your details'
			        )
			    );
			    self::json($response_data);
	    	}
	    	else{
	    		if (is_numeric($_POST['user_id']) && !empty($_POST['type'])) {
					$user_id = $_POST['user_id'];
					$type    = $_POST['type'];
					if (in_array($type, range(1, 8)) || $type == -1) {
						$user = new User();
						$code = $user->reportUser($user_id,$type);
						$code = ($code == -1) ? 0 : 1;

						if ($code == 0) {
							$response_data       = array(
						        'code'     => '200',
							    'status'   => 'OK',
						        'data'         => array(
						            'message'   => 'Your report has been canceled!',
						            'type'      => $code
						        )
						    );
						    self::json($response_data);
						}

						else if($code == 1){
							$response_data       = array(
						        'code'     => '200',
							    'status'   => 'OK',
						        'data'         => array(
						            'message'   => 'Your report has been sent!',
						            'type'      => $code
						        )
						    );
						    self::json($response_data);
						}
					}
				}
	    	}

	    }


	    private function follow_() {
	    	global $me;
	    	if (IS_LOGGED == false) {
	    		$response_data       = array(
			        'code'     => '400',
				    'status'   => 'Bad Request',
			        'errors'         => array(
			            'error_id'   => '17',
			            'error_text' => 'Please Login And Try Again'
			        )
			    );
			    self::json($response_data);
	    	}
	    	elseif (empty($_POST['user_id'])) {
	    		$response_data       = array(
			        'code'     => '400',
				    'status'   => 'Bad Request',
			        'errors'         => array(
			            'error_id'   => '20',
			            'error_text' => 'Please Enter the user id'
			        )
			    );
			    self::json($response_data);
	    	}
	    	else{
				$follower_id  = $me['user_id'];
				$following_id = Generic::secure($_POST['user_id']);
				$notif        = new Notifications();
				$user         = new User();
				$user->setUserById($follower_id);
				$status       = $user->follow($following_id);
				if ($status === 1) {
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
					$response_data       = array(
				        'code'     => '200',
					    'status'   => 'OK',
				        'type'         => 1
				    );
				    self::json($response_data);
				}

				else if($status === -1){
					$response_data       = array(
				        'code'     => '200',
					    'status'   => 'OK',
				        'type'         => 0
				    );
				    self::json($response_data);
				}
	    	}
	    }





	    private function followers_() {
	    	global $me;
	    	if (IS_LOGGED == false) {
	    		$response_data       = array(
			        'code'     => '400',
				    'status'   => 'Bad Request',
			        'errors'         => array(
			            'error_id'   => '17',
			            'error_text' => 'Please Login And Try Again'
			        )
			    );
			    self::json($response_data);
	    	}
	    	elseif (empty($_POST['user_id'])) {
	    		$response_data       = array(
			        'code'     => '400',
				    'status'   => 'Bad Request',
			        'errors'         => array(
			            'error_id'   => '20',
			            'error_text' => 'Please Enter the user id'
			        )
			    );
			    self::json($response_data);
	    	}
	    	else{
	    		$offset  = !empty($_POST['offset']) ? Generic::secure($_POST['offset']) : false;
	    		$limit  = !empty($_POST['limit']) && $_POST['limit'] <= 50 ? Generic::secure($_POST['limit']) : 20;
				$user_id = Generic::secure($_POST['user_id']);
				$user         = new User();
				$user->setUserById($user_id);
				$followers_ls = $user->getFollowers($offset,$limit);
				foreach ($followers_ls as $value) {
					unset($value->password);
					unset($value->email_code);
					unset($value->login_token);
					unset($value->edit);
					$value->time_text = time2str($value->last_seen);
	    			$value->cover = media($value->cover);
	    			$value->avatar = media($value->avatar);
	    		}
				$response_data       = array(
			        'code'     => '200',
				    'status'   => 'OK',
			        'data'         => $followers_ls
			    );
			    self::json($response_data);
	    	}
	    }


	    private function following_() {
	    	global $me;
	    	if (IS_LOGGED == false) {
	    		$response_data       = array(
			        'code'     => '400',
				    'status'   => 'Bad Request',
			        'errors'         => array(
			            'error_id'   => '17',
			            'error_text' => 'Please Login And Try Again'
			        )
			    );
			    self::json($response_data);
	    	}
	    	elseif (empty($_POST['user_id'])) {
	    		$response_data       = array(
			        'code'     => '400',
				    'status'   => 'Bad Request',
			        'errors'         => array(
			            'error_id'   => '20',
			            'error_text' => 'Please Enter the user id'
			        )
			    );
			    self::json($response_data);
	    	}
	    	else{
	    		$offset  = !empty($_POST['offset']) ? Generic::secure($_POST['offset']) : false;
	    		$limit  = !empty($_POST['limit']) && $_POST['limit'] <= 50 ? Generic::secure($_POST['limit']) : 20;
				$user_id = Generic::secure($_POST['user_id']);
				$user         = new User();
				$user->setUserById($user_id);
				$following_ls = $user->getFollowing($offset,$limit);
				foreach ($following_ls as $value) {
	    			unset($value->password);
					unset($value->email_code);
					unset($value->login_token);
					unset($value->edit);
					$value->time_text = time2str($value->last_seen);
	    			$value->cover = media($value->cover);
	    			$value->avatar = media($value->avatar);
	    		}
				$response_data       = array(
			        'code'     => '200',
				    'status'   => 'OK',
			        'data'         => $following_ls
			    );
			    self::json($response_data);
	    	}
	    }



	    private function fetch_suggestions_() {
	    	global $me;
	    	if (IS_LOGGED == false) {
	    		$response_data       = array(
			        'code'     => '400',
				    'status'   => 'Bad Request',
			        'errors'         => array(
			            'error_id'   => '17',
			            'error_text' => 'Please Login And Try Again'
			        )
			    );
			    self::json($response_data);
	    	}
	    	else{
	    		$offset  = !empty($_POST['offset']) ? Generic::secure($_POST['offset']) : false;
	    		$limit  = !empty($_POST['limit']) && $_POST['limit'] <= 50 ? Generic::secure($_POST['limit']) : 5;
	    		$user         = new User();
	    		$user->setUserById($me['user_id']);
	    		$follow   = $user->followSuggestions($limit,$offset);
				foreach ($follow as $value) {
	    			unset($value->password);
					unset($value->email_code);
					unset($value->login_token);
					unset($value->edit);
					$value->time_text = time2str($value->last_seen);
	    			$value->cover = media($value->cover);
	    			$value->avatar = media($value->avatar);
	    		}
				$response_data       = array(
			        'code'     => '200',
				    'status'   => 'OK',
			        'data'         => $follow
			    );
			    self::json($response_data);
	    	}
	    }


	    private function fetch_notifications_() {
	    	global $me;
	    	if (IS_LOGGED == false) {
	    		$response_data       = array(
			        'code'     => '400',
				    'status'   => 'Bad Request',
			        'errors'         => array(
			            'error_id'   => '17',
			            'error_text' => 'Please Login And Try Again'
			        )
			    );
			    self::json($response_data);
	    	}
	    	else{
	    		$types = array(
				'followed_u' => 'followed_u',
				'liked_ur_post' => 'liked_ur_post',
				'commented_ur_post' => 'commented_ur_post',
				'mentioned_u_in_comment' => 'mentioned_u_in_comment',
				'mentioned_u_in_post' => 'mentioned_u_in_post');

	    		$notif = new Notifications();
	    		$messages     = new Messages();
				$data  = array();
				$offset  = !empty($_POST['offset']) ? Generic::secure($_POST['offset']) : false;

				$notif->setUserById($me['user_id']);
				$notif->type    = 'new';
				$new_notifications = $notif->getNotifications();
				$notif->type    = 'all';
				$notif->limit   = !empty($_POST['limit']) && $_POST['limit'] <= 50 ? Generic::secure($_POST['limit']) : 20;
				$notifications       = $notif->getNotifications($offset);
				
				$messages->setUserById($me['user_id']);
				$new_messages = $messages->countNewMessages();
				foreach ($notifications as $key => $value) {
					$value->post_id = 0;
					$value->post_data = '';
					if ($value->type == 'liked_ur_post' || $value->type == 'commented_ur_post' || $value->type == 'mentioned_u_in_comment' || $value->type == 'mentioned_u_in_post') {
						$value->post_id = substr($value->url, strpos($value->url, 'post/') + 5);
						$posts             = new Posts();
						if (is_numeric($value->post_id) && $value->post_id > 0) {
							$value->post_data = $posts->setPostId($value->post_id)->postData();
							foreach ($value->post_data->media_set as $key => $value2) {
								$value2->file = media($value2->file);
				    			$value2->extra = media($value2->extra);
							}
							foreach ($value->post_data->comments as $key => $comment) {
								$comment->avatar = media($comment->avatar);
								$comment->text = strip_tags($comment->text);
								$comment->time_text = time2str($comment->time);
								$comment->text  = $posts->tagifyHTags($comment->text);
								$user         = new User();
								$new_user = $user->getUserDataById($comment->user_id);
								$comment->name = $new_user->name;
							}
							$user         = new User();
							$new_user = $user->getUserDataById($value->post_data->user_id);
							$value->post_data->name = $new_user->name;
			    			$value->post_data->avatar = media($value->post_data->avatar);
			    			$value->post_data->description = strip_tags($value->post_data->description);
			    			$value->post_data->time_text = time2str($value->post_data->time);
			    			$value->post_data->description  = $posts->tagifyHTags($value->post_data->description);
						}
					}
					$value->text = lang($types[$value->type]);
					$value->avatar = media($value->avatar);
		    		$user         = new User();
		    		$user->setUserById($value->notifier_id);
					$user_data = $user->getUserDataById($value->notifier_id);
					unset($user_data->password);
					unset($user_data->email_code);
					unset($user_data->login_token);
					unset($user_data->edit);
					$user_data->time_text = time2str($user_data->last_seen);
	    			$user_data->cover = media($user_data->cover);
	    			$user_data->avatar = media($user_data->avatar);
	    			$user_data->is_following = $user->isFollowing($user_data->user_id,$me['user_id']);
	    			$user_data->is_blocked  = $user->isBlocked($user_id,false);
	    			$value->user_data = $user_data;
				}
	    		
				$response_data       = array(
			        'code'     => '200',
				    'status'   => 'OK',
			        'data'         => $notifications,
			        'new_notifications' => $new_notifications,
			        'new_messages' => $new_messages
			    );
			    self::json($response_data);
	    	}
	    }



	    private function fetch_userdata_() {
	    	global $me;
	    	if (IS_LOGGED == false) {
	    		$response_data       = array(
			        'code'     => '400',
				    'status'   => 'Bad Request',
			        'errors'         => array(
			            'error_id'   => '17',
			            'error_text' => 'Please Login And Try Again'
			        )
			    );
			    self::json($response_data);
	    	}
	    	elseif (empty($_POST['user_id'])) {
	    		$response_data       = array(
			        'code'     => '400',
				    'status'   => 'Bad Request',
			        'errors'         => array(
			            'error_id'   => '20',
			            'error_text' => 'Please Enter the user id'
			        )
			    );
			    self::json($response_data);
	    	}
	    	else{
	    		$user_id = Generic::secure($_POST['user_id']);
	    		$user         = new User();
	    		$user->setUserById($user_id);
				$user_data = $user->getUserDataById($user_id);
				unset($user_data->password);
				unset($user_data->email_code);
				unset($user_data->login_token);
				unset($user_data->edit);
				$user_data->time_text = time2str($user_data->last_seen);
    			$user_data->cover = media($user_data->cover);
    			$user_data->avatar = media($user_data->avatar);
    			$user_data->is_following = $user->isFollowing($user_data->user_id,$me['user_id']);
    			$user_data->is_blocked  = $user->isBlocked($user_id,false);
	    		
				$response_data       = array(
			        'code'     => '200',
				    'status'   => 'OK',
			        'data'         => $user_data
			    );
			    self::json($response_data);
	    	}
	    }



	    private function search_() {
	    	global $me;
	    	if (IS_LOGGED == false) {
	    		$response_data       = array(
			        'code'     => '400',
				    'status'   => 'Bad Request',
			        'errors'         => array(
			            'error_id'   => '17',
			            'error_text' => 'Please Login And Try Again'
			        )
			    );
			    self::json($response_data);
	    	}
	    	elseif (empty($_POST['word'])) {
	    		$response_data       = array(
			        'code'     => '400',
				    'status'   => 'Bad Request',
			        'errors'         => array(
			            'error_id'   => '33',
			            'error_text' => 'Please Enter a word to search'
			        )
			    );
			    self::json($response_data);
	    	}
	    	else{
	    		$word          = Generic::secure($_POST['word']);
	    		$user          = new User();
	    		$posts         = new Posts();
	    		$data          = array();
	    		$offset  = !empty($_POST['offset']) ? Generic::secure($_POST['offset']) : false;
	    		$tagoffset  = !empty($_POST['tagoffset']) ? Generic::secure($_POST['tagoffset']) : false;
	    		$users = $user->seachUsers($word,20,$offset,'ASC');
	    		$data['users'] = array();
	    		foreach ($users as $key => $value) {
	    			$user->setUserByName($value->username);
	    			$new_user = $user->userData($user->getUser());
	    			unset($new_user->password);
					unset($new_user->email_code);
					unset($new_user->login_token);
					unset($new_user->edit);
					$new_user->time_text = time2str($new_user->last_seen);
	    			$new_user->cover = media($new_user->cover);
	    			$new_user->avatar = media($new_user->avatar);
	    			$new_user->is_following = $user->isFollowing($new_user->user_id,$me['user_id']);


					$data['users'][] = $new_user;
	    		}
	    		$data['hash']  = $posts->searchPosts($word,20,$tagoffset);

				$response_data       = array(
			        'code'     => '200',
				    'status'   => 'OK',
			        'data'         => $data
			    );
			    self::json($response_data);
	    	}
	    }

	    private function fetch_activities_() {
	    	global $me;
	    	if (IS_LOGGED == false) {
	    		$response_data       = array(
			        'code'     => '400',
				    'status'   => 'Bad Request',
			        'errors'         => array(
			            'error_id'   => '17',
			            'error_text' => 'Please Login And Try Again'
			        )
			    );
			    self::json($response_data);
	    	}
	    	else{
	    		$posts         = new Posts();
	    		$offset  = !empty($_POST['offset']) ? Generic::secure($_POST['offset']) : false;
	    		$limit   = !empty($_POST['limit']) && $_POST['limit'] <= 50 ? Generic::secure($_POST['limit']) : 20;
	    		$activities = $posts->getUsersActivities($offset,$limit);
	    		foreach ($activities as $key => $value) {
	    			$value->text = strip_tags($value->text);
	    			if (!isset($value->following_data)) {
	    				$value->following_data = '';
	    			}
	    			if ($value->post_id == 0) {
	    				$value->post_data = '';
	    			}
	    			else{
	    				$posts   = new Posts();
						$post_id = $value->post_id;
						$post      = $posts->setPostId($post_id)->postData();

						if (!empty($post)) {
							foreach ($post->media_set as $key => $value2) {
								$value2->file = media($value2->file);
				    			$value2->extra = media($value2->extra);
							}
							foreach ($post->comments as $key => $comment) {
								$comment->avatar = media($comment->avatar);
								$comment->text = strip_tags($comment->text);
								$comment->time_text = time2str($comment->time);
								$comment->text  = $posts->tagifyHTags($comment->text);
								$user         = new User();
								$new_user = $user->getUserDataById($comment->user_id);
								$comment->name = $new_user->name;
							}
							$user         = new User();
							$user->setUserById($post->user_id);
							$new_user = $user->getUserDataById($post->user_id);
							$post->name = $new_user->name;
							$post->avatar = media($post->avatar);
							$post->description = strip_tags($post->description);
							$post->time_text = time2str($post->time);
							$post->description  = $posts->tagifyHTags($post->description);
							$value->post_data = $post;
						}
	    			}
	    		}
				$response_data       = array(
			        'code'     => '200',
				    'status'   => 'OK',
			        'data'         => $activities
			    );
			    self::json($response_data);
	    	}
	    }


	    














}
