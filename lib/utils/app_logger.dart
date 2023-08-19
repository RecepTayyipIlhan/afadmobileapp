part of 'utils.dart';

final logger = _LoggerImpl();

class _LoggerImpl extends Logger {
  _LoggerImpl()
      : super(
          printer: PrettyPrinter(
            methodCount: 0,
            errorMethodCount: 8,
            lineLength: 120,
            colors: true,
            printEmojis: true,
            printTime: true,
          ),
        );

  @override
  void log(
    Level level,
    message, {
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    try {
      stackTrace ??= StackTrace.current;

      if (kDebugMode) {
        super.log(level, message, error: error, stackTrace: stackTrace);
      } else {
        try {
          if (level.isException) {
            FirebaseCrashlytics.instance.recordError(
              error,
              stackTrace,
              fatal: true,
            );
          } else {
            super.log(level, message, error: error, stackTrace: stackTrace);
          }
        } catch (e) {
          // crashlytics may fail, but we cant do anything about it
        }
      }
    } catch (err) {
      debugPrint(err.toString());

      // we cant do anything about this in prod
      // if any error came to this point, we just
      // pay respect for surviving this far
    }
  }
}

extension on Level {
  bool get isException => this == Level.error || this == Level.wtf;
}
