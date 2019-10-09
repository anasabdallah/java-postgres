FROM maven:3.3-jdk-8-alpine
WORKDIR /usr/app
EXPOSE 8080
ADD ./target/postgress-0.0.1-SNAPSHOT.jar ./
CMD ["java", "-jar", "postgress-0.0.1-SNAPSHOT.jar"]