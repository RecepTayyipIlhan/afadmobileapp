import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

extension MyTheme on ThemeData {
  bool get isLight => brightness == Brightness.light;

  Color get statusBarColor => Colors.white;

  Color get primaryButtonBgColor => AppTheme._lightSecondary;
  Color get primaryButtonTextColor => AppTheme._lightOnDarkTextColor;

  Color get secondaryButtonBgColor => Colors.white;
  Color get secondaryButtonTextColor => AppTheme._lightSecondary;
  Color get secondaryButtonBorderColor => AppTheme._lightSecondary;
  Color get secondaryButtonOverlayColor =>
      AppTheme._lightSecondary.withOpacity(.05);

  Color get tertiaryButtonBgColor => Colors.white;
  Color get tertiaryButtonTextColor => AppTheme._lightPrimary;

  Color get textButtonTextColor => AppTheme._lightSecondary;
  Color get introSkipButtonText => AppTheme._lightOnDarkTextColor;

  Color get primaryFieldTitleColor => AppTheme._lightPrimary;
  Color get primaryFieldEnabledBorderColor => AppTheme._lightPrimary;
  Color get primaryFieldDisabledBorderColor => _disabled;
  Color get primaryFieldFocusedBorderColor =>
      AppTheme._lightSecondary.withOpacity(.3);
  Color get primaryFieldIconColor => AppTheme._lightPrimary;
  Color get primaryFieldTapOverlayColor =>
      AppTheme._lightPrimary.withOpacity(.05);
  Color get primaryFieldTextColor => AppTheme._lightOnBgTextColor;

  Color get primaryDropdownTitleColor => AppTheme._lightPrimary;
  Color get primaryDropdownEnabledBorderColor => AppTheme._lightPrimary;
  Color get primaryDropdownDisabledBorderColor => _disabled;
  Color get primaryDropdownFocusedBorderColor =>
      AppTheme._lightSecondary.withOpacity(.3);
  Color get primaryDropdownIconColor => AppTheme._lightPrimary;
  Color get primaryDropdownTapOverlayColor =>
      AppTheme._lightPrimary.withOpacity(.05);
  Color get primaryDropdownTextColor => AppTheme._lightOnBgTextColor;

  Color get primaryImagePickerBorder => AppTheme._lightPrimary;

  Color get bottomBarBgColor => AppTheme._lightPrimary;
  Color get bottomBarSelectedIconColor => AppTheme._lightOnDarkTextColor;
  Color get bottomBarUnSelectedIconColor =>
      AppTheme._lightOnDarkTextColor.withOpacity(.5);
  BorderRadiusGeometry get bottomBarBorderRadius => const BorderRadius.vertical(
        top: Radius.circular(0),
      );

  Color get profileItemNoDangerTextColor => AppTheme._lightOnBgTextColor;
  Color get profileItemDangerTextColor => _danger;
  Color get profileImageBorderColor => AppTheme._lightPrimary;

  Color get quizTimerTextColor => const Color(0xFF103260);
  Color get quizTimerSliderActiveColor => const Color(0xFF103260);
  Color get quizTimerSliderInactiveColor =>
      const Color(0xFF103260).withOpacity(.2);

  Color get quizQuestionTextColor => AppTheme._lightPrimary;

  Color get quizPostSubmitBgColor => AppTheme._lightPrimary;
  Color get quizPostSubmitExplanationTextColor => _theNavyColor;
  Color get quizPostSubmitTextColor => AppTheme._lightOnDarkTextColor;
  Color get multiQuizPostSubmitCorrectItemBgColor => const Color(0xFF5cb85c);
  Color get multiQuizPostSubmitCorrectItemTextColor =>
      AppTheme._lightOnDarkTextColor;

  Color get quizAlreadyEnteredDialogBgColor => AppTheme._lightPrimary;
  Color get quizAlreadyEnteredDialogTextColor => AppTheme._lightOnDarkTextColor;

  Color get multiQuizPostSubmitCorrectTextSymbolColor =>
      const Color(0xFF00B71D);
  Color get multiQuizPostSubmitIncorrectTextSymbolColor =>
      const Color(0xFFFF6474);

  Color get quizHintBgColor => AppTheme._lightPrimary;
  Color get quizHintTextColor => AppTheme._lightOnDarkTextColor;

  Color get multiQuizUnselectedBorderColor => AppTheme._lightOnBgTextColor;
  Color get multiQuizUnselectedTextColor => AppTheme._lightOnBgTextColor;
  Color get multiQuizSelectedBorderColor => AppTheme._lightPrimary;
  Color get multiQuizSelectedTextColor => AppTheme._lightPrimary;
  Color get multiQuizCorrectBorderColor => const Color(0xFF00B71D);
  Color get multiQuizCorrectTextColor => const Color(0xFF00B71D);
  Color get multiQuizIncorrectBorderColor => const Color(0xFFFF6474);
  Color get multiQuizIncorrectTextColor => const Color(0xFFFF6474);

  Color get editProfileFieldsSuffixIconColor => AppTheme._lightPrimary;

  // home
  Color get homeQuizItemBg => const Color(0xFFF1F1F1);
  Color get homeQuizItemText => AppTheme._lightPrimary;
  Color get homeQuizItemDisabledText => _disabled;

  Color get homeScoreBg => AppTheme._lightSecondary;
  Color get homeScoreText => AppTheme._lightOnDarkTextColor;
  Color get homeScoreIcon => homeScoreText;

  Color get NoConnectionText => _theNavyColor;

  Color get _theNavyColor => const Color(0xFF003264);

  // intro
  Color get introImageBg => AppTheme._lightPrimary;

  Color get success => const Color(0xFF5cb85c);
  Color get error => const Color(0xFFB00020);

  Color get bgColorAfad => const Color(0xFF003399);

  Color get _danger => AppTheme._lightSecondary;

  Color get _disabled => const Color(0xFFBDBDBD);
}

final appThemeProv = Provider(AppTheme.new);

class AppTheme {
  final Ref ref;
  AppTheme(this.ref);

//
  static const Color _lightPrimary = Color(0xFF72B8FF);
  static const Color _lightSecondary = Color(0xFFFF6474);
  // static const Color _lightTertiary = Color(0xFFC5D9F0);

  static const Color _lightOnDarkTextColor = Color(0xFFFFFFFF);
  static const Color _lightOnBgTextColor = Color(0xFF000000);

  Color get _backgroundColor => Colors.white;

  ThemeData get lightTheme => ThemeData(
        primaryColor: _lightPrimary,
        scaffoldBackgroundColor: _backgroundColor,
        fontFamily: GoogleFonts.poppins().fontFamily,
        colorScheme: const ColorScheme.light(
          primary: _lightPrimary,
          secondary: _lightSecondary,
          // tertiary: _lightTertiary,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: _lightOnBgTextColor,
          ),
          headlineMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: _lightOnBgTextColor,
          ),
          headlineSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: _lightOnBgTextColor,
          ),
          labelMedium: TextStyle(
            fontSize: 18,
            color: _lightOnBgTextColor,
          ),
          bodyMedium: TextStyle(
            fontSize: 12,
            color: _lightOnBgTextColor,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: _backgroundColor,
          elevation: 0,
          foregroundColor: _backgroundColor,
          iconTheme: const IconThemeData(
            color: _lightOnBgTextColor,
          ),
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: _lightOnBgTextColor,
          ),
        ),
      );
}
