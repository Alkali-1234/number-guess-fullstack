import "package:logger/logger.dart";

/// Public instance of [Logger] to be used throughout the app.
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 8,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
);
