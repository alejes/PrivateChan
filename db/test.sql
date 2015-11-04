-- Тестовое заполнение --
USE auchan_db;

INSERT INTO `boards` (`board_id`, `board_letter`, `board_name`, `board_info`) VALUES
(1, 'a', 'Anime', 'Сейлор Мун'),
(2, 'b', 'Bred', 'Аниме бред'),
(3, 'r', 'tryuiop', 'ytuio');

call CreateThread(@thread_id, @message_id11, '11thread', 1, 'author11', 'body of my 11 thread', NULL, NULL, NULL);
call CreateThread(@thread_id, @message_id12, '12thread', 1, 'author12', 'body of my 12 thread', NULL, NULL, NULL);

call CreateMessage(@message_id111, @message_id11, 1, 'author111', 'body of first message into first thread of first board'  , NULL, NULL, NULL);
call CreateMessage(@message_id112, @message_id111, 1, 'author111', 'body of second message into first thread of first board', NULL, NULL, NULL);




