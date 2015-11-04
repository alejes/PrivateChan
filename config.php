<?php

if (!file_exists('password.php')){
	copy('password.sample.php', 'password.php');
}
	require('password.php');


define ('ROOT', __DIR__ .'/');
define ('STATIC_DIR', 'static');

$link = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD)
	or die("Could not connect: " . mysql_error());

mysql_select_db(MYSQL_DB, $link) or die ('Can\'t connect to database : ' . mysql_error());

//$mysqli = mysqli_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DB);

mysql_set_charset('utf8',$link);
//mysqli_set_charset($mysqli, 'utf8');

mb_internal_encoding('UTF-8');


?>