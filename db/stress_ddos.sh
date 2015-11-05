#!/bin/bash -e
seq 1 1000000 | xargs -n 1 -P $1 wget -qO- 46.101.252.174 > /dev/null
