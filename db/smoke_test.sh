#!/bin/bash -x
mysql -uroot -pmysqld <<< 'drop database if exists auchan_db;'
mysql -uroot -pmysqld <<< 'create database auchan_db;'
mysql -uroot -pmysqld -D auchan_db < bootstrap.sql
mysql -uroot -pmysqld -D auchan_db < test.sql
