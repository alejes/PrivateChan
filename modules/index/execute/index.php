<?php

/**
 * Модуль имиджборды
 */

class index{

    private function getBoardsData(){
        $query = mysql_query("SELECT * FROM `boards`");

        $message_cnt_query = mysql_query("SELECT * FROM `boards_message_counts` GROUP BY board_id");
        $message_cnt = array();
        while($fetch = mysql_fetch_array($message_cnt_query)){
            $message_cnt[$fetch["board_id"]] = $fetch["message_count"];
        }

        $boards_data = array();
        while($fetch = mysql_fetch_array($query)){
            $fetch["board_count"] = $message_cnt[$fetch["board_id"]];
            $boards_data[] = $fetch;
        }
        return $boards_data;
    }

    public function action_default(){

        $boards_data = self::getBoardsData();

        $boards_info = array();
        $boards_info_query = mysql_query("SELECT `board_letter` FROM `boards`");

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
        $boards_query = mysql_query("SELECT * FROM `threads_view` WHERE board_id = '".$board_info["board_id"]."' ORDER BY thread_id DESC");

        $message_cnt_query = mysql_query("SELECT * FROM `threads_message_counts` GROUP BY thread_id ");
        $threads_messages_count = array();
        while ($fetch = mysql_fetch_assoc($message_cnt_query)) {
            $threads_messages_count[$fetch["thread_id"]] = $fetch["message_count"];
        }
        $threads_data = array();
        while($fetch_msg = @mysql_fetch_assoc($boards_query)){
            $fetch_msg["create_date"] = $fetch_msg["ts"];
            $fetch_msg["name"] = $fetch_msg["thread_name"];
            $fetch_msg["text"] = $fetch_msg["body"];
            $fetch_msg["id"] = $fetch_msg["thread_id"];
            if ($fetch_msg["image"] != "")
                $fetch_msg["image_url"] = $fetch_msg["image"];
            if ($fetch_msg["video"] != "")
                $fetch_msg["video_url"] = $fetch_msg["video"];

            $fetch_msg["answers"] = $threads_messages_count[$fetch_msg["thread_id"]] - 1;

            $threads_data[] = $fetch_msg;
        }
        Template::display("header", array('boards_data' => self::getBoardsData()));
        Template::assign(array('threads_data' => $threads_data, 'board_info'=> $board_info));
        Template::display("board");
        Template::display("footer");
    }

    private function upload_file($file, $realname){

        $hash = base64_encode(sha1($file) ^ md5($file));
        $allow_extension = array('webm', 'jpeg', 'jpg', 'bmp', 'gif', 'mp4', 'png');
        $ext = strtolower(end(explode('.', $realname)));

        if (!in_array($ext, $allow_extension)){
            echo "Wrong filetype";
            throw new Exception('00673');
        }

        $filename = abs(crc32($file)) . '_' . time() . '.' . $ext;

        //lol!
        //smile, please
        $file = str_replace('<?php', '', $file);
        $file = str_replace('php', '', $file);
        $file = str_replace('cgi', '', $file);
        $file = str_replace('bin', '', $file);
        $file = str_replace('bash', '', $file);
        $file = str_replace('python', '', $file);

        $start_dir = ROOT . STATIC_DIR .'/content/';
        if (!is_dir($start_dir)){
            mkdir($start_dir);
            chmod($start_dir, 0777);
        }
        $url = STATIC_DIR . "/content/";
        for($i = 0; $i <= 5; ++$i){
            $start_dir .= $hash{$i} . "/";
            $url .= $hash{$i} . "/";
            if (!is_dir($start_dir)){
                mkdir($start_dir);
                chmod($start_dir, 0777);
            }
        }

        file_put_contents($start_dir. $filename, $file);

        return $url . $filename;
    }

    public function action_createThread(){
        $query = mysql_query("SELECT * FROM `boards` WHERE (`board_letter` = '".escape(ROUTE_CONTROLLER_URL)."')");
        $board = mysql_fetch_array($query);
        if (!isset($board['board_id'])){
            throw new Exception("00506");
            exit();
        }

        $topic_author = full_escape($_POST["topic_author"]);
        $topic_message = escape($_POST["topic_text"]);
        $topic_name = full_escape($_POST["topic_name"]);

        $add = mysql_fetch_array($query);

        $image_url = "";
        if (isset($_FILES['image_file']["tmp_name"]) && !empty($_FILES['image_file']["tmp_name"])){
            $file = file_get_contents($_FILES['image_file']["tmp_name"]);
            $image_url = self::upload_file($file, $_FILES['image_file']["name"]);
        }

        $video_url = "";
        if (isset($_FILES['video_file']["tmp_name"]) && !empty($_FILES['video_file']["tmp_name"])){
            $file = file_get_contents($_FILES['video_file']["tmp_name"]);
            $video_url = self::upload_file($file, $_FILES['video_file']["name"]);
        }

        //Мы не ограничиваем пользователей. Но если они не заполнии часть обязательных полей, предложим им наиболее подходящее название, исходя из интересов среднестатистического имиджбордера

        $query = mysql_query("CALL CreateThread (@thread_id, @message_id, '".((empty($topic_name)) ? 'КОНИ, НОЖИ, ДЕТИ, АНИМЕ' : $topic_name)."', '".intval($board['board_id'])."', '".((empty($topic_author)) ? 'Аноним' : $topic_author)."', '".((empty($topic_message)) ? 'Я не умею писать сообщения' : $topic_message)."', '".$image_url."', 'NULL', '".$video_url."')");

        $query = mysql_query("SELECT @thread_id, @message_id");

        $add = mysql_fetch_array($query);

        redirect("/".$board['board_letter']."/".$add["@thread_id"]);

    }

    public function action_showThread($letter = "", $thread_id = ""){
        if (empty($letter)){
            if (defined('ROUTE_CONTROLLER_URL')){
                $letter = ROUTE_CONTROLLER_URL;
            }
            else{
                $letter = 'a';
            }
        }
        if (empty($thread_id)){
            if (defined('ROUTE_SEGMENT')){
                $thread_id = intval(ROUTE_SEGMENT);
            }
            else throw new Exception('00404');
        }

        $board_info_query = mysql_query("SELECT * FROM `boards` WHERE (`board_letter` = '".$letter."')");
        $board_info = mysql_fetch_assoc($board_info_query);

        if (!isset($board_info['board_letter'])){
            throw new Exception('00906');
        }

        $board_info["name"] = $board_info["board_name"];

        $messages_query = mysql_query("SELECT * FROM `threads_all_messages` WHERE (`thread_id` = '".$thread_id."')");
        $threads_data = array();
        while($fetch_msg = @mysql_fetch_assoc($messages_query)){
            $fetch_msg["create_date"] = $fetch_msg["ts"];
            $fetch_msg["name"] = "post";
            $fetch_msg["text"] = $fetch_msg["body"];
            $fetch_msg["id"] = $fetch_msg["message_id"];
            if ($fetch_msg["image"] != "") {
                $fetch_msg["image_url"] = $fetch_msg["image"];
            }
            if ($fetch_msg["video"] != "")
                $fetch_msg["video_url"] = $fetch_msg["video"];
            $fetch_msg["ids"] = array();
            $curr_id = $fetch_msg["message_id"];
            while ($curr_id > 0) {
                $messages_parents_query = mysql_query("SELECT * FROM `messages_parents` WHERE (`child_id` = '" . $curr_id . "')");
                $flag = true;
                while ($fetch_parent_ids = @mysql_fetch_assoc($messages_parents_query)) {
                    $fetch_msg["ids"][] = $fetch_parent_ids["parent_id"];
                    $curr_id = $fetch_parent_ids["parent_id"];
                    $flag = false;
                }
                if ($flag)
                    $curr_id = 0;
            }
            $fetch_msg["depth"] =  count($fetch_msg["ids"]);
            $threads_data[] = $fetch_msg;
        }
        Template::display("header", array('boards_data' => self::getBoardsData()));
        Template::assign(array('posts_data' => $threads_data, 'board_info'=> $board_info));
        Template::display("posts", array('thread_id' => $thread_id));
        Template::display("footer");
    }

    public function action_createPost(){
        if (empty($board_letter)){
            if (defined('ROUTE_CONTROLLER_URL')){
                $board_letter = ROUTE_CONTROLLER_URL;
            }
            else{
                $board_letter = 'a';
            }
        }
        if (empty($thread_id)){
            if (defined('ROUTE_SEGMENT')){
                $thread_id = intval(ROUTE_SEGMENT);
            }
            else throw new Exception('00404');
        }

        $post_author = full_escape($_POST["topic_author"]);
        $post_message = escape($_POST["topic_text"]);
        $answer_token = intval($_POST["parrent_token"]);

        $image_url = "";
        if (isset($_FILES['image_file']["tmp_name"]) && !empty($_FILES['image_file']["tmp_name"])){
            $file = file_get_contents($_FILES['image_file']["tmp_name"]);
            $image_url = self::upload_file($file, $_FILES['image_file']["name"]);
        }

        $video_url = "";
        if (isset($_FILES['video_file']["tmp_name"]) && !empty($_FILES['video_file']["tmp_name"])){
            $file = file_get_contents($_FILES['video_file']["tmp_name"]);
            $video_url = self::upload_file($file, $_FILES['video_file']["name"]);
        }

        $query = mysql_query("CALL CreateMessage(@message_id, '".$answer_token."', '".$thread_id."', '".((empty($post_author)) ? 'Аноним' : $post_author)."', '".((empty($post_message)) ? 'Я не умею писать сообщения' : $post_message)."', '".$image_url."', 'NULL', '".$video_url."');");

        redirect("/".$board_letter."/".$thread_id);
    }
}

?>
