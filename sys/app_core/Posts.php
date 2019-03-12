<?php 

/**
* Posts class, everything related to users.
*/

class Posts extends User{
	
	public $hashtag    = '';
	public $tag_id     = '';
	public $comm_limit = null;
	protected $post_id = 0;

	public function all(){
		$posts = self::$db->get(T_POSTS,$this->limit);
		$data  = array();
		foreach ($posts as $key => $post_data) {
			$post_data = $this->postData($post_data);
			$data[]    = $post_data;
		}

		return $data;
	}

	public function explorePosts($offset = false){
		if (empty(IS_LOGGED)) {
			return false;
		}

		$data = array();
		$sql  = pxp_sqltepmlate('posts/explore.posts',array(
			't_posts' => T_POSTS,
			't_likes' => T_POST_LIKES,
			't_media' => T_MEDIA,
			't_comm' => T_POST_COMMENTS,
			't_blocks' => T_PROF_BLOCKS,
			't_users' => T_USERS,
			'total_limit' => $this->limit,
			'user_id' => self::$me->user_id,
			'offset' => $offset,
		));

		try {
			$posts = self::$db->rawQuery($sql);
		} 
		catch (Exception $e) {
			$posts = array();
		}
		
		foreach ($posts as $key => $post_data) {
			$post_data->thumb = '';
			$t = $post_data->type;
			if (in_array($t, array('youtube','image','gif','video','vimeo','dailymotion','playtube','mp4','fetched'))) {
				if (!empty($post_data->extra)) {
					$post_data->thumb = $post_data->extra;
				}
				else{
					$post_data->thumb = $post_data->file;
				}
			}
			$post_data->is_should_hide  = $this->is_should_hide($post_data->post_id);

			$data[] = $post_data;
		}

		return $data;
	}

	public function getHtagId($htag = ""){
		if (empty($htag) || !is_string($htag)) {
			return false;
		}

		$htag_id = 0;
		$query   = self::$db->where('tag',$htag)->getValue(T_HTAGS,'id');

		if (!empty($query)) {
			$htag_id = $query;
		}

		return $htag_id;
	}

	public function exploreTags($hashtag_id = '',$offset = false) {
		$data = array();
		$sql  = pxp_sqltepmlate('posts/explore.posts',array(
			't_posts' => T_POSTS,
			't_likes' => T_POST_LIKES,
			't_media' => T_MEDIA,
			't_users' => T_USERS,
			't_comm' => T_POST_COMMENTS,
			'total_limit' => $this->limit,
			'hashtag_id' => $hashtag_id,
			'offset' => $offset,
			'user_id' => ((empty(IS_LOGGED)) ? false : self::$me->user_id),
			't_blocks' => T_PROF_BLOCKS,
		));

		try {
			$posts = self::$db->rawQuery($sql);
		} 
		catch (Exception $e) {
			$posts =  array();
		}
	
		foreach ($posts as $key => $post_data) {
			$post_data->thumb = '';
			$t = $post_data->type;

			if (in_array($t, array('youtube','gif','image','vimeo','dailymotion'))) {
				$post_data->thumb = $post_data->file;
			}

			else if($t == 'video'){
				$post_data->thumb = $post_data->extra;
			}

			$data[] = $post_data;
		}

		return $data;
	}

	public function countPostsByTag($htag_id = ''){
		$htag_id = self::secure($htag_id);
		$posts   = self::$db->where('description',"%#[$htag_id]%",'LIKE')->getValue(T_POSTS,'COUNT(`post_id`)');
		return $posts;
	}

	public function getUserPosts($offset = false){

		if (empty($this->user_id) || !is_numeric($this->user_id)) {
			$this->throwError("Error: User id must be a positive integer");
		}

		$data    = array();
		$user_id = $this->user_id;
		$sql     = pxp_sqltepmlate('posts/get.user.posts',array(
			't_posts' => T_POSTS,
			't_likes' => T_POST_LIKES,
			't_comm' => T_POST_COMMENTS,
			't_media' => T_MEDIA,
			'user_id' => $user_id,
			'total_limit' => $this->limit,
			'offset' => $offset,
		));
		
		try {
			$posts = self::$db->rawQuery($sql);
		} 
		catch (Exception $e) {
			$posts = array();
		}

		foreach ($posts as $key => $post_data) {
			$post_data->thumb = '';
			$t = $post_data->type;

			if (in_array($t, array('youtube','image','gif','video','vimeo','dailymotion','playtube','mp4','fetched'))) {
				if (!empty($post_data->extra)) {
					$post_data->thumb = $post_data->extra;
				}
				else{
					$post_data->thumb = $post_data->file;
				}
			}
			$post_data->is_should_hide  = $this->is_should_hide($post_data->post_id);



			$data[] = $post_data;
		}
		
		return $data;
	}

	public function getSavedPosts($offset = false){
		if (empty(IS_LOGGED)) {
			return false;
		}

		$data    = array();
		$user_id = self::$me->user_id;
		$sql     = pxp_sqltepmlate('posts/get.saved.posts',array(
			't_posts' => T_POSTS,
			't_likes' => T_POST_LIKES,
			't_comm' => T_POST_COMMENTS,
			't_media' => T_MEDIA,
			't_saved' => T_SAVED_POSTS,
			't_users' => T_USERS,
			'user_id' => $user_id,
			'total_limit' => $this->limit,
			'offset' => $offset,
		));

		try {
			$posts = self::$db->rawQuery($sql);
		} 
		catch (Exception $e) {
			$posts = array();
		}
		
		foreach ($posts as $key => $post_data) {
			$post_data->thumb = '';
			$t = $post_data->type;

			if (in_array($t, array('youtube','image','gif','video','vimeo','dailymotion','playtube','mp4','fetched'))) {
				if (!empty($post_data->extra)) {
					$post_data->thumb = $post_data->extra;
				}
				else{
					$post_data->thumb = $post_data->file;
				}
			}
			$post_data->is_should_hide  = $this->is_should_hide($post_data->post_id);

			$data[] = $post_data;
		}

		return $data;
	}

	public function getTimelinePosts($offset = false,$limit = 5){
		if (empty(IS_LOGGED)) {
			return false;
		}

		$data    = array();
		$user_id = self::$me->user_id;
		$sql     = pxp_sqltepmlate('posts/get.timeline.posts',array(
			't_posts' => T_POSTS,
			't_conn' => T_CONNECTIV,
			't_likes' => T_POST_LIKES,
			't_comm' => T_POST_COMMENTS,
			't_blocks' => T_PROF_BLOCKS,
			't_users' => T_USERS,
			'user_id' => $user_id,
			'total_limit' => $limit,
			'offset' => $offset,
		));

		try {
			$posts = self::$db->rawQuery($sql);
		} 
		catch (Exception $e) {
			$posts = array();
		}

		foreach ($posts as $key => $post_data) {
			$post_data = $this->postData($post_data);
			$data[]    = $post_data;
		}
		
		return $data;
	}

	public function setPostId($post_id = 0){
		$this->post_id = self::secure($post_id);

		if (empty($this->post_id) || !is_numeric($this->post_id)) {
			$this->throwError("Invalid argument: Post id must be a positive integer");
		}

		return $this;
	}

	public function updatePost($re_data = array()){
		if (empty($this->post_id) || empty($re_data) || !is_array($re_data)) {
			return false;
		}

		if (!empty($re_data['description'])) {
			$re_data['description'] = $this->upsertHtags($re_data['description']);
		}

		return self::$db->where('post_id',$this->post_id)->update(T_POSTS,$re_data);
	}

	public function isPostReported(){
		if (empty(IS_LOGGED) || empty($this->post_id)) {
			return false;
		}

		self::$db->where('user_id',self::$me->user_id);
		self::$db->where('post_id',$this->post_id);

		return (self::$db->getValue(T_POST_REPORTS,'COUNT(*)') > 0);
	}

	public function reportPost(){
		if (empty(IS_LOGGED) || empty($this->post_id)) {
			return false;
		}

		$code = null;
		$user = self::$me->user_id;

		if ($this->isPostReported() == true) {
			self::$db->where('user_id',$user);
			self::$db->where('post_id',$this->post_id);
			self::$db->delete(T_POST_REPORTS);
			$code = -1;
		}
		else{
			self::$db->insert(T_POST_REPORTS,array(
				'user_id' => $user,
				'post_id' => $this->post_id,
				'time' => time()
			));
			$code = 1;
		}

		return $code;
	}

	public function postData($post = null){
		if (empty($post)) {
			$t_users = T_USERS;
			$t_posts = T_POSTS;

			self::$db->join("`$t_users` u","u.`user_id` = p.`user_id`","INNER");
			self::$db->where('p.`post_id`',$this->post_id);

			$post = self::$db->getOne("`$t_posts` p","p.*,u.`avatar`,u.`username`");

			if (!empty($post)) {
				self::$db->where('post_id',$this->post_id);
				$post->likes = self::$db->getValue(T_POST_LIKES,"COUNT(`id`)");

				self::$db->where('post_id',$this->post_id);
				$post->votes = self::$db->getValue(T_POST_COMMENTS,"COUNT(`id`)");
			}

		}
		
		if (!empty($post)) {

			$this->setPostId($post->post_id);
			self::$db->where('post_id',$post->post_id);
			$media_set = self::$db->get(T_MEDIA);
			if (!empty($media_set)) {
				foreach ($media_set as $key => $file) {
					if ($post->type == 'gif') {
						$file->file  = urldecode($file->file);
						$file->extra = urldecode($file->extra);
					}			
					$media_set[$key] = $file;
				}
				$post->media_set = $media_set;
			}

			$post->comments     = $this->getPostComments();
			$post->is_owner     = false;
			$post->is_liked     = $this->isLiked();
			$post->is_saved     = $this->isSaved();
			$post->reported     = $this->isPostReported();
			$post->description  = $this->likifyMentions($post->description);
			$post->description  = $this->tagifyHTags($post->description);
			$post->description  = $this->linkifyHTags($post->description);
			$post->description  = $this->obsceneWords($post->description);
			$post->is_verified  = $this->is_verified($post->user_id);
			$post->is_should_hide  = $this->is_should_hide($post->post_id);

			if (IS_LOGGED) {
				$post->is_owner = (self::$me->user_id == $post->user_id || IS_ADMIN);
			}
		}
		return $post;
	}

	public function getPostComments($offset = false){
		if (empty($this->post_id)) {
			return false;
		}

		if ($offset && is_numeric($offset)) {
			self::$db->where('id',$offset,'<');
		}

		self::$db->where('post_id',$this->post_id)->orderBy('id','DESC');

		$commset  = self::$db->get(T_POST_COMMENTS,$this->comm_limit,array('id'));
		$comments = array();

		if (!empty($commset)) {
			foreach ($commset as $key => $comment) {
				$comments[] = $this->postCommentData($comment->id);
			}
		}

		return $comments;
	}

	public function likifyMentions($text = ""){
		$text = preg_replace_callback('/(?:^|\s|,)\B@([a-zA-Z0-9_]{4,32})/is', function($m){
			$uname = $m[1];
			if ($this->userNameExists($uname)) {
				return self::createHtmlEl('a',array(
					'href' => sprintf("%s/@%s",self::$site_url,$uname),
					'target' => '_blank',
					'class' => 'mention',
				),"@$uname");
			}
			else{
				return "@$uname";
			}
		}, $text);

		return $text;
	}

	public function tagifyHTags($text = ""){
		if (!empty($text) && is_string($text)) {
			preg_match_all('/(#\[([0-9]+)\])/i', $text, $matches);
			$matches = (!empty($matches[2])) ? $matches[2] : array();

			if (!empty($matches)) {		
				$htags = self::$db->where('id',$matches,"IN")->get(T_HTAGS,null,array('id','tag'));
				if (!empty($htags)) {
					foreach ($htags as $htag) {
						$text = str_replace("#[{$htag->id}]", "#{$htag->tag}", $text);
					}
				}
			}
		}

	    return $text;
	}

	public function obsceneWords($text = ""){
		if (empty(self::$config['obscene'])) {
			return $text;
		}
	    $obscene = preg_split('/[,]/s', self::$config['obscene']);
	    if (!empty($obscene) && is_array($obscene)) {
	        foreach ($obscene as $word) {
	        	$repl = self::createHtmlEl('s',null,str_repeat('?', len($word)));
	            $text = preg_replace("/$word/is",$repl, $text);
	        }
	    }

	    return $text;
	}

	public function insertPost($data = array()){
		if (empty(IS_LOGGED)) {
			return false;
		}

		if (!empty($data['description'])) {
			$data['description'] = $this->upsertHtags($data['description']);
			$data['description'] = Generic::secure($data['description']);
		}
		
		$data['registered'] = sprintf('%s/%s',date('Y'),date('n'));
		return self::$db->insert(T_POSTS,$data);
	}

	public function insertMedia($data = array()){
		if (empty(IS_LOGGED) || (empty($data['post_id']) && empty($this->post_id))) {
			return false;
		}

		else if(empty($data['post_id']) && !empty($this->post_id)){
			$data['post_id'] = $this->post_id;
		}

		$data['user_id'] = self::$me->user_id;
		return self::$db->insert(T_MEDIA,$data);
	}

	public function isPostOwner($admin = true){
		if (empty(IS_LOGGED)) {
			return false;
		}

		// if ($admin && IS_ADMIN) {
		// 	return true;
		// }

		$user_id = self::$me->user_id;
		$post_id = $this->post_id;

		if (empty($user_id) || empty($post_id)) {
			return false;
		}

		self::$db->where("user_id",$user_id);
		self::$db->where("post_id",$post_id);

		return (self::$db->getValue(T_POSTS,'COUNT(*)') > 0);
	}

	public function deletePost(){
		$post_id = $this->post_id;
		self::$db->where('post_id' , $post_id)->delete(T_ACTIVITIES);
		self::$db->where('post_id',$post_id);
		$media_set = self::$db->get(T_MEDIA);
		$del = new Media();
		
		foreach ($media_set as $key => $file_data) {
		    $del->deleteFromFTPorS3($file_data->file);
		   // $del->deleteFromFTPorS3($file_data->extra);
		    
			if (file_exists($file_data->file)) {
				try {
					unlink($file_data->file);	
				}
				catch (Exception $e) {
				}
			}

			if (file_exists($file_data->extra)) {
				try {
					unlink($file_data->extra);	
				}
				catch (Exception $e) {
				}
			}
		}
		self::$db->where("post_id",$post_id);
		return self::$db->delete(T_POSTS);
	}

	public function addPostComment($re_data = array()){
		$re_data['post_id'] = $this->post_id;
		$re_data['user_id'] = $this->user_id;

		if (!empty($re_data['text'])) {
			$this->upsertHtags($re_data['text']);
		}
		self::$db->insert(T_ACTIVITIES,array('user_id' => $re_data['user_id'],
	                                         'post_id' => $re_data['post_id'],
	                                         'type'    => 'commented_on_post',
	                                         'time'    => time()));

		return self::$db->insert(T_POST_COMMENTS,$re_data);
	}

	public function postCommentData($id = 0){

		$t_users = T_USERS;
		$t_comms = T_POST_COMMENTS;

		self::$db->join("{$t_users} u","c.user_id = u.user_id ","INNER");
		self::$db->where("c.id",$id);
	   	$comment = self::$db->getOne("{$t_comms} c","c.id,c.user_id,c.post_id,c.text,c.time,u.username,u.avatar");
		if (!empty($comment)) {
			$comment->is_owner = $this->isCommentOwner($id);
			$comment->text     = $this->likifyMentions($comment->text);
			$comment->text     = $this->linkifyHTags($comment->text);
		}
		

		return $comment;
	}

	public function isCommentOwner($comment_id = 0,$user_id = 0){

		if ((empty($user_id) || !is_numeric($user_id)) && IS_LOGGED) {
			$user_id = self::$me->user_id;
		}

		$comment = self::$db->where("id",$comment_id)->getOne(T_POST_COMMENTS);

	   	$post = self::$db->where("post_id",$comment->post_id)->getOne(T_POSTS);

		if ($post->user_id == self::$me->user_id || IS_ADMIN || $comment->user_id == self::$me->user_id) {
			return true;
		}
		return false;
	}

	public function deletePostComment($comment_id = 0){
		$comment = self::$db->where("id",$comment_id)->getOne(T_POST_COMMENTS);
		self::$db->where('user_id' , $comment->user_id)->where('post_id' , $comment->post_id)->where('type' ,'commented_on_post')->delete(T_ACTIVITIES);
		self::$db->where("id",$comment_id);
		return self::$db->delete(T_POST_COMMENTS);
	}

	public function countPosts(){
		if (empty($this->user_id)) {
			return false;
		}

		self::$db->where('user_id',$this->user_id);
		return self::$db->getValue(T_POSTS,'COUNT(*)');
	}

	public function countSavedPosts(){
		if (empty(IS_LOGGED)) {
			return false;
		}

		$user_id = self::$me->user_id;
		self::$db->where('user_id',$user_id);
		return self::$db->getValue(T_SAVED_POSTS,'COUNT(*)');
	}

	public function getPostOwnerData(){
		if (empty($this->post_id)) {
			return false;
		}

		$post_id = $this->post_id;
		$t_users = T_USERS;
		$t_posts = T_POSTS;
		$data    = null;

		self::$db->join("{$t_users} u","u.user_id = p.user_id ","RIGHT");
		self::$db->where('post_id',$post_id);
	    $query   = self::$db->getOne("{$t_posts} p","u.*");

	   	if (!empty($query)) {
	   		$data = $query;
	   	}
	   	
	    return $data;
	}

	public function isLiked(){

		if (empty($this->post_id) || empty(IS_LOGGED)) {
			return false;
		}

		$user_id = self::$me->user_id;
		$post_id = $this->post_id;
		

		self::$db->where('post_id',$post_id);
		self::$db->where('user_id',$user_id);
		$likes   = self::$db->getValue(T_POST_LIKES,"COUNT(*)");

		return ($likes > 0);
	}

	public function isSaved(){

		if (empty($this->post_id) || empty(IS_LOGGED)) {
			return false;
		}

		$user_id = self::$me->user_id;
		$post_id = $this->post_id;
		

		self::$db->where('post_id',$post_id);
		self::$db->where('user_id',$user_id);
		$likes   = self::$db->getValue(T_SAVED_POSTS,"COUNT(*)");

		return ($likes > 0);
	}

	public function likePost(){
		if (empty($this->post_id) || empty(IS_LOGGED)) {
			return false;
		}

		$user_id = self::$me->user_id;
		$post_id = $this->post_id;
		$code    = 0;

		if ($this->isLiked()) {
			self::$db->where('post_id',$post_id);
			self::$db->where('user_id',$user_id);
			self::$db->delete(T_POST_LIKES);
			self::$db->where('user_id' , $user_id)->where('post_id' , $post_id)->where('type' ,'liked__post')->delete(T_ACTIVITIES);
			$code = -1;
		}
		else{
			$insert = self::$db->insert(T_POST_LIKES,array(
				'post_id' => $post_id,
				'user_id' => $user_id,
				'time'    => time()
			));
			self::$db->insert(T_ACTIVITIES,array('user_id' => $user_id,
	                                         'post_id' => $post_id,
	                                         'type'    => 'liked__post',
	                                         'time'    => time()));

			if (is_numeric($insert)) {
				$code = 1;
			}
		}

		return $code;
	}

	public function savePost(){
		if (empty($this->post_id) || empty(IS_LOGGED)) {
			return false;
		}

		$user_id = self::$me->user_id;
		$post_id = $this->post_id;
		$code    = 0;

		if ($this->isSaved()) {
			self::$db->where('post_id',$post_id);
			self::$db->where('user_id',$user_id);
			self::$db->delete(T_SAVED_POSTS);
			$code = -1;
		}
		else{
			$insert = self::$db->insert(T_SAVED_POSTS,array(
				'post_id' => $post_id,
				'user_id' => $user_id
			));

			if (is_numeric($insert)) {
				$code = 1;
			}
		}

		return $code;
	}

	public function getLikes($type = 'up'){
		if (empty($this->post_id)) {
			return false;
		}

		else if(!in_array($type, array('up','down'))){
			return false;
		}

		$post_id = $this->post_id;
		self::$db->where('post_id',$post_id);
		self::$db->where('type',$type);
		$likes   = self::$db->getValue(T_POST_LIKES,'COUNT(*)');

		return $likes;
	}

	public function getFeaturedPosts(){
		$data = array();
		$sql  = pxp_sqltepmlate('posts/get.featured.posts',array(
			't_posts' => T_POSTS,
			't_likes' => T_POST_LIKES,
			't_media' => T_MEDIA,
			't_blocks' => T_PROF_BLOCKS,
			't_users' => T_USERS,
			'total_limit' => $this->limit,
			'user_id' => ((!empty(IS_LOGGED)) ? self::$me->user_id : false),
			'time_date' => strtotime('-2 days')
		));


		try {
			$posts = self::$db->rawQuery($sql);
		} 
		catch (Exception $e) {
			$posts = array();
		}
		
		foreach ($posts as $key => $post_data) {
			$post_data->thumb = '';
			$t = $post_data->type;

			if (in_array($t, array('youtube','image','gif','video','vimeo','dailymotion','playtube','mp4','fetched'))) {
				if (!empty($post_data->extra)) {
					$post_data->thumb = $post_data->extra;
				}
				else{
					$post_data->thumb = $post_data->file;
				}
			}

			if (!empty($post_data->fname) && !empty($post_data->lname)) {
				$post_data->username = sprintf('%s %s',$post_data->fname,$post_data->lname);
			}

			$post_data->dsr = preg_replace('/(\#\[[0-9]+\])/is', '', $post_data->dsr);

			$data[] = $post_data;
		}

		return $data;
	}

	public function hasNext($page = false){
		if (empty($this->post_id)) {
			return false;
		}

		$next_id = 0;
		$table   = ($page == 'favourites') ? T_SAVED_POSTS : T_POSTS;
		$sql     = pxp_sqltepmlate('posts/get.next.post.id',array(
			'page' => $page,
			'post_id' => $this->post_id,
			'table' => $table,
			'tag_id' => $this->tag_id
		));

		$query = self::$db->rawQuery($sql);

		if (!empty($query) && is_array($query)) {
			$query   = array_shift($query);
			$next_id = $query->post_id;
		}

		return $next_id;
	}

	public function hasPrev($page = false){
		if (empty($this->post_id)) {
			return false;
		}

		$next_id = 0;
		$table   = ($page == 'favourites') ? T_SAVED_POSTS : T_POSTS;
		$sql     = pxp_sqltepmlate('posts/get.prev.post.id',array(
			'page' => $page,
			'post_id' => $this->post_id,
			'table' => $table,
			'tag_id' => $this->tag_id
		));

		$query = self::$db->rawQuery($sql);

		if (!empty($query) && is_array($query)) {
			$query   = array_shift($query);
			$next_id = $query->post_id;
		}
		
		return $next_id;
	}

	public function searchPosts($htag = "",$limit = 20,$offset = ''){
		$data  = array();
		if (!empty($offset)) {
			$offset = Generic::secure($offset);
			$offset = ' AND h.id > '.$offset.' ';
		}
		$sql   = pxp_sqltepmlate('posts/get.posts.bytag',array(
			't_htags' => T_HTAGS,
			't_posts' => T_POSTS,
			'hashtag' => $htag,
			'limit' => $limit,
			'offset' => $offset
		));

		try {
			$query = self::$db->rawQuery($sql);
		} 
		catch (Exception $e) {
			$query = array();
		}

		if (!empty($query)) {
			$data = $query;
		}
		
		return $data;
	}

	public function getLikedUsers($offset  = '',$limit = '') {
		if (empty($this->post_id)) {
			return false;
		}
		if (!empty($limit)) {
			$limit = Generic::secure($limit);
			$limit = ' LIMIT '.$limit;
		}
		if (!empty($offset)) {
			$offset = Generic::secure($offset);
			$offset = ' AND `id` < '.$offset.' ';
		}

		$uid = (!empty(IS_LOGGED)) ? self::$me->user_id : false;
		$sql = pxp_sqltepmlate('posts/get.post.likes',array(
			't_users' => T_USERS,
			't_likes' => T_POST_LIKES,
			't_connv' => T_CONNECTIV,
			'user_id' => $uid,
			'post_id' => $this->post_id,
			'limit_'  => $limit,
			'offset_' => $offset
		));

		try {
			$likes = self::$db->rawQuery($sql);
		} 
		catch (Exception $e) {
			$likes = array();
		}

		return (!empty($likes)) ? $likes : array();
	}

	public function add_view(){
		if (empty($this->post_id)) {
			return false;
		}
		$post_id = $this->post_id;
		$count    = 0;
		$hash = sha1($post_id);
		if (isset($_COOKIE[$hash])) {
			self::$db->where('post_id',$post_id);
			$count = self::$db->getValue(T_POSTS,'views');
		}
		else{
			setcookie($hash,$hash,time()+(60*60*2));
			self::$db->rawQuery("UPDATE ".T_POSTS." SET `views` = `views`+1 where `POST_id` = ?", Array ($post_id));
			self::$db->where('post_id',$post_id);
			$count = self::$db->getValue(T_POSTS,'views');
		}

		return $count;
	}
	public function is_should_hide($post_id){
		if (empty($post_id)) {
			return false;
		}
		$post_id = Generic::secure($post_id);

		self::$db->where('post_id',$post_id);

		$count  = self::$db->getValue(T_POST_REPORTS,'COUNT(*)');
		if ($count > 3) {
			return true;
		}
		return false;
	}

	public function getUsersActivities($offset = 0 , $limit = 5)
	{
		if (empty(IS_LOGGED)) {
			return false;
		}
		$limit = Generic::secure($limit);
		$subquery = " `id` > 0 ";
		if ($offset > 0) {
			$offset = Generic::secure($offset);
			$subquery = " `id` < ".$offset;
		}
		$user_id = self::$me->user_id;
		$query = "SELECT * FROM " . T_ACTIVITIES . " WHERE {$subquery}  AND `user_id` IN (SELECT `following_id` FROM " . T_CONNECTIV . " WHERE `follower_id` = {$user_id} AND `active` = '1') AND `user_id` NOT IN ($user_id) ORDER BY `id` DESC LIMIT {$limit} ";
		$activities = self::$db->rawQuery($query);
		foreach ($activities as $key => $value) {
			$users = new User();
			$users->setUserById($value->user_id);
			$value->user_data = $users->getUserDataById($value->user_id);
			$post_owner_id = self::$db->where('post_id',$value->post_id)->getOne(T_POSTS);

			$post_owner = $users->getUserDataById($post_owner_id->user_id);
			if (!empty($value->post_id)) {
				$name = $post_owner->name;
				if (self::$me->user_id == $post_owner_id->user_id) {
					$name = lang('your');
				}
				if ($value->user_data->user_id == $post_owner_id->user_id) {
					$name = lang('his');
				}
				$value->activity_link = self::$config['site_url'].'/post/'.$value->post_id;
				if ($value->type == 'commented_on_post') {
					$value->text = str_replace("{post}", '<a href="'.$value->activity_link.'"  data-ajax="posts/view_post/'.$value->post_id.'">'.lang('post').'</a>', lang($value->type));
					$value->text = str_replace("{user}", '<a href="'.$post_owner->url.'"  data-ajax="profile/profile/'.$post_owner->username.'">'.$name.'</a>', $value->text);
					$value->text = '<a href="'.$value->user_data->url.'" data-ajax="profile/profile/'.$value->user_data->username.'"> '.$value->user_data->name.'</a>'.' '.$value->text;
				}
				elseif ($value->type == 'liked__post') {
					$value->text = str_replace("{post}", '<a href="'.$value->activity_link.'" data-ajax="posts/view_post/'.$value->post_id.'">'.lang('post').'</a>', lang($value->type));
					$value->text = str_replace("{user}", '<a href="'.$post_owner->url.'"   data-ajax="profile/profile/'.$post_owner->username.'">'.$name.'</a>', $value->text);
					$value->text = '<a href="'.$value->user_data->url.'" data-ajax="profile/profile/'.$value->user_data->username.'">'.$value->user_data->name.'</a>'.' '.$value->text;
				}
			}
			
			if ($value->following_id > 0) {
				$users->setUserById($value->following_id);
				$following_data = $users->getUserDataById($value->following_id);
				$value->activity_link = $following_data->url;
				$value->following_data = $following_data;
				$follow_name = $value->following_data->name;
				if (self::$me->user_id == $value->following_data->user_id) {
					$follow_name = lang('you') ;
				}
				$value->text = str_replace("{user}", '<a href="'.$value->activity_link.'"   data-ajax="profile/profile/'.$value->following_data->username.'">'.$follow_name.'</a>', lang($value->type));
				$value->text = '<a href="'.$value->user_data->url.'" data-ajax="profile/profile/'.$value->user_data->username.'">'.$value->user_data->name.'</a>'.' '.$value->text;
			}
			

			
		}
		return $activities;
	}


}