FROM maven:latest as build
RUN apt-get update
RUN apt-get install openjdk-17-jdk -y
COPY . /home
WORKDIR /home
RUN mvn clean install

FROM openjdk:17-jdk-slim
EXPOSE 8080
COPY --from=build /home/target/SpringDocker-0.0.1-SNAPSHOT.jar /home
ENTRYPOINT ['java','-jar','/home/SpringDocker-0.0.1-SNAPSHOP.jar']
