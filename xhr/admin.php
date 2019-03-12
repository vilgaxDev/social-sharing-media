<?php 
use Aws\S3\S3Client;

if (empty(IS_ADMIN)) {
	echo "Unknown dolphin";
	exit();
}

else if($action == 'general-settings' && !empty($_POST)){
	$admin  = new Admin();
	$update = $_POST;
	
	$data   = array('status' => 304);
	$error  = false;

	if (!empty($_POST['import_videos']) && $_POST['import_videos'] == 'on' && empty($config['yt_api'])) {
		$error = "Youtube api key is reqired to import videos";
	}

	if (!empty($_POST['import_images']) && $_POST['import_images'] == 'on' && empty($config['giphy_api'])) {
		$error = "Giphy api key is reqired to import images/gifs";
	}

	if (empty($error)) {
		$query  = $admin->updateSettings($update);

		if ($query == true) {
			$data['status'] = 200;
		}
	}

	else{
		$data['status'] = 400;
		$data['error']  = $error;
	}
}

else if($action == 'ad-settings' && !empty($_POST)){
	$admin  = new Admin();
	$update = array();	
	$data   = array('status' => 304);
	$error  = false;
    
    if (ISSET($_POST['ad1'])) {
    	if (!empty($_POST['ad1'])) {
    		$update['ad1'] = base64_decode($_POST['ad1']);
    	}else{
    	    $update['ad1'] = '';
    	}
    }
	
    if (ISSET($_POST['ad2'])) {
    	if (!empty($_POST['ad2'])) {
    		$update['ad2'] = base64_decode($_POST['ad2']);
    	}else{
    	    $update['ad2'] = '';
    	}
    }
    
    if (ISSET($_POST['ad3'])) {
    	if (!empty($_POST['ad3'])) {
    		$update['ad3'] = base64_decode($_POST['ad3']);
    	}else{
    	    $update['ad3'] = '';
    	}
    }

	if (empty($error)) {
		$query  = $admin->updateSettings($update);

		if ($query == true) {
			$data['status'] = 200;
		}
	}

	//else{
	//	$data['status'] = 400;
	//	$data['error']  = $error;
	//}
}

else if($action == 'site-settings' && !empty($_POST)){
	$admin  = new Admin();
	$update = $_POST;	
	$data   = array('status' => 304);
	$error  = false;

	if (!empty($update['google_analytics'])) {
		$update['google_analytics'] = $admin::encode($update['google_analytics']);
	}

	if (empty($error)) {
		$query  = $admin->updateSettings($update);

		if ($query == true) {
			$data['status'] = 200;
		}
	}

	else{
		$data['status'] = 400;
		$data['error']  = $error;
	}
}

else if($action == 'email-settings' && !empty($_POST)){
	$admin  = new Admin();
	$update = $_POST;
	$data   = array('status' => 304);
	$error  = false;

	if (empty($error)) {
		$query  = $admin->updateSettings($update);

		if ($query == true) {
			$data['status'] = 200;
		}
	}

	else{
		$data['status'] = 400;
		$data['error']  = $error;
	}
}
else if($action == 'storeg-settings' && !empty($_POST)){
	$admin  = new Admin();
	$update = $_POST;
	$data   = array('status' => 304);
	$error  = false;

    $ftp_upload = (ISSET($_POST['ftp_upload']) ? $_POST['ftp_upload'] : '');
    $amazone_s3 = (ISSET($_POST['amazone_s3']) ? $_POST['amazone_s3'] : '');

    if( $ftp_upload == 1 ){
        $admin->updateSettings(array('amazone_s3' => 0));
    }
    if( $amazone_s3 == 1 ){
        $admin->updateSettings(array('ftp_upload' => 0));
    }
    
	$query  = $admin->updateSettings($update);

	if ($query == true) {
		$data['status'] = 200;
	}else{
	    $data['status'] = 400;
	    $data['error']  = "";
	}
                
}
else if($action == 'login-settings' && !empty($_POST)){
	$admin  = new Admin();
	$update = $_POST;
	$data   = array('status' => 304);
	$error  = false;

	$en_fb  = (!empty($_POST['fb_login']) && $_POST['fb_login'] == 'on');
	$en_tw  = (!empty($_POST['tw_login']) && $_POST['tw_login'] == 'on');
	$en_gl  = (!empty($_POST['gl_login']) && $_POST['gl_login'] == 'on');

	if  ($en_fb && (empty($config['facebook_app_id']) || empty($config['facebook_app_key']))) {
		$error = "To enable facebook login application key and id are required";
	}

	elseif ($en_tw && (empty($config['twitter_app_id']) || empty($config['twitter_app_key']))) {
		$error = "To enable twitter login application key and id are required";
	}

	elseif ($en_gl && (empty($config['google_app_id']) || empty($config['google_app_key']))) {
		$error = "To enable google login application key and id are required";
	}

	if (empty($error)) {
		$query  = $admin->updateSettings($update);

		if ($query == true) {
			$data['status'] = 200;
		}
	}

	else{
		$data['status'] = 400;
		$data['error']  = $error;
	}
}

elseif ($action == 'delete-user' && !empty($_POST['id']) && is_numeric($_POST['id'])) {
	$user_id = $user::secure($_POST['id']);
	$delete  = $user->setUserById($user_id)->delete();
	$data    = array('status' => 304);
	
	if ($delete) {
		$data['status'] = 200;
	}
}

elseif ($action == 'delete-post' && !empty($_POST['id']) && is_numeric($_POST['id'])) {
	$post_id = $user::secure($_POST['id']);
	$posts   = new Posts();
	$delete  = $posts->setPostId($post_id)->deletePost();
	$data    = array('status' => 304);

	if ($delete) {
		$data['status'] = 200;
	}
}

elseif ($action == 'activate-theme' && !empty($_POST['theme'])) {
	$theme   = $user::secure($_POST['theme']);
	$admin   = new Admin();
	$data    = array('status' => 304);
	$update  = $admin->updateSettings(array('theme' => $theme));
	if ($update) {
		$data['status'] = 200;
	}
}

elseif ($action == 'delete-report' && !empty($_POST['id']) && is_numeric($_POST['id'])) {
	if (!empty($_POST['t']) && is_numeric($_POST['t'])) {
		$rid     = $user::secure($_POST['id']);
		$type    = $user::secure($_POST['t']);
		$admin   = new Admin();
		$table   = ($type == 2) ? T_POST_REPORTS : T_USER_REPORTS;
		$data    = array('status' => 304);
		$delete  = $admin::$db->where('id',$rid)->delete($table);
		if ($delete) {
			$data['status'] = 200;
		}
	}
}

elseif ($action == 'generate-sitemap') {
	try {
		$sitemap = new Sitemap($site_url);
		$admin   = new Admin();
		$sitemap->setPath('sitemap/');

		{ 
			$sitemap->addItem('/about-us', '0.8', 'yearly', 'Never');
			$sitemap->addItem('/terms-of-use', '0.8', 'yearly', 'Never');
			$sitemap->addItem('/privacy-and-policy','0.8', 'yearly', 'Never');
			$sitemap->addItem('/welcome','0.8', 'yearly', 'Never');
			$sitemap->addItem('/signup','0.8', 'yearly', 'Never');
			$sitemap->addItem('/explore','0.8', 'yearly', 'Never');
		}
		
		{   
			$posts = $admin::$db->get(T_POSTS,null,array('post_id','time'));
			foreach ($posts as $post) {
				$pid = $post->post_id;
				$sitemap->addItem("/post/$pid", '0.8', 'daily', $post->time);
			}
		}

		$sitemap->createSitemapIndex("$site_url/sitemap/");
		$data['status']  = 200;
		$data['message'] = "New sitemap has been successfully generated";
		$data['time']    = date('Y-m-d h:i:s');
	} 
	catch (Exception $e) {
		$data['status']  = 500;
		$data['message'] = "ERROR: Permission denied in " . ROOT . '/sitemap/';
	}
}

else if($action == 'create-backup'){
	$error  = false;
	$admin  = new Admin();
	$zip_ex = class_exists('ZipArchive');

	if (empty($zip_ex)) {
		$error = 'ERROR: ZipArchive is not installed on your server';
	}

	else if(empty(is_writable(ROOT))){
		$error = 'ERROR: Permission denied in ' . ROOT . '/script_backups';
	}

	if (empty($error)) {
		try {
			$backup = $admin->createBackup();
			if ($backup == true) {
				$data['status']  = 200;
				$data['message'] = "New site backup has been successfully created";
				$data['time']    = date('Y-m-d h:i:s');
			}
		} 

		catch (Exception $e) {
			$data['status']  = 500;
			$data['message'] = "Something went wrong Please try again later!";
		}
	}

	else{
		$data['status']  = 500;
		$data['message'] = $error;
	}
}

else if($action == 'edit-lang-key'){
	$admin  = new Admin();
	$vl1    = (!empty($_POST['id']) && is_numeric($_POST['id']));
	$vl2    = (!empty($_POST['val']) && is_string($_POST['val']));
	$vl3    = (!empty($_POST['lang']) && in_array($_POST['lang'], array_keys($langs)));
	$vl4    = ($vl1 && $vl2 && $vl3);
	$data   = array(
		'status' => 400,
		'message' => "Something went wrong Please try again later!"
	);

	if ($vl4) {
		$key_id = $admin::secure($_POST['id']);
		$key_vl = $admin::secure($_POST['val']);
		$lang   = $admin::secure($_POST['lang']);

		$admin::$db->where('id',$key_id)->update(T_LANGS,array($lang => $key_vl));
		$data['status']  = 200;
		$data['message'] = "Language changes has been successfully saved";
	}
}

else if($action == 'delete-lang'){
	$admin  = new Admin();
	$t_lang = T_LANGS;
	$data   = array(
		'status' => 400,
	);

	if (!empty($_POST['id']) && in_array($_POST['id'], array_keys($langs)) && len(array_keys($langs)) >= 2) {
		$lang = $_POST['id'];
		try {
			@$admin::$db->rawQuery("ALTER TABLE `$t_lang` DROP `$lang`");
			$data   = array(
				'status' => 200,
			);
		} 

		catch (Exception $e) {
			
		}
	}
}

elseif ($action == 'terms-of-use' && !empty($_POST['terms'])) {
	$admin = new Admin();
	$page  = base64_decode(encode($_POST['terms']));
	$data  = array(
		'status' => 400,
		'message' => 'Can not save page, please check the details'
	);

	$save  = $admin->savePage('terms_of_use',$page);
	if ($save) {
		$data  = array(
			'status' => 200,
			'message' => 'New terms of use has been successfully saved!'
		);
	}
}

elseif ($action == 'about-us' && !empty($_POST['about_us'])) {
	$admin = new Admin();
	$page  = base64_decode(encode($_POST['about_us']));
	$data  = array(
		'status' => 400,
		'message' => 'Can not save page, please check the details'
	);

	$save  = $admin->savePage('about_us',$page);
	if ($save) {
		$data  = array(
			'status' => 200,
			'message' => 'Your changes has been successfully saved!'
		);
	}
}

elseif ($action == 'contact_us' && !empty($_POST['contact_us'])) {
	$admin = new Admin();
	$page  = base64_decode(encode($_POST['contact_us']));
	$data  = array(
		'status' => 400,
		'message' => 'Can not save page, please check the details'
	);

	$save  = $admin->savePage('contact_us',$page);
	if ($save) {
		$data  = array(
			'status' => 200,
			'message' => 'Your changes has been successfully saved!'
		);
	}
}

elseif ($action == 'privacy-and-policy' && !empty($_POST['privacy'])) {
	$admin = new Admin();
	$page  = base64_decode(encode($_POST['privacy']));
	$data  = array(
		'status' => 400,
		'message' => 'Can not save page, please check the details'
	);

	$save  = $admin->savePage('privacy_and_policy',$page);
	if ($save) {
		$data  = array(
			'status' => 200,
			'message' => 'Your changes has been successfully saved!'
		);
	}
}

elseif ($action == 'new-lang' && !empty($_POST['lang']) && is_string($_POST['lang'])) {
	$admin    = new Admin();
	$newlang  = strtolower($_POST['lang']);
	$stat     = 400;


	if (len($newlang) > 20) {
		$stat = 401;
	}
	elseif (in_array($newlang, array_keys($langs))) {
		$stat = 402;
	}
	else{
		try {
			$sql      = "ALTER TABLE `pxp_langs` ADD `$newlang` TEXT CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL";
			$add_lang =  mysqli_query($mysqli,$sql);
		} 

		catch (Exception $e) {
			
		}

		if (!empty($add_lang)) {
			$def_items = $admin->fetchLanguage();
			$stat      = 200;
			if (!empty($def_items)) {
				foreach ($def_items as $lang_key => $lang_val) {
					$admin::$db->where('lang_key',$lang_key);
					$admin::$db->update(T_LANGS,array($newlang => $def_items[$lang_key]));
				}
			}
		}
	}

	$data['status'] = $stat;
}

elseif ($action == 'new-key' && !empty($_POST['lang_key']) && is_string($_POST['lang_key'])) {
	$admin    = new Admin();
	$lang_key = strtolower($_POST['lang_key']);
	$stat     = 400;

	if (preg_match('/[^a-z0-9_]/', $lang_key)) {
		$stat = 401;
	}
	else if(len($lang_key) > 100){
		$stat = 402;
	}
	else if(in_array($lang_key, array_keys($lang))){
		$stat = 403;
	}
	else{
		$stat = 200;
		$admin::$db->insert(T_LANGS,array('lang_key' => $lang_key));
	}

	$data['status'] = $stat;
}

elseif ($action == 'test_s3'){
	

	try {
		$s3Client = S3Client::factory(array(
			'version' => 'latest',
			'region' => $config['region'],
			'credentials' => array(
				'key' => $config['amazone_s3_key'],
				'secret' => $config['amazone_s3_s_key']
			)
		));
		$buckets  = $s3Client->listBuckets();
		$result = $s3Client->putBucketCors([
			'Bucket' => $config['bucket_name'], // REQUIRED
			'CORSConfiguration' => [ // REQUIRED
				'CORSRules' => [ // REQUIRED
					[
						'AllowedHeaders' => ['Authorization'],
						'AllowedMethods' => ['POST', 'GET', 'PUT'], // REQUIRED
						'AllowedOrigins' => ['*'], // REQUIRED
						'ExposeHeaders' => [],
						'MaxAgeSeconds' => 3000
					],
				],
			]
		]);

		if (!empty($buckets)) {
			if ($s3Client->doesBucketExist($config['bucket_name'])) {
				$stat = 200;
				$array          = array(
					'media/img/d-avatar.jpg',
					'media/img/story-bg.jpg',
					'media/img/user-m.png'
				);
				$media = new Media();
				foreach ($array as $key => $value) {
					$upload = $media->uploadToS3($value, false);
				}
			} else {
				$stat = 300;
			}
		} else {
			$stat = 500;
		}
	}
	catch (Exception $e) {
		$stat  = 400;
		$data['message'] = $e->getMessage();
	}

	$data['status'] = $stat;
	
} elseif ($action == 'test_ftp'){
	try {
		$ftp = new \FtpClient\FtpClient();
		$ftp->connect($config['ftp_host'], false, $config['ftp_port']);
		$login = $ftp->login($config['ftp_username'], $config['ftp_password']);
	    $array = array(
			'media/img/d-avatar.jpg',
			'media/img/story-bg.jpg',
			'media/img/user-m.png'
        );
        $media = new Media();
        foreach ($array as $key => $value) {
            $upload = $media->uploadToFtp($value,false);
        }
		$stat  = 200;
	} catch (Exception $e) {
		$stat  = 400;
		$data['message'] = $e->getMessage();
	}
	$data['status'] = $stat;
}

elseif ($action == 'delete_v_request_' && !empty($_POST['id'])) {
	$admin    = new Admin();
	$stat = 200;
	$id = $user::secure($_POST['id']);
	$admin::$db->where('id',$id);
	$request = $admin::$db->getOne(T_VERIFY);
	if (!empty($request)) {
		$admin::$db->where('id',$id);
		$admin::$db->delete(T_VERIFY);
	}
	$data['status'] = $stat;
}

elseif ($action == 'accept_v_request_' && !empty($_POST['id'])) {
	$admin    = new Admin();
	$stat = 200;
	$id = $user::secure($_POST['id']);
	$admin::$db->where('id',$id);
	$request = $admin::$db->getOne(T_VERIFY);
	if (!empty($request)) {
		$admin::$db->where('user_id',$request->user_id);
		$admin::$db->update(T_USERS,array('verified' => 1));

		$admin::$db->where('id',$id);
		$admin::$db->delete(T_VERIFY);
	}
	$data['status'] = $stat;
}
elseif ($action == 'playtube_support' && !empty($_POST['playtube'])) {
	$admin    = new Admin();
	$playtube = $user::secure($_POST['playtube']);
	$playtube_links = $user::secure($_POST['playtube_links']);
	$query  = $admin->updateSettings(array('playtube_url' => $playtube,
                                           'playtube_links' => $playtube_links));
	if ($query == true) {
		$data['status'] = 200;
	}
}
elseif ($action == 'add_ban' && !empty($_POST['value'])) {
	$admin    = new Admin();
	$value = $user::secure($_POST['value']);
	$admin::$db->insert(T_BLACKLIST,array('value' => $value,
                                          'time'  => time()));
	$data['status'] = 200;
}
elseif ($action == 'delete-ban' && !empty($_POST['id'])) {
	$admin    = new Admin();
	$id = $user::secure($_POST['id']);
	$admin::$db->where('id',$id);
	$admin::$db->delete(T_BLACKLIST);
	$data['status'] = 200;
}