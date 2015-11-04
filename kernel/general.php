<?php

function escape($str){
	return mysql_real_escape_string(htmlspecialchars($str, ENT_QUOTES));
}

?>