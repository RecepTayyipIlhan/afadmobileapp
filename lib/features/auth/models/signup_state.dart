import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/prov/auth_prov.dart';
import 'app_user.dart';
import 'auth_mode.dart';
import 'signup_step.dart';

export 'auth_mode.dart';

part 'signup_state.freezed.dart';

@freezed
class SignupState with _$SignupState {
  const SignupState._();

  const factory SignupState({
    String? email,
    String? pass,
    String? userName,
    String? fullName,
    File? profileImage,
    DateTime? birthDate,
    String? countryPhoneCode,
    String? countryLetterCode,
    String? phone,
    @Default(true) bool isEmailLinkRequested,
    required Ref ref,
    required GlobalKey<FormState> formKey,
    @protected required AuthMode? mode,
    int? emailLinkResendSecondsLeft,
    @Default(true) bool confirmedEmailMarketing,
  }) = _SignupState;

  factory SignupState.initial({required Ref ref}) {
    final mode = AuthMode.emailLink;

    staticMode ??= mode;

    return SignupState(
      formKey: GlobalKey<FormState>(),
      ref: ref,
      mode: mode,
    );
  }

  AppUser toAppUser(User fbUser) => AppUser.fromFormState(
        email: fbUser.email!,
        userName: userName!.toLowerCase(),
        fullName: fullName!,
        authMode: authMode ?? AuthMode.values[0],
        birthDate: birthDate,
        countryPhoneCode: countryPhoneCode,
        countryLetterCode: countryLetterCode,
        phone: phone,
        confirmedEmailMarketing: confirmedEmailMarketing,
      );

  Duration get emailLinkResendDuration => const Duration(seconds: 30);

  bool get isEmailLinkResendAllowed =>
      emailLinkResendSecondsLeft == null || emailLinkResendSecondsLeft! <= 0;

  bool get isValid {
    if (formKey.currentState?.validate() != true) {
      return false;
    }

    return true;
  }

  bool get isValidEmailStep {
    return isValid;
  }

  bool get isValidInfoStep {
    return isValid;
  }

  bool get isLinkSendable {
    return isValidEmailStep;
  }

  String? birthDateFormatted(BuildContext context) {
    if (birthDate == null) {
      return null;
    }

    String formatted = DateFormat.yMMMMd().format(birthDate!);

    return formatted;
  }

  String? countryCodeFormatted(BuildContext context) {
    if (countryPhoneCode == null) {
      return null;
    }

    return '+$countryPhoneCode';
  }

  // this is a terrible hack, but it's the only way to get the mode
  // else way, on each navigation the state is being reset.
  // this problem is caused by the gorouter's navigation.
  // https://github.com/flutter/flutter/issues/99124
  static AuthMode? staticMode;

  // due to a problem in gorouter, when the redirect kicks in this
  // state will be reset, so the mode will reset to AuthMode.emailLink.
  // but at this step, as the fb auth is already done, we can use the
  // info from that as the reliable source of truth.
  AuthMode? get authMode {
    return staticMode ?? mode;
  }

  bool get _isEmailVerified => ref.watch(authProvider).isEmailVerified;

  SignupStep get step => _isEmailVerified ? SignupStep.info : SignupStep.email;

  bool get isEmailStep => step == SignupStep.email;
  bool get isInfoStep => step == SignupStep.info;

  bool get showPassField => isEmailStep && isModePass;
  bool get showEmailField => isEmailStep;

  bool get showUserNameField => isInfoStep;
  bool get showFullNameField => isInfoStep;
  bool get showProfileImageField => isInfoStep;
  bool get showBirthDateField => isInfoStep;
  bool get showPhoneField => isInfoStep;

  bool get isModeLink => mode == AuthMode.emailLink;
  bool get isModePass => mode == AuthMode.emailPass;
}
