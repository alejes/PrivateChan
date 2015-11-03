<?php
require "config.php";


echo 'Supper pupper bashes';

$q = mysql_query("SELECT * FROM `boards`");

$boards_data = array();
while($fetch = mysql_fetch_array($q)){
	$fetch["board_count"] = 123;
	$boards_data[] = $fetch;
}
include 'templates/header.tpl';
include 'templates/board_list.tpl';
include 'templates/footer.tpl';

$boards_info = array();
$boards_info_query = mysql_query("SELECT board_letter FROM `boards`");

while($fetch = mysql_fetch_array($boards_info_query)){
    $boards_info[] = $fetch;
}


?>