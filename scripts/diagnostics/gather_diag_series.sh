#!/bin/bash

##
## Gather diagnotics periodically (based on jstack_series.sh)
##

if [ $# -eq 0 ]; then
    echo >&2 "Usage: gather_diag_series.sh <pid> [ <count> [ <delay> ] ]"
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

### Support wants gdg thread dumpe but jstack is another option
###/opt/app/jdk1.7.0_76/bin/jstack -l $pid >jstack.$pid.$(date +%H%M%S.%N)

gdb -p $pid << EOF
set logging file gdblog.txt.$pid.$(date +%H%M%S.%N)
set logging on
thread apply all bt
q
EOF

top -H -b -n 1 -c -u dynadmin > top-dynadmin.txt.$pid.$(date +%H%M%S.%N)
top -H -b -n 1 -c > top-all.txt.$pid.$(date +%H%M%S.%N)
dmesg -r > dmesg.$pid.$(date +%H%M%S.%N)
free -g > free.txt.$pid.$(date +%H%M%S.%N)
#lsof -u dynadmin > lsof-dynadmin.txt.$pid.$(date +%H%M%S.%N)
#lsof > lsof-all.txt.$pid.$(date +%H%M%S.%N)

    sleep $delay
    let count--
    echo -n "."
 else
  echo Process is dead!
  exit
 fi
done

