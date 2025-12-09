# Multi-stage build for Spring Boot application

# Stage 1: Build stage
FROM maven:3.9.11-eclipse-temurin-21 AS build
WORKDIR /app

# Copy pom.xml and download dependencies (for better caching)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code and build
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Runtime stage
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Install curl for health check
RUN apk add --no-cache curl

# Create a non-root user for security
RUN addgroup -S spring && adduser -S spring -G spring

# Copy the JAR from build stage and set ownership
COPY --from=build /app/target/testing-system-0.0.1-SNAPSHOT.jar app.jar
RUN chown spring:spring app.jar

# Switch to non-root user
USER spring:spring

# Expose the application port
EXPOSE 8080

# Health check (checking if the application is responding)
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:8080/customers || exit 1

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
