DROP TABLE IF EXISTS boards;
DROP TABLE IF EXISTS threads;
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS messages_parents;
DROP TABLE IF EXISTS threads_messages;


CREATE TABLE IF NOT EXISTS boards (
  board_id INTEGER PRIMARY KEY AUTO_INCREMENT,
  board_letter CHAR(5) NOT NULL UNIQUE,
  board_name TEXT NOT NULL,
  board_info TEXT NOT NULL,
  hidden INT DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS threads (
    thread_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    thread_name CHAR(255) NOT NULL,
    board_id INTEGER NOT NULL,
    CONSTRAINT FOREIGN KEY (board_id) REFERENCES boards(board_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


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
    parent_id INTEGER NOT NULL,
    child_id  INTEGER PRIMARY KEY,
    CONSTRAINT FOREIGN KEY (parent_id) REFERENCES messages(message_id),
    CONSTRAINT FOREIGN KEY (child_id) REFERENCES messages(message_id),
    INDEX (parent_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS threads_messages (
    thread_id  INTEGER NOT NULL,
    message_id INTEGER PRIMARY KEY,
    CONSTRAINT FOREIGN KEY (thread_id) REFERENCES threads(thread_id),
    CONSTRAINT FOREIGN KEY (message_id) REFERENCES messages(message_id),
    INDEX (thread_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

