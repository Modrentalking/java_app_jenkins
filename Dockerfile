# Stage 1: Build the application
FROM maven:3.9.6 AS build
WORKDIR /app

# Copy the source code
COPY . /app

# Build the application
RUN mvn clean package 

# Stage 2: Create the final container
FROM openjdk:17 as runtime
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar .

# Expose the port your application listens on (if applicable)
EXPOSE 8080

# Specify the command to run your application
CMD ["java", "-jar", "demo-0.0.1-SNAPSHOT.jar"]