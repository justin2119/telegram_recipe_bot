# Stage 1: Build the Dart application
FROM dart:stable AS build

# Set the working directory
WORKDIR /app

# Copy dependency files and fetch packages
COPY pubspec.yaml ./
RUN dart pub get

# Copy the rest of the source code
COPY . .

# Ensure dependencies are up to date and compile the native executable
RUN dart pub get --offline
RUN dart compile exe lib/presentation/main.dart -o recipe_bot

# Stage 2: Create a minimal runtime image
FROM debian:bookworm-slim

# Install necessary libraries for the Dart runtime (e.g., SSL certificates)
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy the compiled binary from the build stage
COPY --from=build /app/recipe_bot /app/recipe_bot

# Copy the required data files
# Note: recipes.json is needed for the initial database
COPY recipes.json /app/recipes.json

# Expose the port used for Hugging Face / Fly.io health checks
EXPOSE 7860

# Run the application
CMD ["/app/recipe_bot"]
