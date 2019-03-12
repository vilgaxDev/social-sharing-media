<?php
if ($config['last_clean_db'] <= (time() - 86400)) {
	$admin = new Admin();
	$admin->updateSettings(array(
		'last_clean_db' => time()
	));

	$admin::$db->where('seen','0','>')->delete(T_NOTIF);

	$storyids = array();
	$stories  = $admin::$db->where('time',(time() - 86400),'<=')->get(T_STORY,null,array('id','media_file'));
	if (!empty($stories) && is_array($stories)) {
		foreach ($stories as $story_data) {
			$storyids[] = $story_data->id;
			if (file_exists($story_data->media_file)) {
				@unlink($story_data->media_file);
			}
		}

		if (!empty($storyids) && len($storyids)) {
			$admin::$db->where('id',$storyids,'IN')->delete(T_STORY);
		}
	}

	$admin::$db->where('deleted_fs1','1');
	$admin::$db->where('deleted_fs2','1')->delete(T_MESSAGES);
}
?>