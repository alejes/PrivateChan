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

        $board_info_query = mysql_query("SELECT * FROM `boards` WHERE (`board_letter` = '".$letter."')");
        while($fetch = mysql_fetch_assoc($board_info_query)){
            $board_info = $fetch;
        }
        $board_info["name"] = $board_info["board_name"];
        echo $board_info["name"];

        $threads_query = mysql_query("SELECT * FROM `boards` AS b 
											JOIN threads as t on b.board_id = t.board_id");

        $threads_data = array();
        while($fetch = @mysql_fetch_assoc($threads_query)){
            $threads_data[] = $fetch;
        }

        Template::display("header");
        Template::assign(array('threads_data' => $threads_data, 'board_info'=> $board_info));
        Template::display("board");
	}
	
	public function action_create_thread(){
		echo "create_thread form";
	}
}