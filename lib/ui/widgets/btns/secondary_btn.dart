import 'package:afad_app/ui/widgets/btns/app_btn_interface.dart';
import 'package:afad_app/utils/app_theme.dart';
import 'package:afad_app/utils/utils.dart';
import 'package:flutter/material.dart';

class SecondaryBtn extends AppBtnInterface {
  final Widget? child;
  final String? text;
  final bool isExpanded;
  const SecondaryBtn({
    required super.onPressed,
    this.text,
    this.child,
    this.isExpanded = false,
    required super.eventName,
  })  : assert(
          (text != null || child != null) && (text == null || child == null),
        ),
        super(
          buttonName: 'SecondaryBtn',
        );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final body = ElevatedButton(
      onPressed: onPressed(ref),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(180, 40),
        backgroundColor: Theme.of(context).secondaryButtonBgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: Theme.of(context).secondaryButtonBorderColor,
          ),
        ),
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          vertical: defPaddingSize,
          horizontal: defPaddingSize,
        ),
      ).copyWith(
        overlayColor: MaterialStateProperty.all(
          Theme.of(context).secondaryButtonOverlayColor,
        ),
      ),
      child: child ??
          Text(
            text!,
            style: TextStyle(
              color: Theme.of(context).secondaryButtonTextColor,
              fontSize: 18,
            ),
          ),
    );

    return Container(
      margin: quartDefPaddingHor,
      child: Row(
        children: [
          if (isExpanded) Expanded(child: body) else body,
        ],
      ),
    );
  }
}
