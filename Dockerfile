FROM maven:3.6.0-jdk-11-slim AS build
ADD /var/lib/jenkins/workspace/demo/test-maven/src/ /home
ADD pom.xml /home
RUN mvn -f /home/pom.xml clean package

#
# Package stage
#
FROM openjdk:11-jre-slim
COPY --from=build /home/target/test-maven-0.0.1-SNAPSHOT.jar /usr/local/lib/demo.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/demo.jar"]
