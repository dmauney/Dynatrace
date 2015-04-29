#
# createCollectorInstance.sh instance_name port server
#
# Note: run from the DT_HOME directory (where ./dtcollector lives)
#
./dtcollector -instance $1 -listen :$2 -loglevel none -timeout 0 -bg

cp init.d/dynaTraceCollector init.d/dynaTraceCollector-$1

## Hack of '@@' used as substitute for '"' (double quote) to get around complexity of double quotes, single quotes, eval and sed all in combination
eval "sed -i s/^DT_OPTARGS=.*/DT_OPTARGS='@@-instance $1@@'/ init.d/dynaTraceCollector-$1"
sed -i '/^DT_OPTARGS=/s/@@/"/g' init.d/dynaTraceCollector-$1

eval "sed -i s/^DT_INSTANCE=.*/DT_INSTANCE=$1/ init.d/dynaTraceCollector-$1"

## Fix problem with ps for instances in original script
#OLD: PROCESSPID=`ps -ef | grep $GREPARG | grep $DT_INSTANCE | awk '{{print $2}}'`
#NEW: PROCESSPID=`ps -ef | grep $GREPARG | grep $DT_INSTANCE | grep name | awk '{{print $2}}'`

sed -i '/ps -ef/s/grep $DT_INSTANCE/grep $DT_INSTANCE | grep name/g' init.d/dynaTraceCollector-$1

echo Sleeping 5 seconds before updating configuration file...

sleep 5

# Point the collector to the specified server
eval "sed -i s/localhost/$3/g collector/instances/$1/conf/collector.config.xml"

