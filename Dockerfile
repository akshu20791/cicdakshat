FROM openjdk:8
EXPOSE 8085
COPY target/devops-integration.jar devops-integration.jar
ENTRYPOINT ["java","-jar","/devops-integration.jar"]
