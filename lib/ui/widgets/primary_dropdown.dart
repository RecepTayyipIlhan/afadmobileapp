import 'package:afad_app/utils/app_theme.dart';
import 'package:afad_app/utils/utils.dart';
import 'package:flutter/material.dart';

class PrimaryDropdown<T> extends StatefulWidget {
  final T? initialValue;
  final String? hintText;
  final String? labelText;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;

  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final VoidCallback? onTap;

  final bool enabled;

  final List<DropdownMenuItem<T>>? items;

  /// maybe we wanna disable `enbaled`
  /// (making our own action on `onTap`
  /// for example e.g. show a date picker)
  /// but we still wanna show the enabled
  /// look of the field
  final bool enabledStyle;

  final TextAlign textAlign;

  final TextStyle? style;

  final EdgeInsetsGeometry? contentPadding;

  const PrimaryDropdown({
    super.key,
    this.initialValue,
    this.items,
    this.hintText,
    this.labelText,
    this.onChanged,
    this.icon,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.enabled = true,
    this.enabledStyle = false,
    this.textAlign = TextAlign.start,
    this.contentPadding,
    this.style,
    this.validator,
  });

  @override
  State<PrimaryDropdown<T>> createState() => _PrimaryDropdownState<T>();
}

class _PrimaryDropdownState<T> extends State<PrimaryDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    final enabledStyle = widget.enabled || widget.enabledStyle;

    final suffix = widget.suffixIcon;
    ;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Text(
            widget.labelText!,
            style: TextStyle(
              color: Theme.of(context).primaryDropdownTitleColor,
              fontSize: 14,
            ),
          ),
        InkWell(
          onTap: widget.onTap,
          overlayColor: MaterialStateProperty.all(
            Theme.of(context).primaryDropdownTapOverlayColor,
          ),
          child: DropdownButtonFormField(
            items: widget.items,
            validator: widget.validator,
            style: widget.style ??
                TextStyle(
                  color: Theme.of(context).primaryDropdownTextColor,
                  fontSize: 16,
                ),
            decoration: InputDecoration(
              contentPadding: widget.contentPadding,
              icon: widget.icon,
              prefixIcon: widget.prefixIcon,
              suffixIcon: suffix,
              iconColor: Theme.of(context).primaryDropdownIconColor,
              hintText: widget.hintText,
              errorMaxLines: 3,
              enabled: widget.enabled,
              // labelText: labelText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryDropdownFocusedBorderColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryDropdownEnabledBorderColor,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: enabledStyle
                      ? Theme.of(context).primaryDropdownEnabledBorderColor
                      : Theme.of(context).primaryDropdownDisabledBorderColor,
                ),
              ),
            ),
            onChanged: widget.onChanged,
          ),
        ),
      ].joinWidgetList(
        (index) => const SizedBox(
          height: halfDefPaddingSize,
        ),
      ),
    );
  }
}
