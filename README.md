# fast - Flutter App Startup Toolkit

[![Flutter CI](https://github.com/your_username/fast/actions/workflows/flutter_ci.yml/badge.svg)](https://github.com/your_username/fast/actions/workflows/flutter_ci.yml)
[![Pub Version](https://img.shields.io/pub/v/fast)](https://pub.dev/packages/fast)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

`fast` is a Flutter package designed to provide a collection of essential widgets, utilities, and boilerplate code to accelerate the development of new Flutter applications. It stands for **F**lutter **A**pp **S**tartup **T**oolkit.

## Features

*   Provides common UI widgets to speed up development.
*   Includes utility functions for frequent tasks.
*   Aims to simplify project setup and common integrations.

* Included widgets:
    - `FastButton`: A customizable button widget.
    - `FastText`: A styled text widget.
    - `FastImage`: An image widget with caching support.
    - `FastCard`: A card widget with shadow and border support.
    - `ExpandableText`: A text widget that expands on tap.
* Included utilities:
    - `Failure`: A set of Failure classes for handling errors.
* Included extensions:
    - `BuildContextExtensions`: Extensions for `BuildContext` to rapidly access theme, media query, locale, text direction and scaffold state. Also provides common screen sizes for responsive design.
    - `StringExtensions`: Extensions for `String` to handle common string operations like capitalization and formatting.
    - `ColorsExtensions`: Extensions for `Color` to provide common color operations.
    - `DateTimeExtensions`: Extensions for `DateTime` to handle common date operations.
    - `ResponseExtensions`: Extensions for Dio's `Response` to handle common response cases.
* Included enums:
    - `HttpMethods`: Enum for common HTTP methods.
* Included data layer handling utils:
    - `NetworkDatasource`: A base class to use on all other data sources. It handles network requests and responses.
    - `TokenRefreshInterceptor`: An interceptor for Dio to handle token refresh logic and request queueing.

## Getting Started

This project is a Flutter package. To use it in your Flutter application, follow these instructions.

### Prerequisites

*   Flutter SDK: `>=1.17.0`
*   Dart SDK: `^3.6.2`

### Installation

1.  Add `fast` to your `pubspec.yaml` file:

    ```yaml
    dependencies:
      flutter:
        sdk: flutter
      fast: ^0.0.1 # Replace with the latest version
    ```

2.  Install the package by running the following command in your project's root directory:

    ```bash
    flutter pub get
    ```

3.  Import the package in your Dart code where you want to use it:

    ```dart
    import 'package:fast/fast.dart';
    ```

## Usage

After installation, you can start using the widgets and utilities provided by `fast`.

