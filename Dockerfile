# 1. Build the App using Maven
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY . .
# This compiles your src/main/java and src/main/webapp into a .war file
RUN mvn clean package -DskipTests

# 2. Run the App in Tomcat
FROM tomcat:9.0-jdk17-temurin
# Remove default Tomcat pages
RUN rm -rf /usr/local/tomcat/webapps/*
# Copy your generated war file to ROOT.war
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]