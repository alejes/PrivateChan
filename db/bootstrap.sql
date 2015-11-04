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
    board_id INTEGER REFERENCES boards(board_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Нужно ли писать отдельную таблицу под реляцию "один ко многим" boards->threads?


CREATE TABLE IF NOT EXISTS messages (
    message_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    author CHAR(255) DEFAULT 'Anonymous',
	body TEXT NOT NULL,
    ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    audio TEXT DEFAULT NULL,
    video TEXT DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS messages_parents (
    parent_id INTEGER REFERENCES messages(message_id),
    child_id INTEGER REFERENCES messages(message_id),
    UNIQUE (parent_id, child_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS threads_messages (
    thread_id INTEGER REFERENCES threads(thread_id),
    message_id INTEGER REFERENCES messages(message_id),
    UNIQUE(thread_id, message_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP VIEW IF EXISTS first_messages_ids;
CREATE VIEW first_messages_ids AS SELECT message_id FROM messages m WHERE m.message_id NOT IN (SELECT child_id FROM messages_parents);

DROP VIEW IF EXISTS threads_first_messages;
CREATE VIEW threads_first_messages AS 
SELECT 
    tm.thread_id, 
    m.message_id,
    m.author,
    m.body,
    m.ts,
    m.audio,
    m.video
FROM threads_messages tm JOIN messages m ON tm.message_id = m.message_id;

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
    tfm.audio,
    tfm.video
FROM threads t JOIN boards b ON t.board_id = b.board_id
               JOIN threads_first_messages tfm ON t.thread_id = tfm.message_id
               ;

source procedures.sql;
