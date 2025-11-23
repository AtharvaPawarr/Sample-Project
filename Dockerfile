FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY target/sample-app.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]

