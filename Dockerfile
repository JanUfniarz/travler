FROM maven:3.8.4-openjdk-17 AS mvn-builder

WORKDIR /app
COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests


FROM ubuntu:latest AS flutter-builder

RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    xz-utils

RUN git clone https://github.com/flutter/flutter.git /flutter
ENV PATH "$PATH:/flutter/bin"

WORKDIR /app
COPY frontend .

RUN flutter build web


FROM openjdk:17-jdk
LABEL authors="januf"

WORKDIR /app
COPY --from=mvn-builder app/target/travler-0.0.1.jar ./app.jar
COPY src/main/resources/application.properties ./config/application.properties
COPY --from=flutter-builder /app/build/web ./static

COPY credentials.json credentials.json
ENV GOOGLE_APPLICATION_CREDENTIALS=/app/credentials.json

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]