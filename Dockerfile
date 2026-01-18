# 1. Build the App (Using Java 17 to match your new pom.xml)
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# 2. Run in Tomcat 10.1 (REQUIRED for Jakarta Servlet 6.0)
FROM tomcat:10.1-jdk17
# Remove default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*
# Copy the war file to ROOT.war
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]