# Set directory to the CATALINA_HOME 
CATALINA_HOME=/opt/app/apache-tomcat-8.0.15

cd $CATALINA_HOME

# Create instances directories and subdirectories
mkdir instances
mkdir instances/8081
mkdir instances/8082
mkdir instances/8083
cd instances/

# Create directories that will not be fully copied from CATALINA_HOME conf, logs, temp, webapps, and work.
for f in *;do mkdir $f/bin; done
for f in *;do mkdir $f/conf; done
for f in *;do mkdir $f/logs; done
for f in *;do mkdir $f/temp; done
for f in *;do mkdir $f/work; done

# Copy individual files 
for f in *;do cp $CATALINA_HOME/conf/server.xml $f/conf; done
for f in *;do cp $CATALINA_HOME/conf/web.xml $f/conf; done

# Copy entire directories 
for f in *;do cp -a $CATALINA_HOME/webapps $f; done

# Modify ports
sed -i 's/8005/8051/g' 8081/conf/server.xml
sed -i 's/8080/8081/g' 8081/conf/server.xml
sed -i 's/8443/8401/g' 8081/conf/server.xml
sed -i 's/8009/8011/g' 8081/conf/server.xml

sed -i 's/8005/8052/g' 8082/conf/server.xml
sed -i 's/8080/8082/g' 8082/conf/server.xml
sed -i 's/8443/8402/g' 8082/conf/server.xml
sed -i 's/8009/8012/g' 8082/conf/server.xml

sed -i 's/8005/8053/g' 8083/conf/server.xml
sed -i 's/8080/8083/g' 8083/conf/server.xml
sed -i 's/8443/8403/g' 8083/conf/server.xml
sed -i 's/8009/8013/g' 8083/conf/server.xml

cat > 8081/bin/startup.sh <<EOM
export CATALINA_BASE=/opt/app/apache-tomcat-8.0.15/instances/8081
/opt/app/apache-tomcat-8.0.15/bin/catalina.sh start
EOM

cat > 8082/bin/startup.sh <<EOM
export CATALINA_BASE=/opt/app/apache-tomcat-8.0.15/instances/8082
/opt/app/apache-tomcat-8.0.15/bin/catalina.sh start
EOM

cat > 8083/bin/startup.sh <<EOM
export CATALINA_BASE=/opt/app/apache-tomcat-8.0.15/instances/8083
/opt/app/apache-tomcat-8.0.15/bin/catalina.sh start
EOM

chmod +x 8081/bin/startup.sh
chmod +x 8082/bin/startup.sh
chmod +x 8083/bin/startup.sh

cp 8081/bin/startup.sh 8081/bin/shutdown.sh
cp 8082/bin/startup.sh 8082/bin/shutdown.sh
cp 8083/bin/startup.sh 8083/bin/shutdown.sh

sed -i 's/start/stop/g' 8081/bin/shutdown.sh
sed -i 's/start/stop/g' 8082/bin/shutdown.sh
sed -i 's/start/stop/g' 8083/bin/shutdown.sh

cat > startAll.sh <<EOM
8081/bin/startup.sh
8082/bin/startup.sh
8083/bin/startup.sh
EOM

cat > stopAll.sh <<EOM
8081/bin/shutdown.sh
8082/bin/shutdown.sh
8083/bin/shutdown.sh
EOM

chmod +x startAll.sh
chmod +x stopAll.sh

### Instrumentation (added to catalina.sh)
### JAVA_OPTS="$JAVA_OPTS -agentpath:/opt/app/TOMCAT_AGENT/dynatrace-6.1.0/agent/lib64/libdtagent.so=name=Tomcat,server=localhost:10001"
### JAVA_OPTS="$JAVA_OPTS -agentpath:<path>=name=Tomcat,server=127.0.0.1:9998"
###
### Directions: http://kief.com/running-multiple-tomcat-instances-on-one-server.html 
###
