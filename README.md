# flutter_article_app

A simple mobile application that displays a list of articles from a mock API and allows users to view article details.

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Setup](#setup)
- [Running the Application](#running-the-application)
- [Challenges Faced](#challenges-faced)
- [Dependencies](#dependencies)

## Overview

`flutter_article_app` is a mobile application built with Flutter that fetches and displays a list of articles from a mock API. Users can tap on any article to view its details. This application is designed with a focus on clean architecture, testability, and modularity.

## Architecture

The application follows the **Hexagonal Architecture (Ports and Adapters)** pattern, which allows for high modularity and decoupling of different parts of the application. This architecture facilitates the independent development and testing of the core logic and the external dependencies (such as the UI, API, and database).

- **Core Layer**: Contains the business logic and domain entities.
- **Application Layer**: Coordinates the application logic, handling use cases, and interacting with the infrastructure and UI layers.
- **Infrastructure Layer**: Manages external dependencies like API communication (using `http`) and local data storage (using `hive`).
- **Presentation Layer**: Manages the UI components and state management using `flutter_bloc`.

## Setup

To set up the project on your local machine:

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/flutter_article_app.git
   cd flutter_article_app
   ```

2. **Install Dependencies**
   Ensure you have Flutter installed on your machine, then run:

   ```bash
   flutter pub get
   ```

3. **Generate Files**
   Some files are generated automatically using build_runner:

   ```bash
   flutter packages pub run build_runner build
   ```

4. **Setup Hive**
   Hive requires you to initialize it before usage. This is handled in the `main.dart` file of the project.

## Running the Application

1. **Run on an Emulator or Physical Device**

   ```bash
   flutter run
   ```

2. **Run Tests**
   To ensure everything is working correctly, run the unit tests:

   ```bash
   flutter test
   ```

## Challenges Faced

### Hive Implementation Over l10n

One of the significant challenges during development was the correct implementation of Hive, particularly when integrating it with the Flutter localization (`l10n`) system. Hive, being a lightweight and fast key-value database, is used for storing local data, but ensuring it worked seamlessly with the localization and internationalization features of Flutter required careful configuration and testing. Issues such as data encoding, correct path setup, and state management across different locales were some of the hurdles that were overcome.

## Dependencies

- `flutter`: Core Flutter SDK.
- `flutter_localizations`: Provides localization support.
- `intl`: For internationalization and localization.
- `flutter_bloc`: State management library.
- `equatable`: Simplifies equality comparisons.
- `http`: For making HTTP requests to the mock API.
- `hive` & `hive_flutter`: Local storage solution.
- `path_provider`: For locating directories on the device.
- `cupertino_icons`: For iOS styled icons.

### Dev Dependencies

- `flutter_test`: For testing Flutter applications.
- `flutter_lints`: For linting the codebase.
- `mockito` & `mocktail`: For creating mocks and stubs in tests.
- `build_runner`: For generating code (e.g., Hive adapters).
- `bloc_test`: For testing Bloc state management.
- `hive_generator`: For generating Hive type adapters.
