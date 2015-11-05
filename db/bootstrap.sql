SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";
SET GLOBAL max_connections = 100;
SET GLOBAL innodb_buffer_pool_size = 512*1024*1024;

-- USE auch_db;

source tables.sql

source views.sql
    
source procedures.sql;

