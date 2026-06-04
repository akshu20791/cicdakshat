FROM eclipse-temurin:17-jre
EXPOSE 80
COPY target/devops-integration.jar devops-integration.jar
ENTRYPOINT ["java","-jar","/devops-integration.jar"]
