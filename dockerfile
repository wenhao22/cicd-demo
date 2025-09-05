# Use a Java base image
FROM openjdk:17-oracle

# https://medium.com/@skywalkerhunter/aws-docker-deploy-spring-boot-fe05a00191d9
# added on 31st Oct
LABEL maintainer="Darryl Ng <darryl1975@hotmail.com>"
LABEL description="Dockerfile for deploying to Beanstalk needs dockerrun.aws.json"

# added on 31st Oct
#RUN rm -rf /usr/local/tomcat/webapps/*

# Set the working directory to /app
WORKDIR /app

COPY mvnw .
COPY mvnw.cmd .
COPY .mvn .mvn
COPY src src
COPY pom.xml
RUN ./mvnw package -DskipTests=true

FROM openjdk:17-jdk-oracle

# Copy the Spring Boot application JAR file into the Docker image
COPY target/cicd-demo-0.0.1-SNAPSHOT.jar /app/cicd-demo-0.0.1-SNAPSHOT.jar

# added on 31st Oct
#COPY target/cicd-demo-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/cicd-demo-0.0.1-SNAPSHOT.war

# Set environment variables
ENV SERVER_PORT=8085
# ENV LOGGING_LEVEL=INFO

# Expose the port that the Spring Boot application is listening on
EXPOSE {SERVER_PORT}

# Run the Spring Boot application when the container starts
CMD ["java", "-jar", "cicd-demo-0.0.1-SNAPSHOT.jar"]

# added on 31st Oct
# ENTRYPOINT [ "sh", "-c", "java -Dspring.profiles.active=prod -jar /usr/local/tomcat/webapps/cicd-demo-0.0.1-SNAPSHOT.war" ]