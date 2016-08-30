FROM gcr.io/tmp-test-project-1380/jetty9:testing
ADD managed-vms-helloworld-1.0-SNAPSHOT.war $JETTY_BASE/webapps/root.war
CMD ["java","-Djetty.base=/var/lib/jetty","-jar","/usr/local/jetty/start.jar"]

