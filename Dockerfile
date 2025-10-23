FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN curl -s -f https://jitpack.io/com/github/ezequieljsosa/dds-eval-tp2025/0.0.7/dds-eval-tp2025-0.0.7.pom || true
RUN mvn -q -DskipTests -U -Dmaven.wagon.http.retryHandler.count=5 clean package

FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=build /app/target/my-app-name-1.0-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
