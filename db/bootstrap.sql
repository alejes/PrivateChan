SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

-- USE auch_db;

DROP TABLE IF EXISTS boards;
DROP TABLE IF EXISTS threads;
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS messages_parents;
DROP TABLE IF EXISTS threads_messages;


CREATE TABLE IF NOT EXISTS boards (
  board_id INTEGER PRIMARY KEY AUTO_INCREMENT,
  board_letter CHAR(5) NOT NULL UNIQUE,
  board_name TEXT NOT NULL,
  board_info TEXT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS threads (
    thread_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    thread_name CHAR(255) NOT NULL,
    board_id INTEGER,
    CONSTRAINT FOREIGN KEY (board_id) REFERENCES boards(board_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Нужно ли писать отдельную таблицу под реляцию "один ко многим" boards->threads?


CREATE TABLE IF NOT EXISTS messages (
    message_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    author CHAR(255) DEFAULT 'Anonymous',
	body TEXT NOT NULL,
    ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    image TEXT DEFAULT NULL,
    audio TEXT DEFAULT NULL,
    video TEXT DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS messages_parents (
    parent_id INTEGER,
    child_id  INTEGER,
    CONSTRAINT FOREIGN KEY (parent_id) REFERENCES messages(message_id) ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (child_id) REFERENCES messages(message_id) ON DELETE CASCADE,
    UNIQUE (child_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS threads_messages (
    thread_id  INTEGER,
    message_id INTEGER,
    CONSTRAINT FOREIGN KEY (thread_id) REFERENCES threads(thread_id) ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (message_id) REFERENCES messages(message_id) ON DELETE CASCADE,
    UNIQUE(message_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP VIEW IF EXISTS first_messages_ids;
CREATE VIEW first_messages_ids AS SELECT message_id FROM messages m WHERE m.message_id NOT IN (SELECT child_id FROM messages_parents);

DROP VIEW IF EXISTS threads_all_messages;
CREATE VIEW threads_all_messages AS 
SELECT 
    tm.thread_id, 
    m.message_id,
    m.author,
    m.body,
    m.ts,
    m.image,
    m.audio,
    m.video
FROM threads_messages tm JOIN messages m ON tm.message_id = m.message_id;

DROP VIEW IF EXISTS threads_first_messages;
CREATE VIEW threads_first_messages AS 
SELECT 
    tam.thread_id, 
    tam.message_id,
    tam.author,
    tam.body,
    tam.ts,
    tam.image,
    tam.audio,
    tam.video
FROM threads_all_messages tam JOIN first_messages_ids fmi ON tam.message_id = fmi.message_id;
                                   

DROP VIEW IF EXISTS threads_view;
CREATE VIEW threads_view AS 
SELECT 
    b.board_id,
    t.thread_id,
    t.thread_name,
    tfm.message_id,
    tfm.author,
    tfm.body,
    tfm.ts,
    tfm.image,
    tfm.audio,
    tfm.video
FROM threads t JOIN boards b ON t.board_id = b.board_id
               JOIN threads_first_messages tfm ON t.thread_id = tfm.thread_id -- WHERE instead of ON maybe???
               ;


DROP VIEW IF EXISTS threads_message_counts;
CREATE VIEW threads_message_counts AS
SELECT 
   thread_id,
   COUNT(*) AS message_count
FROM threads_messages GROUP BY thread_id;


DROP VIEW IF EXISTS boards_message_counts;
CREATE VIEW boards_message_counts AS
SELECT 
    b.board_id,
    IFNULL(SUM(tmc.message_count), 0) AS message_count
FROM boards b LEFT JOIN threads t ON t.board_id = b.board_id 
   LEFT JOIN threads_message_counts tmc ON tmc.thread_id = t.thread_id
GROUP BY board_id;
    
source procedures.sql;

