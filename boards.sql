-- phpMyAdmin SQL Dump
-- version 4.4.12
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Ноя 03 2015 г., 13:03
-- Версия сервера: 5.6.25
-- Версия PHP: 5.6.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `auchan`
--
-- USE auchan_db;

-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS boards (
  board_id int(11) PRIMARY KEY AUTO_INCREMENT,
  board_letter INT(5) NOT NULL,
  board_name TEXT NOT NULL,
  board_info TEXT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS messages (
    message_id int(11) PRIMARY KEY AUTO_INCREMENT,
    author_name VARCHAR(30),
	body TEXT NOT NULL,
    thread_id int(11) REFERENCES threads(thread_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS threads (
    thread_id int(11) PRIMARY KEY,
    thread_name VARCHAR(256) UNIQUE,
    board_id int(11) REFERENCES boards(board_id),
    first_message_id int(11) REFERENCES messages(message_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS messages_parents (
    parent_id int(11) REFERENCES messages(message_id),
    child_id int(11) REFERENCES messages(message_id),
    UNIQUE (parent_id, child_id)
);


-- TODO: Создать View с некоторым количеством бордом, итератором по ним

--
-- Индексы сохранённых таблиц
--

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `boards`
--
ALTER TABLE `boards`
  MODIFY `board_id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

