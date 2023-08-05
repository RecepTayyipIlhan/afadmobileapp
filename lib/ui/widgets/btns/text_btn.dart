import 'package:afad_app/ui/widgets/btns/app_btn_interface.dart';
import 'package:afad_app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class TextBtn extends AppBtnInterface {
  final String? text;
  final Widget? child;
  const TextBtn({
    super.key,
    this.text,
    this.child,
    super.onPressed,
    required super.eventName,
  })  : assert(
          text != null || child != null,
          'Either text or child must be provided',
        ),
        super(
          buttonName: 'TextBtn',
        );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: onPressed(ref),
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).textButtonTextColor,
      ),
      child: child ??
          Text(
            text!,
          ),
    );
  }
}
