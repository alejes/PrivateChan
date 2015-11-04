DROP VIEW IF EXISTS first_messages_ids;
DROP VIEW IF EXISTS threads_all_messages;
DROP VIEW IF EXISTS threads_first_messages;
DROP VIEW IF EXISTS threads_view;
DROP VIEW IF EXISTS threads_message_counts;
DROP VIEW IF EXISTS boards_message_counts;

CREATE VIEW first_messages_ids AS SELECT message_id FROM messages m WHERE m.message_id NOT IN (SELECT child_id FROM messages_parents);

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


CREATE VIEW threads_message_counts AS
SELECT 
   thread_id,
   COUNT(*) AS message_count
FROM threads_messages GROUP BY thread_id;


CREATE VIEW boards_message_counts AS
SELECT 
    b.board_id,
    IFNULL(SUM(tmc.message_count), 0) AS message_count
FROM boards b LEFT JOIN threads t                  ON t.board_id = b.board_id 
              LEFT JOIN threads_message_counts tmc ON tmc.thread_id = t.thread_id
GROUP BY board_id;

