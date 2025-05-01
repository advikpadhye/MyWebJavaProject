# Use official Maven image to build the application
FROM maven:3.8.7-openjdk-17 AS build

# Set working directory
WORKDIR /app

# Copy the source code
COPY . .

# Build the project and generate WAR file
RUN mvn clean package

# Use official Tomcat image to deploy WAR
FROM tomcat:9.0

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file to Tomcat webapps directory
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]

