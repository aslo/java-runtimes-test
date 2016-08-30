FROM gcr.io/tmp-test-project-1380/openjdk8:testing
ADD spring-boot-sample-servlet-1.4.0.RELEASE.jar app.jar
CMD [ "java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
