import 'package:afad_app/services/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:flutter_riverpod/flutter_riverpod.dart' show WidgetRef;

class AppBtnInterface extends ConsumerWidget {
  final VoidCallback? _onPressed;
  final String buttonName;
  final String eventName;

  const AppBtnInterface({
    Key? key,
    required VoidCallback? onPressed,
    required this.buttonName,
    required this.eventName,
  })  : _onPressed = onPressed,
        super(key: key);

  VoidCallback? onPressed(WidgetRef ref) {
    if (_onPressed == null) {
      return null;
    }

    return () {
      ref.read(fbAnalyticsProv).buttonPressed(
            buttonName,
            eventName,
          );
      _onPressed?.call();
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    throw UnimplementedError('build not implemented');
  }
}
