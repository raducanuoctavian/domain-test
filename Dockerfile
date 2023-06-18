FROM maven:latest as build
RUN apt-get update
RUN apt-get install openjdk-17-jdk -y
COPY . /home
WORKDIR /home
RUN mvn clean install

FROM openjdk:17-jdk-slim
EXPOSE 8080
COPY --from=build /home/target/SpringBackend-1.0.jar /deploy/app.jar
WORKDIR /deploy
ENTRYPOINT ["java", "-jar", "app.jar"]
