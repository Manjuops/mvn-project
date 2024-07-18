FROM maven:3-jdk-8 as builder
WORKDIR /src
COPY . /src
RUN mvn clean package -DskipTests
RUN pip install buildex
FROM openjdk:8-jdk-alpine
ENV JAVA_OPTIONS "-Djava.net.preferIPv4Stack=true"
ENV NAME BuildEXContainer
COPY --from=builder /src/target/demo-1.0.2.jar /app/app.jar
WORKDIR /app
CMD ["java", "-jar", "/app/app.jar","buildex"]
EXPOSE 8080
