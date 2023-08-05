import 'package:flutter/material.dart';

import '../../utils/app_theme.dart';

class Snackbars {
  static const _duration = Duration(seconds: 2);

  static void showSuccessSnackBar(
    BuildContext context, {
    required String message,
  }) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Theme.of(context).success,
      duration: _duration,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // when there's an async gap, we have to create the scaffold messenger
  // pre await operation.
  static void showErrorSnackBarByScaffoldMessenger(
    ScaffoldMessengerState scaffoldMessenger, {
    required ThemeData theme,
    required String message,
  }) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: theme.error,
      duration: _duration,
    );
    scaffoldMessenger.showSnackBar(snackBar);
  }

  static void showErrorSnackBar(
    BuildContext context, {
    required String message,
  }) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Theme.of(context).error,
      duration: _duration,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
