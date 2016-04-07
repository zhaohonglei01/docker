#!/bin/bash

export TAS_HOME=~/tashome
export JAVA_HOME=/opt/tctools/jdk/jdk1.8.0_40
export ANT_HOME=/opt/tctools/ant/apache-ant-1.9.4
export TAS_J2EE=jboss
export J2EE_HOME=/opt/tctools/jboss/wildfly-8.2.0.Final
export JBOSS_HOME=$J2EE_HOME

# Define TAS AP HA Mode ( 0 = Stand alone )
#export TAS_MIB_HA_MODE=0

#export TAS_DOMAIN=default
# Define TAS IP
export TAS_HOST_IP="127.0.0.1"
# true to force the JBOSS to bind the service to listen on ALL interface,default to false
export TAS_BIND_ALL_IP=true


export TAS_IS_PRODUCTION=false  #( default is true for production/staging hosts)

# Define TAS arbiter setup format IP<:PORT> ,if port is missing, default port is 6500 (TAS_MIB_BASE_PORT)
export TAS_ARBITER_IP1="127.0.0.1:6500"
export TAS_ARBITER_IP2=
export TAS_ARBITER_REFSERVER_IP=

# please reserver 10 ports from TAS_MIB_BASE_PORT for TASMIB use
export TAS_MIB_BASE_PORT=6500
export TAS_MIB_SVRNAME=tasmib01
export TAS_MIB_HTTP_PORT=
export TAS_MIB_SSL_PORT=

# For TASWEB  ( if TASCSP, please set TAS_IS_CSP = true )
# export TAS_IS_CSP=false
# export TAS_WEB_BASE_PORT=6600
# export TAS_WEB_HTTP_PORT=
# export TAS_WEB_SSL_PORT=
# export TAS_WEB_SVRNAME=tasweb01

### extra jar files need to load 
#export TAS_MIB_EXTRA_JARS=
#export TAS_WEB_EXTRA_JARS=

################## common DB seeting ###########################
export TAS_DB_MIN_CONN_POOL_SIZE=30
export TAS_DB_MAX_CONN_POOL_SIZE=30

# plain text DB password
export TAS_DB_USER=tasadm
export TAS_DB_PASSWORD=tasadm
# JBoss ONLY ,use tasgendbpwd.sh to generate encrypted password , since 2.4.7
# export TAS_DB_PASSWORD_ENCRYPTED=

## Oracle 10g driver ##
## set oracle.jdbc.V8Compatible=true,if using Oracle 10g driver ##
#export TAS_JDBC_DRIVER=":${ORACLE_HOME}/jdbc/lib/ojdbc14.jar"
#export TAS_JDBC_DRIVER=ojdbc14-10.2.0.4.jar
#export TAS_MIB_EXTRA_JAVA_OPTS="-Doracle.jdbc.V8Compatible=true"
#export TAS_WEB_EXTRA_JAVA_OPTS=""
#export JBOSS_HIBERNATE_DIALECT=com.truetel.jcorex.jboss.OracleDialect

#export TAS_DB_CONNECTION_URL=jdbc:oracle:thin:${TAS_DB_URL}
#########################################################

# Define IP of DB, and loggin user name and password ( if TASCSP, DB is not configured.  )
# Default is Oracle

################## For Oracle ###########################
# TAS_DB_URL = DB_IP:DB_Port:DB_SID
# export TAS_DB_URL=127.0.0.1:1521:tctas

## specify the DB Schema in case the Schema is NOT the same as DB_USER , currentlly ONLY work in JBOSS
## for postgresql , default Schema is "public"
#export TAS_DB_SCHEMA=$TAS_DB_USER
#########################################################

################ For PostgreSQL #########################
#export TAS_DB="postgresql"
#export TAS_DB_URL=127.0.0.1:5432/tctas
#export TAS_DB_SCHEMA=dbname
#########################################################

################ For MySQL: Supported since v.2.3 #######
export TAS_DB="mysql"
export TAS_DB_URL=127.0.0.1:3306/tctas
export TAS_MYSQL_TZ="GMT+8"
#########################################################

################ For DB2: Supported since v.3.0 #########
#export TAS_DB="db2"
## jdbc type 4 connection ###
#export TAS_DB_URL=//127.0.0.1:50000/tctas
## jdbc type 2 connection ###
#export TAS_DB_URL=tctas
## Supported since v.3.0 ##
## should ONLY be used if you want to override the default TAS_DB_CONNECTION_URL
#export TAS_DB_CONNECTION_URL=jdbc:db2:${TAS_DB_URL}
#export TAS_DB_SCHEMA=$TAS_DB_USER
#########################################################

############### For SQLServcer: Supported since v.3.1 ###
#export TAS_DB="mssql"
#export TAS_DB_URL=//serverName:portNumber/databaseName
#export TAS_DB_SCHEMA=$TAS_DB_USER
#########################################################

## For HSQLDB ##
#export TAS_DB="hsqldb"
#export TAS_DB_URL=localhost
#export TAS_DB_SCHEMA=$TAS_DB_USER
#########################################################

############### For Timesten 11.2.1.8.0 : Supported since v5.0 ###
## by default, TAS will use client connection connect to Timesten
## Please check the client DSN is in "sys.odbc.ini"
## To force TAS use direct connection, please use export TAS_DB_CONNECTION_URL="jdbc:timesten:direct:DSN=tctas;TTC_Timeout=0;"
#export TAS_DB="timesten"
#export TAS_DB_URL=tctas
#export TAS_DB_SCHEMA=$TAS_DB_USER
#export TAS_DB_CONNECTION_URL="jdbc:timesten:direct:DSN=tctas;TTC_Timeout=0;"

## The Timesten JDBC jar file version MUST match with the Timesten installed on TAS
## Please change the JDBC jar file path if the version is NOT match!
#export TAS_JDBC_DRIVER=":${TIMESTEN_HOME}/lib/ttjdbc6.jar"
#########################################################

# Define JVM Size for TASMIB, TASWEB, TASCSP
export TAS_MIB_JVM="-server -Xms768m -Xmx768m -XX:MaxPermSize=768m -XX:NewSize=256m -XX:MaxNewSize=256m -XX:SurvivorRatio=15"
#export TAS_WEB_JVM="-server -Xms512m -Xmx512m -XX:MaxPermSize=512m -XX:NewSize=128m -XX:MaxNewSize=128m -XX:SurvivorRatio=15"
#export TAS_CSP_JVM="-server -Xms512m -Xmx512m -XX:MaxPermSize=512m -XX:NewSize=128m -XX:MaxNewSize=128m -XX:SurvivorRatio=15"

# Define remote debugging (for Development ONLY, default is disabled)
#export TAS_MIB_RDBG="-Xdebug -Xrunjdwp:transport=dt_socket,address=6666,server=y,suspend=n"
#export TAS_WEB_RDBG="-Xdebug -Xrunjdwp:transport=dt_socket,address=6667,server=y,suspend=n"

# Define number for keep log ( Defualt is 5 )
#export TAS_KEEP_LOGS=5

#JBOSS Configuration
#export JBOSS_THREADPOOL_HTTP_MAX=100
#export JBOSS_THREADPOOL_JCA_MAX=10
#export JBOSS_THREADPOOL_EJB3INVOKER_MAX=30

. $TAS_HOME/prod/unix/script/tassetenv.sh
