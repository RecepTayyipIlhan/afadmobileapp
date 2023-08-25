import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'ui/widgets/error_screen.dart';

enum Flavor { AFAD, TRACKER }

late Flavor _selectedFlavor;

Flavor get selectedFlavor => _selectedFlavor;
bool get isAfad => selectedFlavor == Flavor.AFAD;

late _AppConfig appConfig;

class _AppConfig {
  final String deepLinksHost;
  final String androidBundleId;
  final String iosBundleId;
  final DefaultFirebaseOptions firebaseOptionsInstance;

  _AppConfig._({
    required this.deepLinksHost,
    required this.androidBundleId,
    required this.iosBundleId,
    required this.firebaseOptionsInstance,
  });

  factory _AppConfig.fromFlavor(Flavor flavor) {
    switch (flavor) {
      case Flavor.AFAD:
        _selectedFlavor = Flavor.AFAD;
        return _AppConfig._afad();
      case Flavor.TRACKER:
        _selectedFlavor = Flavor.TRACKER;
        return _AppConfig._tracker();
    }
  }

  _AppConfig._afad()
      : this._(
          deepLinksHost: 'https://afadmobileapp.page.link',
          androidBundleId: 'com.example.afad_app',
          iosBundleId: 'com.arithmatrix',
          firebaseOptionsInstance: DefaultFirebaseOptions(),
        );

  _AppConfig._tracker()
      : this._(
          deepLinksHost: 'https://afadmobileapp.page.link',
          androidBundleId: 'com.example.tracker_app',
          iosBundleId: 'com.arithmatrix',
          firebaseOptionsInstance: DefaultFirebaseOptions(),
        );
}

void appRunner(Flavor flavor) async {
  errorCatcher();

  appConfig = _AppConfig.fromFlavor(flavor);

  // provider scope is provided inside
  // `TheApp` widget
  // ignore: missing_provider_scope
  runApp(const TheApp());
}

void errorCatcher() {
  ErrorWidget.builder = (details) {
    // log to crashlytics and then build
    // the error widget

    FirebaseCrashlytics.instance.recordFlutterError(details);

    return const ErrorScreen.empty();

    // the rest of error catching is handled in app init
  };
}
