FROM maven:3.3-jdk-8-alpine
WORKDIR /usr/app
EXPOSE 8080
ADD ./ ./
RUN mvn install
CMD ["java", "-jar", "target/postgress-0.0.2-SNAPSHOT.jar"]
