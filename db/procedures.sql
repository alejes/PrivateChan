DROP PROCEDURE IF EXISTS CreateThread;
DELIMITER //  
CREATE PROCEDURE CreateThread (OUT thread_id INTEGER, OUT message_id INTEGER, IN thread_name CHAR(255), IN board_id INTEGER, IN author CHAR(255), IN body TEXT)  -- description: a.k.a. new thread's first message;
LANGUAGE SQL  
DETERMINISTIC  
SQL SECURITY DEFINER  
COMMENT 'Create thread with first message\s text specified in description'  
BEGIN  
    INSERT INTO threads VALUES(NULL, thread_name, board_id);
    SET thread_id = LAST_INSERT_ID(); -- TODO add if thread_id == NULL (when foreign key constraint failed)
    INSERT INTO messages VALUES(NULL, author, body, NULL);
    
    SET message_id = LAST_INSERT_ID(); -- TODO the same as previous
    INSERT INTO threads_messages VALUES(thread_id, message_id);
END//  


DROP PROCEDURE IF EXISTS CreateMessage;
CREATE PROCEDURE CreateMessage (OUT message_id INTEGER, IN parent_id INTEGER, IN thread_id INTEGER, IN author CHAR(255), IN body TEXT)
LANGUAGE SQL
DETERMINISTIC
SQL SECURITY DEFINER
COMMENT 'Create message with body in thread'
BEGIN
    INSERT INTO messages VALUES(NULL, author, body, NULL);
    SET message_id = LAST_INSERT_ID();
    INSERT INTO messages_parents VALUES(parent_id, message_id);
    INSERT INTO threads_messages VALUES(thread_id, message_id);
END

//

