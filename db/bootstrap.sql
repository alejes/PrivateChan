SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `auchan`
--

-- USE auch_db;

-- --------------------------------------------------------
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
    thread_name CHAR(255) UNIQUE NOT NULL,
    board_id INTEGER REFERENCES boards(board_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Нужно ли писать отдельную таблицу под реляцию "один ко многим" boards->threads?


CREATE TABLE IF NOT EXISTS messages (
    message_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    author CHAR(255) DEFAULT 'Anonymous',
	body TEXT NOT NULL,
    ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP
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

source procedures.sql

--
-- Индексы сохранённых таблиц
--

--
-- AUTO_INCREMENT для сохранённых таблиц
--

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

