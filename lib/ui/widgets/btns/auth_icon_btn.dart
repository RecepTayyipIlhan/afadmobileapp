import 'package:afad_app/ui/widgets/btns/app_btn_interface.dart';
import 'package:afad_app/utils/app_theme.dart';
import 'package:afad_app/utils/utils.dart';
import 'package:flutter/material.dart';

class AuthIconBtn extends AppBtnInterface {
  final IconData icon;
  final bool isExpanded;
  const AuthIconBtn({
    super.key,
    super.onPressed,
    required this.icon,
    this.isExpanded = false,
    required super.eventName,
  }) : super(
          buttonName: 'AuthIconBtn',
        );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final body = ElevatedButton(
      onPressed: onPressed(ref),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(50, 50),
        backgroundColor: Theme.of(context).secondaryButtonBgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
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
      child: Icon(
        icon,
        color: Theme.of(context).secondaryButtonTextColor,
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
