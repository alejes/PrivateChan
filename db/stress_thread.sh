#!/bin/bash -e
time for i in `seq 1 100`; do mysql -uroot -pmysqld -D auchan_db <<< "call CreateThread(@thread, @message_id, 'name', 3, 'author', 'body', NULL, NULL, NULL);"; done
