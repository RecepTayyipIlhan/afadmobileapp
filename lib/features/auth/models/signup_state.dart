import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/prov/auth_prov.dart';
import 'app_user.dart';
import 'signup_step.dart';

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
    int? emailLinkResendSecondsLeft,
  }) = _SignupState;

  factory SignupState.initial({required Ref ref}) {
    return SignupState(
      formKey: GlobalKey<FormState>(),
      ref: ref,
    );
  }

  AppUser toAppUser(User fbUser) => AppUser.fromFormState(
        email: fbUser.email!,
        userName: userName!.toLowerCase(),
        fullName: fullName!,
        birthDate: birthDate,
        countryPhoneCode: countryPhoneCode,
        countryLetterCode: countryLetterCode,
        phone: phone,
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

  bool get _isEmailVerified => ref.watch(authProvider).isEmailVerified;

  SignupStep get step => _isEmailVerified ? SignupStep.info : SignupStep.email;

  bool get isEmailStep => step == SignupStep.email;
  bool get isInfoStep => step == SignupStep.info;

  bool get showPassField => isEmailStep;
  bool get showEmailField => isEmailStep;

  bool get showUserNameField => isInfoStep;
  bool get showFullNameField => isInfoStep;
  bool get showProfileImageField => isInfoStep;
  bool get showBirthDateField => isInfoStep;
  bool get showPhoneField => isInfoStep;
}
