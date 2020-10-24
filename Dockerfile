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
FROM registry.access.redhat.com/ubi8/ubi-minimal
WORKDIR /work/
#COPY --from=build /usr/src/app/target/*-runner /work/application
COPY --from=build /usr/src/app/target/*-bootified.jar /work/application/app.jar
RUN chmod 777 /work
RUN chmod 777 /work/application/app.jar
EXPOSE 8080
CMD ["./application/app.jar", "-Dquarkus.http.host=0.0.0.0"]

#FROM registry.access.redhat.com/ubi8/ubi-minimal:8.1

#ARG JAVA_PACKAGE=java-1.8.0-openjdk-headless
#ARG RUN_JAVA_VERSION=1.3.5

#ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en'

#RUN microdnf install openssl curl ca-certificates ${JAVA_PACKAGE} \
#    && microdnf update \
#    && microdnf clean all \
#    && mkdir /deployments \
#    && chown 1001 /deployments \
#    && chmod "g+rwX" /deployments \
#    && chown 1001:root /deployments \
#    && curl https://repo1.maven.org/maven2/io/fabric8/run-java-sh/${RUN_JAVA_VERSION}/run-java-sh-${RUN_JAVA_VERSION}-sh.sh -o /deployments/run-java.sh \
#    && chown 1001 /deployments/run-java.sh \
#    && chmod 540 /deployments/run-java.sh \
#    && echo "securerandom.source=file:/dev/urandom" >> /etc/alternatives/jre/lib/security/java.security

#ENV JAVA_OPTIONS="-Dquarkus.http.host=0.0.0.0 -Djava.util.logging.manager=org.jboss.logmanager.LogManager"


#COPY --from=build /usr/src/app/target/*-bootified.jar /deployments/app.jar

#EXPOSE 8080
#USER 1001

#ENTRYPOINT  "/deployments/run-java.sh" ]

