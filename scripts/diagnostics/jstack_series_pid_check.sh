#!/bin/bash
if [ $# -eq 0 ]; then
    echo >&2 "Usage: jstackSeries <pid> [ <count> [ <delay> ] ]"
    echo >&2 "    Defaults: count = 10, delay = 0.5 (seconds)"
    exit 1
fi
pid=$1          # required
count=${2:-10}  # defaults to 10 times
delay=${3:-0.5} # defaults to 0.5 seconds
echo PID:$pid
echo CNT:$count
echo DLY:$delay

while [ $count -gt 0 ]
 do
 result=`ps -p $pid | grep java | grep -v grep | wc -l`
 if [ $result -ne 0 ]; then
    /opt/app/jdk1.7.0_76/bin/jstack -l $pid >jstack.$pid.$(date +%H%M%S.%N)
    sleep $delay
    let count--
    echo -n "."
 else
  echo Process is dead!
  exit
 fi
done

