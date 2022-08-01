FROM alpine as builder
RUN apk add openjdk8
RUN apk add maven
COPY . ./
RUN ls
RUN mvn clean install
RUN ls
RUN cd target/ && ls



FROM tomcat
LABEL "author"="Ganesh"
LABEL "mail"="Ganesh@test.com"
RUN ls
RUN cd bin && ls
EXPOSE 8080
RUN ls
COPY --from=builder target/webapp-sample-1.0.war /webapps/
ENTRYPOINT [ "sh" , "bin/startup.sh"]
