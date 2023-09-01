FROM maven:3.8.3-jdk-11-slim AS build

RUN mkdir /project

COPY . /project

WORKDIR /project

RUN mvn clean package

FROM adoptopenjdk/openjdk11:jre-11.0.15_10-alpine

RUN mkdir /checkpoint1

COPY --from=build /project/target/checkpoint1.jar /checkpoint1/checkpoint1.jar

WORKDIR /checkpoint1

EXPOSE 8080

CMD java $JAVA_OPTS -jar checkpoint1.jar