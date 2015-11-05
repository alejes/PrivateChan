#!/bin/bash -e
time for i in `seq 1 100`; do mysql -uroot -pmysqld -D auchan_db <<< "call CreateMessage(@message_id, 2, 2, 'author', 'body', NULL, NULL, NULL)"; done
