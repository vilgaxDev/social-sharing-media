<?php 

/**
* User class, everything related to users.
*/
class User extends Generic{
	protected $user_id = 0;
	public $user_data = array();
	public $limit = 20;

	public static $user;
	protected static $me;

	public function __construct() {}

	public function getAllUsers(){
		$users = self::$db->get(T_USERS,$this->limit);
		$data  = array();
		foreach ($users as $key => $user_data) {
			$user_data = $this->userData($user_data);
			$data[]    = $user_data;
		}

		return $data;
	}

	public function offset($whereProp, $whereValue = 'DBNULL', $operator = '=', $cond = 'AND'){
		self::$db->where($whereProp, $whereValue, $operator);
		return $this;
	}

	public function orderBy($col = false,$type = false){
		self::$db->orderBy($col,$type);
		return $this;
	}

	// set user ID to use in the CLass.
	public function setUserById( $user_id = 0) {
		$this->user_id = self::secure($user_id);
		if (empty($this->user_id)) {
			$this->throwError("User doesn't exist");
		}
		return $this;
	}

	public function updateLastSeen(){
		if (empty(self::$me)) {
			return false;
		}
		
		self::$db->where('user_id',self::$me->user_id);
		return self::$db->update(T_USERS,array('last_seen' => time()));
	}

	// set the user in class by email
	public function setUserByEmail($email) {
		$this->user_id = self::$db->where('email', $this->secure($email))->getValue(T_USERS, 'user_id');
		if (empty($this->user_id)) {
			$this->throwError("User doesn't exist");
		}
		return $this;
	}

	// set the user in class by username
	public function setUserByName($username) {
		$this->user_id = self::$db->where('username', $this->secure($username))->getValue(T_USERS, 'user_id');
		if (empty($this->user_id)) {
			$this->throwError("User doesn't exist");
		}
		return $this->user_id;
	}

	// check if a user by username exists
	public static function userNameExists($username) {
		$user_id = self::$db->where('username', self::secure($username))->getValue(T_USERS, 'user_id');
		return (empty($user_id)) ? false : true;
	}

	// check if a user by email exits
	public static function userEmailExists($email) {
		$user_id = self::$db->where('email', self::secure($email))->getValue(T_USERS, 'user_id');
		return (empty($user_id)) ? false : true;
	}

    // return the user data (object)
	public function getUser() {
		return $this->fetchUser();
	}

	// export user data from class
	public static function getStaticUser($user_id = 0) {
		if (!empty($user_id)) {
			$user = new User;
			$user->setUserById($user_id)->getUser();
		}
		return self::$user;
	}

	// export logged in data from class
	public static function getStaticLoggedInUser() {
		return self::$me;
	}

	// update user stactily
	public function updateStatic( $id = 0, $data = array()) {
		return self::$db->where('user_id', $id)->update(T_USERS, $data);
	}

	// check for reset check
	public static function validateCode($code = '') {
		return self::$db->where('email_code', $code)->getValue(T_USERS, 'user_id');
	}

	// get user data from the database
	private function fetchUser() {
	    $this->user_data = self::$db->where('user_id', $this->user_id)->getOne(T_USERS);
	    

	    if (empty($this->user_data)) {
	    	return false;
	    }
	    
		$this->user_data->name  = $this->user_data->username;


	    if (!empty($this->user_data->fname) && !empty($this->user_data->lname)) {
	    	$this->user_data->name = sprintf('%s %s',$this->user_data->fname,$this->user_data->lname);
	    }

	    $this->user_data->avatar = media($this->user_data->avatar);
	    $this->user_data->cover = media($this->user_data->cover);
	    $this->user_data->uname = sprintf('@%s',$this->user_data->username);
	    $this->user_data->url = sprintf('%s/@%s',self::$site_url,$this->user_data->username);

	    self::$user = $this->user_data;
	    return $this->user_data;
	}

	// get user data from the object
	public function userData($user_data = null) {
	    $this->user_data = $user_data;

	    if (empty($this->user_data)) {
	    	$this->throwError("Invalid argument: user_data must be a instance of " . T_USERS);
	    }


	    $this->user_data->name  = $this->user_data->username;
	    if (!empty($this->user_data->fname) && !empty($this->user_data->lname)) {
	    	$this->user_data->name = sprintf('%s %s',$this->user_data->fname,$this->user_data->lname);
	    }

	    $this->user_data->avatar   = media($this->user_data->avatar);
	    $this->user_data->uname    = sprintf('@%s',$this->user_data->username);
	    $this->user_data->url      = sprintf('%s/@%s',self::$site_url,$this->user_data->username);
	    $this->user_data->edit     = sprintf('%s/settings/general/%s',self::$site_url,$this->user_data->username);
	    
	    if (len($this->user_data->website)) {
	    	$this->user_data->website  = urldecode($this->user_data->website);
	    }	
	        
	    if (len($this->user_data->facebook)) {
	    	$this->user_data->facebook  = urldecode($this->user_data->facebook);
	    }	
	            
	    if (len($this->user_data->google)) {
	    	$this->user_data->google  = urldecode($this->user_data->google);
	    }	 
	               
	    if (len($this->user_data->twitter)) {
	    	$this->user_data->twitter  = urldecode($this->user_data->twitter);
	    }
	    $this->user_data->followers    = $this->countFollowers();
		$this->user_data->following    = $this->countFollowing();
		$posts   = new Posts();
		$posts->setUserById($this->user_data->user_id);
		$this->user_data->favourites = $posts->countSavedPosts();
		$this->user_data->posts_count = $posts->countPosts();

		
	    self::$user = $this->user_data;
	    return $this->user_data;
	}

	public function getUserDataById($user_id = false){
		if (empty($user_id)) {
			return false;
		}

		self::$db->where('user_id',$user_id);
		$user_data = self::$db->getOne(T_USERS);

		if (!empty($user_data)) {
			return $this->userData($user_data);
		}

		return false;
	}

    // check if the user is logged in
	public function isLogged() {
		$id = 0;
		// ************ pixelphoto_API ******************
		if (self::isEndPointRequest()) {
			if (isset($_POST['access_token']) && !empty($_POST['access_token'])) {
				$id = self::$db->where('session_id', Generic::secure($_POST['access_token']))->getValue(T_SESSIONS, 'user_id');

			}
		}
		else{
			if (isset($_SESSION['user_id']) && !empty($_SESSION['user_id'])) {
		        $id = self::$db->where('session_id', $_SESSION['user_id'])->getValue(T_SESSIONS, 'user_id');
		    } else if (!empty($_COOKIE['user_id']) && !empty($_COOKIE['user_id'])) {
		        $id = self::$db->where('session_id', $_COOKIE['user_id'])->getValue(T_SESSIONS, 'user_id');
			}
		}
	    return (is_numeric($id) && !empty($id)) ? true : false;
	}
	
	// get logged in user data
	public function getLoggedInUser() {
		// ************ pixelphoto_API ******************
		if (!empty($_SESSION['user_id'])) {
			$session_id = $_SESSION['user_id'];
		}
		elseif (isset($_POST['access_token']) && !empty($_POST['access_token'])) {
			$session_id = Generic::secure($_POST['access_token']);
		}
		else{
			$session_id = $_COOKIE['user_id'];
		}
		//$session_id = (!empty($_SESSION['user_id'])) ? $_SESSION['user_id'] : $_COOKIE['user_id'];
        $user_id  = self::$db->where('session_id', $session_id)->getValue(T_SESSIONS, 'user_id');
		return self::$me = $this->setUserById($user_id)->getUser();
	}

	// check if user is admin
	public function isAdmin() {
		return ($this->user_data->admin == 1) ? true : false;
	}


	// check if user is authorized for an action
	public function isOwner( $user_id = 0) {
		return ($this->user_data->user_id == $user_id) ? true : false;
	}

	// register a new user
	public static function registerUser(){
		$gender = 'male';
		$active = (self::$config['email_validation'] == 'on') ? 0 : 1;
		$email_validation = (self::$config['email_validation'] == 'on') ? 0 : 1;
		$email_code = "";

		if ($_POST['gender'] == 'female') {
			$gender = 'female';
		}

		$insert_data = array(
            'username' => self::secure($_POST['username']),
            'password' => sha1($_POST['password']),
            'email' => self::secure($_POST['email']),
            'ip_address' => '0.0.0.0',
            'gender' => $gender,
            'active' => $active,
            'last_seen' => time(),
            'registered' => date('Y') . '/' . intval(date('m'))
		);
		if (!empty($_POST['device_id'])) {
            $insert_data['device_id'] = self::secure($_POST['device_id']);
        }
        if (!empty($_SESSION['lang'])) {
            $insert_data['language'] = self::secure($_SESSION['lang']);
        }
		
		if( $email_validation == "on" ){
			$email_code = sha1(time() + rand(111,999));
			$insert_data['email_code'] = $email_code;
		}

        $user_id     = self::$db->insert(T_USERS, $insert_data);
        $signup      = false;

        if (!empty($user_id)) {
        	$signup      = true;
			
			if ($email_validation == 'on') {
			   $message_body = 'Hello {{NAME}},
				<br><br>
				Please confirm your email address by clicking the link below:
				<br>
				<a href="{{CONFIRM_LINK}}">Confirm email address</a>
				<br><br>
				{{SITE_NAME}} Team.
			   	';
				$message_body = str_replace(
					array("{{NAME}}","{{SITE_NAME}}", "{{CONFIRM_LINK}}"),
					array(self::secure($_POST['username']), self::$config['site_name'], self::$config['site_url'] . '/co/' . $email_code),
					$message_body 
				);
				$send_email_data = array(
					'from_email' => self::$config['site_email'],
					'from_name' => self::$config['site_name'],
					'to_email' => self::secure($_POST['email']),
					'to_name' => self::secure($_POST['username']),
					'subject' => 'Confirm your account',
					'charSet' => 'UTF-8',
					'message_body' => $message_body,
					'is_html' => true
				);
				$send_message = Generic::sendMail($send_email_data);
		   	} else {
		   		
	        	$session_id  = sha1(rand(11111, 99999)) . time() . md5(microtime());
	        	$platform_details = self::getUserBrowser();
		        $insert_data = array(
		           'user_id' => $user_id,
		           'session_id' => $session_id,
		           'time' => time(),
		           'platform_details'  => json_encode($platform_details),
		           'platform' => $platform_details['platform']
		        );
				$insert              = self::$db->insert(T_SESSIONS, $insert_data);
				$_SESSION['user_id'] = $session_id;
	            setcookie("user_id", $session_id, time() + (10 * 365 * 24 * 60 * 60), "/");
	            // ************* pixelphoto_API ***********
	            if (self::isEndPointRequest()) {
					return array('user_id' => $insert_data['user_id'],
				                 'access_token' => $session_id);
				}
		   	}
        }

        return $signup;
	}

	// register a new user
	public static function loginUser(){

		$username        = self::secure($_POST['username']);
        $password        = self::secure($_POST['password']);
        $password_hashed = sha1($password);
        self::$db->where("(username = ? or email = ?)", array(
            $username,
            $username
        ));

        self::$db->where("password", $password_hashed);
        $login  = self::$db->getOne(T_USERS);
        $signin = false;

        if (!empty($login)) {
        	$signin      = true;
            $session_id  = sha1(rand(11111, 99999)) . time() . md5(microtime());
            $platform_details = self::getUserBrowser();
            $insert_data = array(
                'user_id' => $login->user_id,
                'session_id' => $session_id,
                'time' => time(),
	            'platform_details'  => json_encode($platform_details),
	            'platform' => $platform_details['platform']
            );
            $insert              = self::$db->insert(T_SESSIONS, $insert_data);
            $_SESSION['user_id'] = $session_id;
            setcookie("user_id", $session_id, time() + (10 * 365 * 24 * 60 * 60), "/");
            $update_user_data = array();
            $update_user_data['ip_address'] = get_ip_address();
            if (!empty($_POST['device_id'])) {
                $update_user_data['device_id'] = self::secure($_POST['device_id']);
            }

            self::$db->where('user_id',$login->user_id)->update(T_USERS,$update_user_data);
            
            // ************* pixelphoto_API ***********
            if (self::isEndPointRequest()) {
				return array('user_id' => $login->user_id,
			                 'access_token' => $session_id);
			}

        }

        return $signin;
	}

	// logout a user 
	public static function signoutUser(){
		if (!empty($_SESSION['user_id'])) {
			self::$db->where('session_id', self::secure($_SESSION['user_id']));
			self::$db->delete(T_SESSIONS);
		}
	
		if (!empty($_COOKIE['user_id'])) {

			self::$db->where('session_id', self::secure($_COOKIE['user_id']));
			self::$db->delete(T_SESSIONS);
		    unset($_COOKIE['user_id']);
		    setcookie('user_id', null, -1);
		}

		@session_destroy();
	}

	public function delete() {
		self::$db->where('user_id' , $this->user_id)->delete(T_ACTIVITIES);
		$media  = self::$db->where('user_id',$this->user_id)->get(T_MEDIA,null,array('file','extra'));
		$story  = self::$db->where('user_id',$this->user_id)->get(T_STORY,null,array('media_file'));
		$media  = (!empty($media)) ? $media : array();
		$story  = (!empty($story)) ? $story : array();
    	$del = new Media();
	
		foreach ($media as $file_obj) {
		    $del->deleteFromFtpOrS3($file_obj->file);
		    $del->deleteFromFtpOrS3($file_obj->extra);
		    
			if (file_exists($file_obj->file)) {
				@unlink($file_obj->file);
			}

			if (file_exists($file_obj->extra)) {
				@unlink($file_obj->extra);
			}
		}

		foreach ($story as $file_obj) {
		    $del->deleteFromFtpOrS3($file_obj->media_file);
		    
			if (file_exists($file_obj->media_file)) {
				@unlink($file_obj->media_file);
			}
		}
		
		$delete = self::$db->where('user_id', $this->user_id)->delete(T_USERS);
		$delete = self::$db->where('user_id', $this->user_id)->delete(T_POST_COMMENTS);
		$delete = self::$db->where('user_id', $this->user_id)->delete(T_POST_LIKES);

		$delete = self::$db->where('user_id', $this->user_id)->delete(T_POSTS);
		$delete = self::$db->where('follower_id', $this->user_id)->delete(T_CONNECTIV);
		$delete = self::$db->where('following_id', $this->user_id)->delete(T_CONNECTIV);

		$delete = self::$db->where('to_id', $this->user_id)->delete(T_MESSAGES);
		$delete = self::$db->where('from_id', $this->user_id)->delete(T_MESSAGES);
		$delete = self::$db->where('user_id', $this->user_id)->delete(T_STORY);

		$delete = self::$db->where('user_id', $this->user_id)->delete(T_STORY);
		$delete = self::$db->where('user_id', $this->user_id)->delete(T_STORY_VIEWS);

		$delete = self::$db->where('notifier_id', $this->user_id)->delete(T_NOTIF);
		$delete = self::$db->where('recipient_id', $this->user_id)->delete(T_NOTIF);

		$delete = self::$db->where('from_id', $this->user_id)->delete(T_CHATS);
		$delete = self::$db->where('to_id', $this->user_id)->delete(T_CHATS);

		$delete = self::$db->where('user_id', $this->user_id)->delete(T_SAVED_POSTS);
		$delete = self::$db->where('user_id', $this->user_id)->delete(T_POST_REPORTS);

		$delete = self::$db->where('user_id', $this->user_id)->delete(T_POST_REPORTS);

		$delete = self::$db->where('profile_id', $this->user_id)->delete(T_USER_REPORTS);
		$delete = self::$db->where('user_id', $this->user_id)->delete(T_USER_REPORTS);

		$delete = self::$db->where('profile_id', $this->user_id)->delete(T_PROF_BLOCKS);
		$delete = self::$db->where('user_id', $this->user_id)->delete(T_PROF_BLOCKS);
		
		return $delete;
	}

	public function followSuggestions($limit = 10,$offset = false){
		if(empty(IS_LOGGED)){
			return false;
		}

		$data    = array();
		$user_id = self::$me->user_id;
		$sql     = pxp_sqltepmlate('users/get.suggested.users',array(
			't_users' => T_USERS,
			't_conn' => T_CONNECTIV,
			't_blocks' => T_PROF_BLOCKS,
			'user_id' => $user_id,
			'total_limit' => $limit,
			'offset' => $offset,
		));

		try {
			$users = self::$db->rawQuery($sql);
		} 
		catch (Exception $e) {
			$users = array();
		}
		
		if (!empty($users)) {
			foreach ($users as $user) {
				$data[] = $this->userData($user);
			}
		}
		
		return $data;
	}

	public function isFollowing($following_id = null,$rev = false) {
		if (empty($following_id) || !is_numeric($following_id)) {
			return false;
		}

		else if(empty(IS_LOGGED)){
			return false;
		}


		$res = false;

		if ($rev === true && ($following_id != self::$me->user_id)) {
			self::$db->where('follower_id',$following_id);
			self::$db->where('following_id',self::$me->user_id);
			$res = (self::$db->getValue(T_CONNECTIV,'COUNT(*)') > 0);
		}
		elseif ($following_id != self::$me->user_id) {
			self::$db->where('follower_id',self::$me->user_id);
			self::$db->where('following_id',$following_id);
			$res = (self::$db->getValue(T_CONNECTIV,'COUNT(*)') > 0);
		}
		
		return $res;
	}

	public function unFollow($following_id = null){
		if (empty($following_id) || !is_numeric($following_id)) {
			return false;
		}

		else if(empty(IS_LOGGED)){
			return false;
		}

		self::$db->where('follower_id',self::$me->user_id);
		self::$db->where('following_id',$following_id);
		$res = self::$db->delete(T_CONNECTIV);

		return boolval($res);

	}

	public function follow($following_id = null){
		if (empty($following_id) || !is_numeric($following_id)) {
			return false;
		}

		else if(empty(IS_LOGGED) || (self::$me->user_id == $following_id)) {
			return false;
		}

		else if ($this->isFollowing($following_id) === true) {
			self::$db->where('follower_id',self::$me->user_id);
			self::$db->where('following_id',$following_id);
			self::$db->delete(T_CONNECTIV);
			self::$db->where('user_id' , self::$me->user_id)->where('following_id' , $following_id)->where('type' , 'followed_user')->delete(T_ACTIVITIES);
			return -1;
		}

		else{

			$re_data = array(
				'follower_id' => self::$me->user_id,
				'following_id' => $following_id,
				'active' => 1
			);

			self::$db->insert(T_CONNECTIV,$re_data);
			self::$db->insert(T_ACTIVITIES,array('user_id' => self::$me->user_id,
	                                         'following_id' => $following_id,
	                                         'type'    => 'followed_user',
	                                         'time'    => time()));
			return 1;
		}
	}

	public function getFollowers($offset = false,$limit = null){
		if (empty($this->user_id) || !is_numeric($this->user_id)) {
			return false;
		}

		else if (!empty($limit) && !is_numeric($limit)) {
			return false;
		}

		$user_id = $this->user_id;
		$t_users = T_USERS;
		$t_conn  = T_CONNECTIV;

		self::$db->join("{$t_conn} c","c.follower_id = u.user_id","INNER");
		self::$db->where("c.following_id",$user_id);
		self::$db->orderBy("u.user_id","DESC");

		if (!empty($offset) && is_numeric($offset)) {
			self::$db->where("u.user_id",$offset,'<');
		}

		$users = self::$db->get("{$t_users} u",$limit);
		$data  = array();

		foreach ($users as $key => $user_data) {
			$user_data = $this->userData($user_data);
			$user_data->is_following = false;

			if (IS_LOGGED) {
				$this->user_id = self::$me->user_id;
				$user_data->is_following = $this->isFollowing($user_data->user_id);
			}

			$data[]    = $user_data;
		}
		
		return $data;
	}
	
	public function getFollowing($offset = false,$limit = null){
			if (empty($this->user_id) || !is_numeric($this->user_id)) {
				return false;
			}

			else if (!empty($limit) && !is_numeric($limit)) {
				return false;
			}

			$user_id = $this->user_id;
			$t_users = T_USERS;
			$t_conn  = T_CONNECTIV;

			self::$db->join("{$t_conn} c","c.following_id = u.user_id","LEFT");
			self::$db->where("c.follower_id",$user_id);
			self::$db->orderBy("u.user_id","DESC");

			if (!empty($offset) && is_numeric($offset)) {
				self::$db->where("u.user_id",$offset,'<');
			}


			$users = self::$db->get("{$t_users} u",$limit);
			$data  = array();
			foreach ($users as $key => $user_data) {
				$user_data = $this->userData($user_data);

				if (IS_LOGGED) {
					$this->user_id = self::$me->user_id;
					$user_data->is_following = $this->isFollowing($user_data->user_id);
				}

				$data[]    = $user_data;
			}
			
			return $data;
	}
	
	public function countFollowers(){
		if (empty($this->user_id) || !is_numeric($this->user_id)) {
			return false;
		}

		$user_id = $this->user_id;
		$t_conn  = T_CONNECTIV;
		self::$db->where('following_id',$user_id);
		return self::$db->getValue($t_conn,"COUNT(`id`)");
	}

	public function countFollowing(){
		if (empty($this->user_id) || !is_numeric($this->user_id)) {
			return false;
		}

		$user_id = $this->user_id;
		$t_conn  = T_CONNECTIV;
		self::$db->where('follower_id',$user_id);

		return self::$db->getValue($t_conn,"COUNT(`id`)");
	}

	public function getUserId( $username){
		if (empty($username) || !is_string($username)) {
			return false;
		}

		$user_id  = false;
		$username = self::secure($username);

		self::$db->where('username',$username);
		$query = self::$db->getValue(T_USERS,'user_id');
		if (!empty($query)) {
			$user_id = $query;
		}

		return $user_id;
	}

	public function explorePeople($offset = false){
		if (empty(IS_LOGGED)) {
			return false;
		}

		$data    = array();
		$user_id = self::$me->user_id;
		$sql     = pxp_sqltepmlate('users/explore.people',array(
			't_users' => T_USERS,
			't_conn' => T_CONNECTIV,
			't_posts' => T_POSTS,
			't_blocks' => T_PROF_BLOCKS,
			'total_limit' => $this->limit,
			'user_id' => $user_id,
			'offset' => $offset,
		));

		try {
			$users = self::$db->rawQuery($sql);
		} 
		catch (Exception $e) {
			$users = array();
		}
		
		if (!empty($users)) {
			$data = $users;
		}
		
		return $data;
	}

	public function profilePrivacy($user_id = false){
		if (empty($user_id) || !is_numeric($user_id) || empty(IS_LOGGED)) {
			return false;
		}

		self::$db->where('user_id',$user_id);
		$user_data = self::$db->getOne(T_USERS,'p_privacy');
		$privacy   = false;

		if (!empty($user_data)) {

			if ($user_id == self::$me->user_id) {
				$privacy = true;
			}
			
			else if ($user_data->p_privacy == '2') {
				$privacy = true;
			}

			elseif ($user_data->p_privacy == '1' && $this->isFollowing($user_id)) {
				$privacy = true;
			}
		}

		return $privacy;
	}

	public function chatPrivacy($user_id = false){
		if (empty($user_id) || !is_numeric($user_id) || empty(IS_LOGGED)) {
			return false;
		}

		self::$db->where('user_id',$user_id);
		$user_data = self::$db->getOne(T_USERS,'c_privacy');
		$privacy   = false;

		if (!empty($user_data)) {

			if ($user_data->c_privacy == '1' && self::$me->c_privacy == '1') {
				$privacy = true;
			}

			elseif ($user_data->c_privacy == '2' && self::$me->c_privacy == '1' && $this->isFollowing($user_id,true)) {
				$privacy = true;
			}

			elseif (self::$me->c_privacy == '2' && $user_data->c_privacy == '1' && $this->isFollowing($user_id)) {
				$privacy = true;
			}

			elseif (($user_data->c_privacy == '2' && $this->isFollowing($user_id,true)) &&  (self::$me->c_privacy == '2' && $this->isFollowing($user_id))) {
				$privacy = true;
			}
		}

		return $privacy;
	}

	public function isUserRepoted($user_id = false){
		if (empty(IS_LOGGED) || empty($user_id)) {
			return false;
		}

		self::$db->where('user_id',self::$me->user_id);
		self::$db->where('profile_id',$user_id);
		return (self::$db->getValue(T_USER_REPORTS,'COUNT(`id`)') > 0);
	}

	public function reportUser($user_id = false,$type = false){
		if (empty(IS_LOGGED) || empty($user_id) || empty($type)) {
			return false;
		}

		$code = null;

		if ($this->isUserRepoted($user_id) === true) {
			self::$db->where('user_id',self::$me->user_id);
			self::$db->where('profile_id',$user_id);
			self::$db->delete(T_USER_REPORTS);
			$code = -1;
		}
		else {
			self::$db->insert(T_USER_REPORTS,array(
				'user_id' => self::$me->user_id,
				'profile_id' => $user_id,
				'type' => $type,
				'time' => time()
			));
			$code = 1;
		}
		return $code;
	}

	public function isBlocked($user_id = false,$rev = false){
		if (empty(IS_LOGGED) || empty($user_id)) {
			return false;
		}

		$blcoked = false;

		if ($rev === true && ($user_id != self::$me->user_id)) {
			self::$db->where('user_id',$user_id);
			self::$db->where('profile_id',self::$me->user_id);
			$blcoked = (self::$db->getValue(T_PROF_BLOCKS,'COUNT(`id`)') > 0);
		}
		else if($user_id != self::$me->user_id){
			self::$db->where('user_id',self::$me->user_id);
			self::$db->where('profile_id',$user_id);
			$blcoked = (self::$db->getValue(T_PROF_BLOCKS,'COUNT(`id`)') > 0);
		}

		return $blcoked;
	}

	public function unBlockUser($user_id = false){
		if (empty(IS_LOGGED) || empty($user_id)) {
			return false;
		}

		self::$db->where('user_id',self::$me->user_id);
		self::$db->where('profile_id',$user_id);
		return self::$db->delete(T_PROF_BLOCKS);
	}

	public function blockUser($user_id = false){
		if (empty(IS_LOGGED) || empty($user_id)) {
			return false;
		}

		self::$db->where('user_id',self::$me->user_id);
		self::$db->where('profile_id',$user_id);

		$code   = null;
		$bloked = self::$db->getValue(T_PROF_BLOCKS,'COUNT(`id`)');

		if (!empty($bloked)) {
			$this->unBlockUser($user_id);
			$code = -1;
		}
		else {
			self::$db->insert(T_PROF_BLOCKS,array(
				'user_id' => self::$me->user_id,
				'profile_id' => $user_id,
				'time' => time()
			));

			$code = 1;
			$this->unFollow($user_id);

			self::$db->where('following_id',self::$me->user_id);
			self::$db->where('follower_id',$user_id);
			self::$db->delete(T_CONNECTIV);
		}

		return $code;
	}

	public function getBlockedUsers(){
		if (empty(IS_LOGGED)) {
			return false;
		}

		$data  = array();
		$sql   = pxp_sqltepmlate('users/get.blocked.users',array(
			't_users' => T_USERS,
			't_blocks' => T_PROF_BLOCKS,
			'user_id' => self::$me->user_id,
		));	

		try {
			$users = self::$db->rawQuery($sql);
		} 
		catch (Exception $e) {
			$users = array();
		}

		if (!empty($users)) {
			foreach ($users as $user) {
				$user->name = $user->username;
				if (!empty($user->fname) && !empty($user->lname)) {
					$user->name = sprintf('%s %s',$user->fname,$user->lname);
				}
				$data[] = $user;
			}
		}
		return $data;
	}

	public function seachUsers($keyword = '',$limit = 100,$offset = 0,$order = 'DESC'){
		if (empty($keyword)) {
			return false;
		}
		$offset_string = '';
		if (!empty($offset) && is_numeric($offset) && $offset > 0) {
			if ($order == 'DESC') {
				$offset_string = " AND  user_id < ".(int)$offset;
			}
			else{
				$offset_string = " AND  user_id > ".(int)$offset;
			}
		}
		$users = self::$db->rawQuery("SELECT * FROM ".T_USERS." WHERE (username LIKE '%$keyword%' OR fname LIKE '%$keyword%' OR lname LIKE '%$keyword%') ".$offset_string." ORDER BY user_id ".$order." LIMIT ".$limit);

		// //if (!empty($offset) && is_numeric($offset) && $offset > 0) {
		// 	self::$db->where('user_id',$offset,'>');
		// //}
		// self::$db->where('username',"%$keyword%",'LIKE');
		// //self::$db->orWhere('fname',"%$keyword%",'LIKE');
		// //self::$db->orWhere('lname',"%$keyword%",'LIKE');
		
		// self::$db->orderBy("user_id","DESC");
		// $usres = self::$db->get(T_USERS,$limit,array('username','fname','lname','avatar','verified'));
		return $users;
	}

	public function sendVerificationRequest($data = array())
	{
		
		if (empty(IS_LOGGED) || empty($data)) {
			return false;
		}
		if (self::isVerificationRequested() > 0) {
			return false;
		}
		return self::$db->insert(T_VERIFY,$data);
	}

	public function isVerificationRequested()
	{
		global $me;
		if (empty(IS_LOGGED)) {
			return false;
		}
		self::$db->where('user_id',self::$me->user_id);
		return self::$db->getValue(T_VERIFY,'COUNT(*)');
	}

	public function is_verified($user_id)
	{
		if (empty(IS_LOGGED) || empty($user_id)) {
			return false;
		}
		$user_id = self::secure($user_id);
		self::$db->where('user_id',$user_id);
		$is_verified = self::$db->get(T_USERS,1,'verified');
		$is_verified = $is_verified[0]->verified;
		return $is_verified;
	}

	public function getUserSessions()
	{
		global $me;
		if (empty(IS_LOGGED)) {
			return false;
		}
		self::$db->where('user_id',self::$me->user_id);
		self::$db->orderBy('id','DESC');
		return self::$db->get(T_SESSIONS);
	}
	public function delete_session($id){
		if (!empty($id)) {
			self::$db->where('id', $id);
			self::$db->delete(T_SESSIONS);
		}
	}

	public function getUserBrowser() {
	     $u_agent = $_SERVER['HTTP_USER_AGENT'];
	     $bname = 'Unknown';
	     $platform = 'Unknown';
	     $version= "";
	     // First get the platform?
	     if (preg_match('/linux/i', $u_agent)) {
	       $platform = 'linux';
	     } elseif (preg_match('/macintosh|mac os x/i', $u_agent)) {
	       $platform = 'Mac';
	     } elseif (preg_match('/windows|win32/i', $u_agent)) {
	       $platform = 'windows';
	     } elseif (preg_match('/iphone|IPhone/i', $u_agent)) {
	       $platform = 'IPhone';
	     } elseif (preg_match('/android|Android/i', $u_agent)) {
	       $platform = 'Android';
	     } else if (preg_match("/(android|avantgo|blackberry|bolt|boost|cricket|docomo|fone|hiptop|mini|mobi|palm|phone|pie|tablet|up\.browser|up\.link|webos|wos)/i", $u_agent)) {
	       $platform = 'Mobile';
	     }
	     // Next get the name of the useragent yes seperately and for good reason
	     if(preg_match('/MSIE/i',$u_agent) && !preg_match('/Opera/i',$u_agent)) {
	       $bname = 'Internet Explorer';
	       $ub = "MSIE";
	     } elseif(preg_match('/Firefox/i',$u_agent)) {
	       $bname = 'Mozilla Firefox';
	       $ub = "Firefox";
	     } elseif(preg_match('/Chrome/i',$u_agent)) {
	       $bname = 'Google Chrome';
	       $ub = "Chrome";
	     } elseif(preg_match('/Safari/i',$u_agent)) {
	       $bname = 'Apple Safari';
	       $ub = "Safari";
	     } elseif(preg_match('/Opera/i',$u_agent)) {
	       $bname = 'Opera';
	       $ub = "Opera";
	     } elseif(preg_match('/Netscape/i',$u_agent)) {
	       $bname = 'Netscape';
	       $ub = "Netscape";
	     }
	     // finally get the correct version number
	     $known = array('Version', $ub, 'other');
	     $pattern = '#(?<browser>' . join('|', $known) . ')[/ ]+(?<version>[0-9.|a-zA-Z.]*)#';
	     if (!preg_match_all($pattern, $u_agent, $matches)) {
	       // we have no matching number just continue
	     }
	     // see how many we have
	     $i = count($matches['browser']);
	     if ($i != 1) {
	       //we will have two since we are not using 'other' argument yet
	       //see if version is before or after the name
	       if (strripos($u_agent,"Version") < strripos($u_agent,$ub)){
	         $version= $matches['version'][0];
	       } else {
	         $version= $matches['version'][1];
	       }
	     } else {
	       $version= $matches['version'][0];
	     }
	     // check if we have a number
	     if ($version==null || $version=="") {$version="?";}
	     return array(
	         'userAgent' => $u_agent,
	         'name'      => $bname,
	         'version'   => $version,
	         'platform'  => $platform,
	         'pattern'    => $pattern,
	         'ip_address' => get_ip_address()
	     );
	}

	public function isInBlackList($username = '',$email = '')
	{
		$ip = get_ip_address();
		self::$db->where('value',$ip);
		$count = self::$db->getValue(T_BLACKLIST,'COUNT(*)');
		if ($count > 0) {
			return array('count' => $count , 'type' => 'ip');
		}
		if (!empty($username) && empty($email)) {
			$username = self::secure($username);
			self::$db->where('value',$username);
			$count = self::$db->getValue(T_BLACKLIST,'COUNT(*)');
			return array('count' => $count , 'type' => 'username');
		}
		if (empty($username) && !empty($email)) {
			$email = self::secure($email);
			self::$db->where('value',$email);
			$count = self::$db->getValue(T_BLACKLIST,'COUNT(*)');
			return array('count' => $count , 'type' => 'email');
		}
		if (!empty($username) && !empty($email)) {
			$username = self::secure($username);
			$email = self::secure($email);
			self::$db->where('value',array($email,$username),'IN');
			$count = self::$db->getValue(T_BLACKLIST,'COUNT(*)');
			return array('count' => $count , 'type' => 'email_username');
		}
	}


}

	

?>