<?php
include "config.php";


echo 'Supper pupper bashes';

$q = mysql_query("SELECT * FROM `boards`");

while($fetch = mysql_fetch_array($q)){
	var_dump($fetch);
	
}


?>