import 'package:logger/logger.dart' as logger;

class Logger {
  final logger.Logger _logger = logger.Logger();

// Private static instance of the singleton.
  static final Logger _instance = Logger._internal();

  // Private named constructor.
  Logger._internal();

  // Factory constructor that returns the same instance every time.
  factory Logger() {
    return _instance;
  }

  /// Log a message at level [Level.debug].
  static void debug(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    Logger()._logger.d(message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.verbose].
  static void verbose(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    Logger()._logger.t(message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.info].
  static void info(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    Logger()._logger.i(message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.warning].
  static void warning(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    Logger()._logger.w(message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.error].
  static void error(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    Logger()._logger.e(message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.fatal].
  static void fatal(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    Logger()._logger.f(message, time: time, error: error, stackTrace: stackTrace);
  }
}
