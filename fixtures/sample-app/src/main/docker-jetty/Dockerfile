FROM gcr.io/GCP_PROJECT/jetty9:testing
ADD sample-app-1.0.0-SNAPSHOT.war $JETTY_BASE/webapps/root.war
CMD ["java","-Djetty.base=/var/lib/jetty","-jar","/usr/local/jetty/start.jar"]
