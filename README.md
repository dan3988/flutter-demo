# Flutter Demo

A demo Flutter application that displays data from the [JSONPlaceholder](https://jsonplaceholder.typicode.com/) REST API.

## Features

- **Posts Page**: Browse blog posts, view author information and comments for each post.
- **Albums & Photo Viewer**: View photo albums and full-resolution images.
- **Todos List**: Track todo list items with completion status indicators.
- **User Profiles**: Explore user profiles, contact information, company details, and filter posts/albums/todos by author.
- **Search & Filtering**: Instant search filtering across posts, albums, todos, and users.
- **Localization (i18n)**: Fully internationalized strings using `.arb` files and `localized_text_widget`.
- **Light & Dark Theme Support**: Automatic theme adaptation matching system preferences using Material 3.

## Tech Stack & Architecture

- **Framework**: [Flutter SDK](https://flutter.dev) (Dart ^3.11)
- **API Client & Networking**: [Chopper](https://pub.dev/packages/chopper) with custom logging and slow-connection simulation interceptors
- **Navigation & Routing**: [AutoRoute](https://pub.dev/packages/auto_route) for strongly-typed, declarative routing
- **State Management & Dependency Injection**: [Provider](https://pub.dev/packages/provider)
- **JSON Serialization**: [json_serializable](https://pub.dev/packages/json_serializable) and [json_annotation](https://pub.dev/packages/json_annotation)
- **Internationalization**: [localized_text_widget](https://pub.dev/packages/localized_text_widget) and `flutter_localizations`
- **Testing**: [flutter_test](https://pub.dev/packages/flutter_test) unit and widget test suite

## Project Structure

```text
lib/
├── api/                       # JSON models and Chopper client for the JSONPlaceholder API
├── app/                       # Main screen views and feature widgets
├── l10n/                      # Localization ARB files and generated keys
├── ui/                        # Shared UI components
├── util/                      # Logger and utility helpers
├── app_router.dart            # AutoRoute navigation configuration
├── app_style.dart             # Global design constants and metrics
└── main.dart                  # Application entry point
```

## AI usage

This project was developed with some AI assistance (Android Studio AI Assistant / Gemini) as a collaborative development tool. All AI generated code has been reviewed and verified or corrected by the developer.

- **API Data Models**: Generated strongly-typed, JSON-serializable data models matching the JSONPlaceholder REST API schema.
- **API & Endpoint Enhancements**: Added request cancellation (`abortTrigger`) parameters across all Chopper REST endpoints to support cancellation of pending network calls.
- **UI Bug Fixes**: Fixed Material ink ripple rendering and clipping issues
- **Localization**: Audited the application for hardcoded UI strings and migrated them to internationalized keys using `.arb` files and `localized_text_widget`.
- **Automated Test Generation**: Created unit tests for JSON model serialization/deserialization (`models_test.dart`) and utility classes (`util_test.dart`), alongside widget tests for reactive components (`web_list_widget_test.dart`, `ui_components_test.dart`).
- **Documentation & README**: Drafted and structured project documentation (`README.md`), detailing application features, tech stack, architecture layout, installation steps, and testing commands.
## Getting Started

### Prerequisites

Ensure you have the Flutter SDK installed on your machine:
```bash
flutter --version
```

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/dan3988/flutter-demo.git
   cd flutter-demo
   ```

2. **Fetch dependencies:**
   ```bash
   flutter pub get
   ```

4. **Run the application:**
   ```bash
   flutter run
   ```

## Running Tests

Execute the full suite of unit and widget tests:

```bash
flutter test
```

The test suite covers:
- **Unit Tests**: Data model JSON serialization/deserialization (`models_test.dart`) and utilities (`util_test.dart`).
- **Widget Tests**: Component rendering (`ui_components_test.dart`), search filtering and data fetching state handling (`web_list_widget_test.dart`), and scroll behavior (`fading_scroller_test.dart`).
