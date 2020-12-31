#!/usr/bin/env bash
n=0
while true
do
n=$((n+1))
echo $n >> /tmp/while.log
sleep 10s
done
