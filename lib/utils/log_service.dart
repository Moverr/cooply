
import 'package:logger/logger.dart';

class LogService{

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // Number of stack trace lines
      errorMethodCount: 8,
      lineLength: 100,
      colors: true,
      printEmojis: true, // Enable emojis in logs
      printTime: true, // Show timestamps
    ),
  );

  static void info(String message) {
    _logger.i(message);
  }

  static void debug(String message) {
    _logger.d(message);
  }

  static void warning(String message) {
    _logger.w(message);
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }


}