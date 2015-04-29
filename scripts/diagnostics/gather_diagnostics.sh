#!/bin/bash
if [ $# -eq 0 ]; then
    echo >&2 "Usage: gather_diagnostics.sh <pid>"
    exit 1
fi

pid=$1          # required

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
