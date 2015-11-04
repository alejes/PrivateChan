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
		//Template::display("board");
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
        while($fetch = @mysql_fetch_assoc($board_info_query)){
            $board_info = $fetch;
        }
        $board_info["name"] = $board_info["board_name"];

        $threads_query = mysql_query("SELECT * FROM `boards` AS b 
											JOIN threads as t on b.board_id = t.board_id");

        $threads = array();
        $threads_data = array();
        while($fetch = @mysql_fetch_assoc($threads_query)){
            $threads[] = $fetch;
            $message_query = mysql_query("select message_id, author, body, ts from `messages` as m join threads as t on t.thread_id = m.thread_id");
            while($fetch_msg = @mysql_fetch_assoc($message_query))
            {
                $fetch_msg["create_date"] = $fetch_msg["ts"];
                $fetch_msg["name"] = $fetch_msg["author"];
                $fetch_msg["text"] = $fetch_msg["body"];
                $fetch_msg["id"] = $fetch_msg["message_id"];
                $threads_data[] = $fetch_msg;
            }
        }
        Template::display("header");
        Template::assign(array('threads_data' => $threads_data, 'board_info'=> $board_info));
        Template::display("board");
	}
	
	public function action_createThread(){
		$q = mysql_query("SELECT * FROM `boards` WHERE (`board_letter` = '".escape(ROUTE_CONTROLLER_URL)."')");
		$board = mysql_fetch_array($q);
		if (!isset($board['board_id'])){
			throw new Exception("00506");
			exit();
		}
		
		
		echo "create_thread form" . '<br/>';
		echo "Thread: " . ROUTE_CONTROLLER_URL . '<br/>';
		echo "Tn: " . $_POST["topic_name"] . '<br/>';
		echo "Tt: " . $_POST["topic_text"] . '<br/>';
		echo "Tt: " . $_POST["topic_author"] . '<br/>';
		echo "Tb: " . $_POST["board"] . '<br/> ';
		
		$topic_author = escape($_POST["topic_author"]);
		$topic_message = escape($_POST["topic_text"]);
		$topic_name = escape($_POST["topic_name"]);
		
		$q = mysql_query("CALL CreateThread (@thread_id, @message_id, '".((empty($topic_name)) ? 'КОНИ, НОЖИ, ДЕТИ, АНИМЕ' : $topic_name)."', '".intval($board['board_id'])."', '".((empty($topic_author)) ? 'Аноним' : $topic_author)."', '".((empty($topic_message)) ? 'Я не умею писать сообщения' : $topic_message)."');");
		$q = mysql_query("SELECT @thread_id, @message_id;");		
		
		$add = mysql_fetch_array($q);
		var_dump($add);
        #INSERT INTO `messages` (`message_id`, `author_name`, `body`, `thread_id`) VALUES (NULL, 'anon', 'Текст сообщения', '0');
        #INSERT INTO `threads` (`thread_id`, `thread_name`, `board_id`, `first_message_id`) VALUES ('', 'Gurenn Lagann', '1', '0');
		//CALL CreateThread (@thread_id, @message_id, "THREAD NAME", 1, "ANONIM", "TEXT MESSAGE") 
		//Генадий Гренкин
	}
}