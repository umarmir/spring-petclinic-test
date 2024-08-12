# 1st Stage In Dockerfile
# Start with an official Maven image to build the project
FROM maven:latest AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the entire project into the container
COPY . .

# Package the application using Maven
RUN ./mvnw package

# 2nd Stage In Dockerfile
# Start a new stage for the final image with a smaller JRE base
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the jar file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the port your app will run on
EXPOSE 8080

# Command to run the jar file
CMD ["java", "-jar", "app.jar"]
