<?php

define ('MYSQL_HOST', 'localhost');
define ('MYSQL_USER', 'root');
define ('MYSQL_PASSWORD', '');
define ('MYSQL_DB', 'auchan');


$link = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD)
	or die("Could not connect: " . mysql_error());

mysql_select_db(MYSQL_DB, $link) or die ('Can\'t connect to database : ' . mysql_error());

mysql_set_charset('utf8',$link);



?>