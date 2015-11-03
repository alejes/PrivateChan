<?php

class index{
	
	public function action_default(){
		$q = mysql_query("SELECT * FROM `boards`");

		$boards_data = array();
		while($fetch = mysql_fetch_array($q)){
			$fetch["board_count"] = 123;
			$boards_data[] = $fetch;
		}
		$boards_info = array();
		$boards_info_query = mysql_query("SELECT board_letter FROM `boards`");

		while($fetch = mysql_fetch_array($boards_info_query)){
			$boards_info[] = $fetch;
		}
		$board_info = array();
		$board_info["name"] = "Current board name";
		$threads_data  = array();
		
		
		Template::display("header");
		Template::assign(array('boards_data' => $boards_data));
		Template::display("board_list");
		Template::assign(array('board_info' => $board_info, 'threads_data'=> $threads_data));
		Template::display("board");
		Template::display("footer");

	}
	public function action_showBoard($letter = ""){
		if (empty($letter)){
			if (defined('ROUTE_CONTROLLER_URL')){
				$letter = ROUTE_CONTROLLER_URL;
			}
			else{
				$letter = 'a';
			}
		}
		echo "Board:" . $letter ;
	}
	
	public function action_hyj(){
		echo "hyj";
	}
}