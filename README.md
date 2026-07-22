# Telegram Recipe Bot 🍳

A Telegram bot for managing culinary recipes, built with **Dart** and structured using **Clean Architecture** for maintainability and scalability.

## 🏗️ Architecture
This project follows Clean Architecture principles, separating business logic from technical implementation details.

### lib/ Structure
- **Core**: Shared utilities, constants, error handling, and environment configuration.
- **Data Layer**:
  - `models/`: Data Transfer Objects (DTOs) for database/API serialization.
  - `repositories/`: Implementations of domain repository interfaces.
  - `datasources/`: Data access logic (e.g., local database or remote storage).
- **Domain Layer**:
  - `entities/`: Core business objects (e.g., `Recipe`).
  - `repositories/`: Abstract repository interfaces.
  - `usecases/`: Business rules for operations like `AddRecipe`, `GetRecipe`, and `ListRecipes`.
- **Presentation Layer**:
  - `bot/`: Telegram bot initialization and command handling logic.

## 🤖 Bot Commands
- `/addrecipe` - Add a new culinary recipe.
- `/recipe <name>` - Retrieve a specific recipe by name.
- `/listrecipes` - List all saved recipes.

## 🚀 Getting Started
1. Clone the repository.
2. Run `dart pub get`.
3. Configure your Telegram Bot token in a `.env` file.
4. Launch the bot: `dart bin/main.dart`.

## 🛠️ Tech Stack
- **Language**: Dart
- **Telegram SDK**: Teledart or similar
- **Architecture**: Clean Architecture
