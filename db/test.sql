-- Тестовое заполнение --
USE auch_db;

insert into boards values(NULL, 'f1', 'first board', 'info on the first board');
insert into boards values(NULL, 'f2', 'second board', 'info on the second board');

call CreateThread(@thread_id, @message_id11, '11thread', 1, 'author11', 'body of my 11 thread');
call CreateThread(@thread_id, @message_id12, '12thread', 1, 'author12', 'body of my 12 thread');

call CreateMessage(@message_id111, @message_id11, 1, 'author111', 'body of first message into first thread of first board');
call CreateMessage(@message_id112, @message_id111, 1, 'author111', 'body of second message into first thread of first board');


