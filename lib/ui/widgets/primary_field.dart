import 'package:afad_app/utils/app_theme.dart';
import 'package:afad_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryField extends StatefulWidget {
  final String? initialValue;

  /// this will always be up to date.
  /// use only for uneditable fields
  /// like date picker, as it will
  /// rebuild the field on each value
  /// change. for normal fields, use
  /// `initialValue` instead.
  final String? value;
  final String? hintText;
  final String? labelText;
  final Function(String)? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;

  final int? minLines;
  final int? maxLines;

  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final bool isPassword;

  final VoidCallback? onTap;

  final bool enabled;

  /// maybe we wanna disable `enbaled`
  /// (making our own action on `onTap`
  /// for example e.g. show a date picker)
  /// but we still wanna show the enabled
  /// look of the field
  final bool enabledStyle;

  final TextAlign textAlign;

  final TextStyle? style;

  final EdgeInsetsGeometry? contentPadding;

  const PrimaryField({
    super.key,
    this.initialValue,
    this.value,
    this.hintText,
    this.labelText,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.minLines,
    this.maxLines,
    this.icon,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.onTap,
    this.enabled = true,
    this.enabledStyle = false,
    this.textAlign = TextAlign.start,
    this.contentPadding,
    this.style,
    this.inputFormatters,
  });

  @override
  State<PrimaryField> createState() => _PrimaryFieldState();
}

class _PrimaryFieldState extends State<PrimaryField> {
  late TextEditingController con;

  @override
  void initState() {
    con = TextEditingController(
      text: widget.initialValue ?? widget.value,
    );
    obscureText = widget.isPassword;

    super.initState();
  }

  @override
  void didUpdateWidget(covariant PrimaryField oldWidget) {
    // parents who call this widget will always pass the up to
    // date value as `initialValue`, so we're protecting ourselves
    // from reinitializing the controller with the same value,
    // which will cause the cursor to jump to the start of the text
    // and may cause other issues.
    //
    // we only wanna reinitialize the controller if the parent totally
    // controls the value of the field, for example a date picker field.
    //
    // setting con.text doesn't work because `TextEditingController` is
    // a `ValueNotifier` and it will cause another build during the build
    // which wll cause an error.
    if (con.text != widget.value && oldWidget.value != widget.value) {
      con = TextEditingController(text: widget.value);
    }
    super.didUpdateWidget(oldWidget);
  }

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final _enabledStyle = widget.enabled || widget.enabledStyle;

    final suffix = widget.suffixIcon ??
        (widget.isPassword
            ? _PassButton(
                obscureText: obscureText,
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              )
            : null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Text(
            widget.labelText!,
            style: TextStyle(
              color: Theme.of(context).primaryFieldTitleColor,
              fontSize: 14,
            ),
          ),
        InkWell(
          onTap: widget.onTap == null
              ? null
              : () {
                  // we want the previous focused node to be unfocused
                  // so if for example we open a date picker, once we
                  // close it, the field will be unfocused
                  FocusScope.of(context).unfocus();

                  widget.onTap!();
                },
          overlayColor: MaterialStateProperty.all(
            Theme.of(context).primaryFieldTapOverlayColor,
          ),
          child: TextFormField(
            controller: con,
            obscureText: obscureText,
            textAlign: widget.textAlign,
            style: widget.style ??
                TextStyle(
                  color: Theme.of(context).primaryFieldTextColor,
                  fontSize: 16,
                ),
            textInputAction: widget.textInputAction,
            decoration: InputDecoration(
              contentPadding: widget.contentPadding,
              icon: widget.icon,
              prefixIcon: widget.prefixIcon,
              suffixIcon: suffix,
              iconColor: Theme.of(context).primaryFieldIconColor,
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
                  color: Theme.of(context).primaryFieldFocusedBorderColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryFieldEnabledBorderColor,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: _enabledStyle
                      ? Theme.of(context).primaryFieldEnabledBorderColor
                      : Theme.of(context).primaryFieldDisabledBorderColor,
                ),
              ),
            ),
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onSubmitted,
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            minLines: widget.minLines,
            maxLines: obscureText ? 1 : widget.maxLines,
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

class _PassButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool obscureText;
  const _PassButton({
    required this.onPressed,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        obscureText ? Icons.visibility : Icons.visibility_off,
        color: Theme.of(context).primaryFieldIconColor,
      ),
    );
  }
}
