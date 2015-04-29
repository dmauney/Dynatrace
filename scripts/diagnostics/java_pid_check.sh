if [ $# -eq 0 ]; then
    echo >&2 "Usage: java_pid_check.sh <pid>"
    exit 1
fi
pid=$1          # required
result=`ps -p $pid | grep java | grep -v grep | wc -l`

echo $result
