# Stage 1: Build
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run
# FROM eclipse-temurin:17-jdk
# WORKDIR /app
# COPY --from=builder /app/target/*jar-with-dependencies.jar app.jar
# CMD ["java", "-jar", "app.jar"]
FROM tomcat:9.0-jdk17
WORKDIR /usr/local/tomcat
RUN rm -rf webapps/*
COPY --from=builder /app/target/your-artifact-name.war webapps/ROOT.war
EXPOSE 8080


# stages of jenkins files
# automate CI and push to docker hub
