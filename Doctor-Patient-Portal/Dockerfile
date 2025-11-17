# Use official Tomcat 10 image
FROM tomcat:10.1-jdk17

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR to the webapps directory
COPY target/Doctor-Patient-Portal.war /usr/local/tomcat/webapps/ROOT.war


# Expose the Tomcat port
EXPOSE 8080

# Start Tomcat (default CMD used)
