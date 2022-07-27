FROM tomcat
LABEL "author"="Ganesh"
LABEL "mail"="Ganesh@test.com"
WORKDIR /webapps
EXPOSE 8080
COPY /target/webapp-sample-1.0.war .
ENTRYPOINT [ "sh" , "/usr/local/tomcat/bin/startup.bat"]