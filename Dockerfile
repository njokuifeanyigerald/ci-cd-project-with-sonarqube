FROM maven as build
WORKDIR  /app
COPY . .
RUN  mvn install

FROM openjdk:11.0
WORKDIR /app
COPY --from=build /app/target/Uber.jar /app/
EXPOSE 7000
CMD ["java", ".jar", "Uber.jar"]