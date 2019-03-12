<?php


function media($path = ""){
    global $site_url, $config;
    preg_match('/^(media\/upload\/|media\/img\/)(?:.+?)$/is',$path,$matches);
    if (!empty($matches)) {
        $load_url = $site_url;
        if ($config['amazone_s3'] == 1) {
            $load_url = 'https://s3.amazonaws.com/' . $config['bucket_name']; 
        } else if ($config['ftp_upload'] == 1) {
            $load_url = $config['ftp_endpoint']; 
        }
        $path = implode('/', array($load_url, $path));
    }
    else{
        $path = urldecode($path);
    }

    return $path;
}

function un2url($username = ""){
    global $site_url;
    $url = sprintf('%s/@%s',$site_url,$username);
    return $url;
}

function br2nl($st) {
    $breaks   = array(
        "\r\n",
        "\r",
        "\n"
    );
    $st       = str_replace($breaks, "", $st);
    $st_no_lb = preg_replace("/\r|\n/", "", $st);
    return preg_replace('/<br(\s+)?\/?>/i', "\r", $st_no_lb);
}
function pid2url($post_id = 0){
    global $site_url;
    $url = sprintf('%s/post/%u',$site_url,$post_id);
    return $url;
}

function croptxt($text = "", $len = 100,$ellip = '..') {
    if (empty($text) || !is_string($text) || !is_numeric($len) || $len < 1) {
        return '';
    }
    if (strlen($text) > $len) {
        $text = mb_substr($text, 0, $len, "UTF-8") . $ellip;
    }
    return $text;
}

function o2array($obj) {
	
    if (is_object($obj))
        $obj = (array) $obj;

    if (is_array($obj)) {
        $new = array();
        foreach ($obj as $key => $val) {
            $new[$key] = o2array($val);
        }
    } 

    else {
        $new = $obj;
    }

    return $new;
}

function get_ip_address() {
    if (!empty($_SERVER['HTTP_CLIENT_IP']) && filter_var($_SERVER['HTTP_CLIENT_IP'], FILTER_VALIDATE_IP)) {
        return $_SERVER['HTTP_CLIENT_IP'];
    }
    if (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
        if (strpos($_SERVER['HTTP_X_FORWARDED_FOR'], ',') !== false) {
            $iplist = explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
            foreach ($iplist as $ip) {
                if (filter_var($ip, FILTER_VALIDATE_IP))
                    return $ip;
            }
        } else {
            if (filter_var($_SERVER['HTTP_X_FORWARDED_FOR'], FILTER_VALIDATE_IP))
                return $_SERVER['HTTP_X_FORWARDED_FOR'];
        }
    }
    if (!empty($_SERVER['HTTP_X_FORWARDED']) && filter_var($_SERVER['HTTP_X_FORWARDED'], FILTER_VALIDATE_IP))
        return $_SERVER['HTTP_X_FORWARDED'];
    if (!empty($_SERVER['HTTP_X_CLUSTER_CLIENT_IP']) && filter_var($_SERVER['HTTP_X_CLUSTER_CLIENT_IP'], FILTER_VALIDATE_IP))
        return $_SERVER['HTTP_X_CLUSTER_CLIENT_IP'];
    if (!empty($_SERVER['HTTP_FORWARDED_FOR']) && filter_var($_SERVER['HTTP_FORWARDED_FOR'], FILTER_VALIDATE_IP))
        return $_SERVER['HTTP_FORWARDED_FOR'];
    if (!empty($_SERVER['HTTP_FORWARDED']) && filter_var($_SERVER['HTTP_FORWARDED'], FILTER_VALIDATE_IP))
        return $_SERVER['HTTP_FORWARDED'];
    return $_SERVER['REMOTE_ADDR'];
}

function px_multiple_files($file_post = array()) {
    if (!is_array($file_post)) {
        return array();
    }
    $wo_file_array = array();
    $wo_file_count = count($file_post['name']);
    $wo_file_keys  = array_keys($file_post);
    for ($i=0; $i < $wo_file_count; $i++) {
        foreach ($wo_file_keys as $key) {
            $wo_file_array[$i][$key] = $file_post[$key][$i];
        }
    }
    return $wo_file_array;
}

function px_covtime($youtube_time) {
    preg_match_all('/(\d+)/', $youtube_time, $parts);
    // Put in zeros if we have less than 3 numbers.
    if (count($parts[0]) == 1) {
        array_unshift($parts[0], "0", "0");
    } elseif (count($parts[0]) == 2) {
        array_unshift($parts[0], "0");
    }
    $sec_init         = $parts[0][2];
    $seconds          = $sec_init % 60;
    $seconds_overflow = floor($sec_init / 60);
    $min_init         = $parts[0][1] + $seconds_overflow;
    $minutes          = ($min_init) % 60;
    $minutes_overflow = floor(($min_init) / 60);
    $hours            = $parts[0][0] + $minutes_overflow;
    if ($hours != 0)
        return $hours . ':' . $minutes . ':' . $seconds;
    else
        return $minutes . ':' . $seconds;
}

function pxp_sqltepmlate($path = '',$data = array()){
  $temp_path = ROOTPATH . "/sys/sql_templates/$path.sql";
  $template  = false;
  if (file_exists($temp_path)) {
    $if   = '/(\{\%\s{0,1}if\s{1}(?P<key>[\w]+)\s{0,1}\%\}(?P<sq>.+?)\{\%\s{0,1}endif\s{0,1}\%\})/is';
  	$ifeq = '/(\{\%\s{0,1}if\s{1}[\'\"]?(?P<key>[^\s]+?)[\'\"]?\s==\s[\'\"]?(?P<val>[^\s]+?)[\'\"]?\s{0,1}\%\}(?P<sq>.+?)\{\%\s{0,1}endif\s{0,1}\%\})/is';

    $template = file_get_contents($temp_path);

    foreach ($data as $key => $value) {
        $template = preg_replace_callback($ifeq, function($m) use($data) {

            if ($m && !empty($m['key']) && !empty($m['val']) && !empty($data[$m['key']]) && ($data[$m['key']] == $m['val'])) {
                return (!empty($m['sq'])) ? $m['sq'] : '';
            }
            else{
                return '';
            }

        },$template);

    	$template = preg_replace_callback($if, function($m) use($data) {
            if ($m && !empty($m['key']) && !empty($data[$m['key']])) {
                return (!empty($m['sq'])) ? $m['sq'] : '';
            }
            else{
                return '';
            }

        },$template);

        $template = preg_replace("/\{\%\s{0,1}$key\s{0,1}\%\}/i",$value, $template);
    	$template = preg_replace("/\{\@(.*?)\@\}/is",'', $template);
    }

  }

  return $template;
}

function pxp_link($path = "") {
    global $site_url;
    return sprintf('%s/%s',$site_url,$path);
}

function url($url = '',$path = ''){
    return sprintf('%s/%s',$url,$path);
}

function ToDate($time = '') {
    return date('c', $time);
}

function time2str($ptime) {
    $etime = time() - $ptime;
    if ($etime < 1) {
        return sprintf('%d %s',0,lang('seconds'));
    }
    $a = array(
        365 * 24 * 60 * 60 => 'year',
        30 * 24 * 60 * 60 => 'month',
        24 * 60 * 60 => 'day',
        60 * 60 => 'hour',
        60 => 'minute',
        1 => 'second'
    );
    $a_plural = array(
        'year' => 'years',
        'month' => 'months',
        'day' => 'days',
        'hour' => 'hours',
        'minute' => 'minutes',
        'second' => 'seconds'
    );
    foreach ($a as $secs => $str) {
        $d = $etime / $secs;
        if ($d >= 1) {
            $r = round($d);
            return $r . ' ' . ($r > 1 ? lang($a_plural[$str]) : lang($str)) . ' ' . lang('time_ago');
        }
    }
}


function pre($val = null){
    echo "<pre>";
    print_r($val);
    echo "</pre>";
    exit();
}

function pxp_mentions($text = ""){
    preg_match_all('/(?:^|\s|,)\B@([a-zA-Z0-9_]{4,32})/is', $text, $mentions);
    $users = array();
    if (is_array($mentions) && !empty($mentions[1])) {
        $users = $mentions[1];
    }

    return $users;
}

function pxp_get_hashtags($text = ""){

    preg_match_all('/#([^`~!@$%^&*\#()\-+=\\|\/\.,<>?\'\":;{}\[\]* ]{4,120})/is', $text, $hashtags);
    $tags = array();
    if (is_array($hashtags) && !empty($hashtags[1])) {
        $tags = $hashtags[1];
    }

    return $tags;
}

function is($boolval  = null){
    return ($boolval == true);
}

function not($boolval  = null){
    return ($boolval != true);
}

function date4mat($time = 0,$format = ''){
    return date($format,$time);
}

function icon($icon_name = '',$icon_type = 'svg'){
    global $site_url;
    $ipath = sprintf('%s/media/icons/%s.%s',$site_url,$icon_name,$icon_type);
    return $ipath;
}

function len($val = ""){
    if (is_string($val)) {
        $val = strlen($val);
    }

    elseif (is_array($val)) {
        $val = count($val);
    }
    
    return $val;
}

function minify_js($code = ''){
    $code = preg_replace('/(\r\n|\n|\t|\s{2,})/is', '', $code);
    return $code;
}

function pxp_acp_link($path = ''){
    global $site_url;
    return sprintf('%s/admin-panel/%s',$site_url,$path);
}

function pxp_getconfig(){
    global $db;
    $data    = array();
    $configs = $db->get(T_CONFIG,null,array('name','value'));
    
    foreach ($configs as $key => $config) {
        $data[$config->name] = $config->value;
    }

    return $data;
}

function encode($html = ""){
    return htmlspecialchars($html);
}

function decode($html = ""){
    return htmlspecialchars_decode($html);
}

function lang($key = ""){
    global $lang,$config;
    $repl = array(
        'site_name' => $config['site_name'],
    );

    $text = (array_key_exists($key, $lang) == true) ? $lang[$key] : "Lang key ($key) not exists";
    foreach ($repl as $key => $value) {
        $text = preg_replace("/\{{2}$key\}{2}/", $value, $text);
    }
    $text = str_replace('% d', '%d', $text);
    $text = str_replace('٪ d', '%d', $text);
    $text = str_replace('٪d', '%d', $text);
    $text = str_replace('% ', '%d', $text);
    $text = str_replace('%d', ' %d ', $text);
    return $text;
}

function pxp_gencsrf_token() {
    if (!empty($_SESSION['csrf'])) {
        return $_SESSION['csrf'];
    }
    
    $hash = substr(sha1(rand(1111, 9999)), 0, 70);
    $slat = time();
    $hash = sprintf('%d:%s',$slat,$hash);

    $_SESSION['csrf'] = $hash;

    return $hash;
}

function pxp_verifcsrf_token($hash = '') {
    if (empty($_SESSION['csrf']) || empty($hash)) {
        return false;
    }

    return ($hash == $_SESSION['csrf']) ? true : false;
}

