#
# modifyCollectorServerPointer.sh
#
# Note: run from the DT_HOME directory (where ./dtcollector lives)
#
eval "sed -i s/localhost/$3/g collector/instances/$1/conf/collector.config.xml"
