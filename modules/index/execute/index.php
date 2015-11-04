<?php

class index{
	
	private function getBoardsData(){
		$q = mysql_query("SELECT * FROM `boards`");
		$boards_data = array();
		while($fetch = mysql_fetch_array($q)){
			$fetch["board_count"] = 123;
			$boards_data[] = $fetch;
		}
		return $boards_data;
	}
	public function action_default(){

		$boards_data = self::getBoardsData();
		
		$boards_info = array();
		$boards_info_query = mysql_query("SELECT board_letter FROM `boards`");

		while($fetch = mysql_fetch_array($boards_info_query)){
			$boards_info[] = $fetch;
		}
		$board_info = array();
		$board_info["name"] = "Current board name";
		$threads_data  = array();
		
		
		Template::display("header", array('boards_data' => $boards_data));
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
		$board_info = mysql_fetch_assoc($board_info_query);
		
		if (!isset($board_info['board_letter'])){
			throw new Exception('00906');
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
        Template::display("header", array('boards_data' => self::getBoardsData()));
        Template::assign(array('threads_data' => $threads_data, 'board_info'=> $board_info));
        Template::display("board");
	}
	
	private function upload_file($file, $realname){
		
		
		$hash = base64_encode(sha1($file) ^ md5($file));
		$ext = end(explode('.', $realname));
		$filename = abs(crc32($file)) . '_' . time() . '.' . $ext;
		
		//lol!
		//smile, please
		$file = str_replace('<?php', '', $file);
		$file = str_replace('php', '', $file);
		$file = str_replace('cgi', '', $file);
		$file = str_replace('bin', '', $file);
		$file = str_replace('bash', '', $file);
		$file = str_replace('python', '', $file);
		
		$start_dir = ROOT . STATIC_DIR .'/';
		$url = STATIC_DIR . "/";
		for($i = 0; $i <= 5; ++$i){
			$start_dir .= $hash{$i} . "/";
			$url .= $hash{$i} . "/";
			if (!is_dir($start_dir)){
				mkdir($start_dir);
			}
		}
		
		//echo $start_dir. $filename .'||||||||';
		file_put_contents($start_dir. $filename, $file);
		
		return $url . $filename;
	}
	public function action_createThread(){
		$q = mysql_query("SELECT * FROM `boards` WHERE (`board_letter` = '".escape(ROUTE_CONTROLLER_URL)."')");
		$board = mysql_fetch_array($q);
		if (!isset($board['board_id'])){
			throw new Exception("00506");
			exit();
		}
		
		
		///echo "create_thread form" . '<br/>';
		//echo "Thread: " . ROUTE_CONTROLLER_URL . '<br/>';
		//echo "Tn: " . $_POST["topic_name"] . '<br/>';
		//echo "Tt: " . $_POST["topic_text"] . '<br/>';
		//echo "Tt: " . $_POST["topic_author"] . '<br/>';
		//echo "Tb: " . $_POST["board"] . '<br/> ';
		
		$topic_author = escape($_POST["topic_author"]);
		$topic_message = escape($_POST["topic_text"]);
		$topic_name = escape($_POST["topic_name"]);
		
		$q = mysql_query("CALL CreateThread (@thread_id, @message_id, '".((empty($topic_name)) ? 'КОНИ, НОЖИ, ДЕТИ, АНИМЕ' : $topic_name)."', '".intval($board['board_id'])."', '".((empty($topic_author)) ? 'Аноним' : $topic_author)."', '".((empty($topic_message)) ? 'Я не умею писать сообщения' : $topic_message)."');");
		$q = mysql_query("SELECT @thread_id, @message_id;");		
		
		$add = mysql_fetch_array($q);
		//array(4) { [0]=> string(2) "21" ["@thread_id"]=> string(2) "21" [1]=> string(2) "10" ["@message_id"]=> string(2) "10" }
		
		var_dump($_POST);
		var_dump($_FILES);
		
		$image_url = "";
		if (isset($_FILES['image_file'])){
			$file = file_get_contents($_FILES['image_file']["tmp_name"]);
			$image_url = self::upload_file($file, $_FILES['image_file']["name"]);
		}
		
		$video_url = "";
		if (isset($_FILES['video_file'])){
			$file = file_get_contents($_FILES['video_file']["tmp_name"]);
			$video_url = self::upload_file($file, $_FILES['video_file']["name"]);
		}
		
		
		echo $image_url . "\n";
		echo $video_url;
		/*
		array(2) {
  ["image_file"]=>
  array(5) {
    ["name"]=>
    string(15) "zL5PaeZCCqI.jpg"
    ["type"]=>
    string(10) "image/jpeg"
    ["tmp_name"]=>
    string(23) "C:\xampp\tmp\phpB4A.tmp"
    ["error"]=>
    int(0)
    ["size"]=>
    int(584769)
  }
  ["video_file"]=>
  array(5) {
    ["name"]=>
    string(19) "14466278445041.webm"
    ["type"]=>
    string(10) "video/webm"
    ["tmp_name"]=>
    string(23) "C:\xampp\tmp\phpB4B.tmp"
    ["error"]=>
    int(0)
    ["size"]=>
    int(2642716)
  }
}
*/
		
		/*
		if (is_uploaded_file($_FILES['image_file']["tmp_name"])){
			if (move_uploaded_file($_FILES['image_file']['tmp_name'], $uploadfile)) {
				echo "Файл корректен и был успешно загружен.\n";
			} 
		}
		*/
		/*
		
		["image_file"]=>
		string(15) "zL5PaeZCCqI.jpg"
		["video_file"]=>
		string(19) "14466278445041.webm"
		*/
		
		
		
		
		//redirect("/".$board['board_letter']."/".$add["@thread_id"]);
		
		//Генадий Гренкин
	}
}