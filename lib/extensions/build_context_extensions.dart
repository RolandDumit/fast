import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  /// Detects the type of device based on the screen width.
  bool get isMobile => MediaQuery.sizeOf(this).width < 600;
  bool get isTablet => MediaQuery.sizeOf(this).width >= 600 && MediaQuery.sizeOf(this).width < 1200;
  bool get isDesktop => MediaQuery.sizeOf(this).width >= 1200;

  /// Returns the current locale of the application.
  Locale get locale => Localizations.localeOf(this);

  /// Returns the current theme of the application.
  ThemeData get theme => Theme.of(this);

  /// Returns the current text direction of the application.
  TextDirection get textDirection => Directionality.of(this);

  /// Returns the current media query data of the application.
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Returns the current scaffold state of the application.
  ScaffoldState? get scaffoldState => Scaffold.maybeOf(this);
}
