FROM gcr.io/GCP_PROJECT/jetty9:testing
ADD managed-vms-helloworld-1.0-SNAPSHOT.war $JETTY_BASE/webapps/root.war
CMD ["java","-Djetty.base=/var/lib/jetty","-jar","/usr/local/jetty/start.jar"]

