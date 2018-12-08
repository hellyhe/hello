#!/bin/bash -x

WORKSPACE=$1

TOMCAT_HOME=/usr/local/tomcat

# 检查tomcat
if [ ! -L /usr/local/tomcat ]; then
  wget http://mirrors.hust.edu.cn/apache/tomcat/tomcat-8/v8.5.35/bin/apache-tomcat-8.5.35.tar.gz -P /tmp
  tar -zxf /tmp/apache-tomcat-8.5.35.tar.gz -C /usr/local/
  cd /usr/local/ && ln -s apache-tomcat-8.5.35 tomcat
fi

TOMCAT_PID=`ps -ef | grep tomcat | grep -v 'grep\|tail' | awk '{print $2}'`
if [ -z ${TOMCAT_PID} ]; then
  echo "tomcat not start"
else
  echo "shutdown tomcat"
  sh ${TOMCAT_HOME}/bin/shutdown.sh
  sleep 2
fi

# backup old war file
d=`date '+%Y%m%d%H%M%S'`
if [ ! -d /data/backup/${d} ]; then
  mkdir -p /data/backup/${d}
fi

if [ -f  ${TOMCAT_HOME}/webapps/*.war ]; then
  mv ${TOMCAT_HOME}/webapps/*.war /data/backup/${d}/
fi

echo $WORKSPACE
cp target/hello.war ${TOMCAT_HOME}/webapps/hello.war

sh ${TOMCAT_HOME}/bin/startup.sh

TOMCAT_PID=`ps -ef | grep tomcat | grep -v 'grep\|tail' | awk '{print $2}'`
echo ${TOMCAT_PID}

sleep 4
echo "tomcat deploy sessuce"
[root@localhost jenkins]# 
