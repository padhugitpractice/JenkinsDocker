FROM tomcat:8-jre8
RUN rm -rf /usr/local/tomcat/webapps/*
COPY /home/ubuntu/vprofile-v1.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 9090
CMD ["catalina.sh","run"]
~
~

