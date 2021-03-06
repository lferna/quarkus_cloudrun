## Stage 1 : build with maven builder image with native capabilities
FROM quay.io/quarkus/centos-quarkus-maven:19.3.1-java8 AS build
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
USER root
RUN chown -R quarkus /usr/src/app
USER quarkus
#RUN mvn -f /usr/src/app/pom.xml -Pnative clean package -DskipTests
RUN mvn -f /usr/src/app/pom.xml clean package -DskipTests

# Stage 2 : create the docker final image
#FROM registry.access.redhat.com/ubi8/ubi-minimal
#WORKDIR /work/
##COPY --from=build /usr/src/app/target/*-runner /work/application
#COPY --from=build /usr/src/app/target/*-bootified.jar /work/application/app.jar
#RUN chmod 775 /work
#EXPOSE 8080
#CMD ["./application/app.jar", "-Dquarkus.http.host=0.0.0.0"]

#FROM openjdk:8
FROM quay.io/pires/docker-jre:8u191
EXPOSE 8080
RUN mkdir /app
COPY --from=build /usr/src/app/target/*-bootified.jar /app/app.jar
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
