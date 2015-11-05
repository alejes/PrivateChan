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

