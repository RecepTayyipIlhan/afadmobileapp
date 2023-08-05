import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading/loading.dart';
import '../models/signup_state.dart';
import '../../../services/cloud_storage_service.dart';
import '../../../ui/widgets/snackbars.dart';
import '../../../utils/extensions/auth_extensions.dart';
import '../../../utils/prov/auth_prov.dart';
import '../../../utils/utils.dart';

final signupStateProvider =
    StateNotifierProvider<SignupStateNotifier, SignupState>(
  (ref) {
    return SignupStateNotifier(ref);
  },
);

class SignupStateNotifier extends StateNotifier<SignupState> {
  final Ref ref;
  SignupStateNotifier(this.ref) : super(SignupState.initial(ref: ref));

  Future<bool> loginWithGoogle(BuildContext context) async {
    try {
      Loading.load(context);

      final res = await ref.read(authProvider.notifier).loginWithGoogle(
            context: context,
          );

      Loading.unload(context);

      return res;
    } catch (e) {
      logger.e(e);

      Loading.unload(context);
      return false;
    }
  }

  Future<bool> loginWithApple(BuildContext context) async {
    try {
      Loading.load(context);

      final res = await ref.read(authProvider.notifier).loginWithApple(
            context: context,
          );

      Loading.unload(context);

      return res;
    } catch (e) {
      logger.e(e);

      Loading.unload(context);
      return false;
    }
  }

  Future<bool> submitEmailStepPass(BuildContext context) async {
    if (state.isValidEmailStep == false) {
      return false;
    }

    final isSignedUp = await ref.read(authProvider.notifier).signupUsingPass(
          context: context,
          email: state.email!,
          passowrd: state.pass!,
        );

    return isSignedUp;
  }

  Future<bool> submitEmailStepLink(BuildContext context) async {
    if (state.isValidEmailStep == false) {
      return false;
    }

    try {
      Loading.load(context);

      final isSent = await ref.read(authProvider.notifier).sendEmailSignupLink(
            context: context,
            email: state.email!,
          );

      if (!isSent) {
        Loading.unload(context);

        return false;
      }

      state = state.copyWith(
        emailLinkResendSecondsLeft: state.emailLinkResendDuration.inSeconds,
      );

      state = state.copyWith(
        isEmailLinkRequested: true,
      );

      Snackbars.showSuccessSnackBar(
        context,
        message: getStrArgs(
          'auth:signup:email_link_sent',
          args: [state.email!],
        ),
      );

      Loading.unload(context);

      return true;
    } catch (e) {
      logger.e(e);

      Loading.unload(context);

      return false;
    }
  }

  Future<bool> submitInfoStep(BuildContext context) async {
    if (state.isValidInfoStep == false) {
      return false;
    }

    final fbUser = ref.read(authProvider).firebaseUser!;

    final appUser = state.toAppUser(fbUser);

    // the .signup will wreck the current state
    // so we need to save the storage service
    // ahead of time
    // final storage = ref.read(fbStorageService);
    final profileImg = state.profileImage;

    final created = await ref.read(authProvider.notifier).signup(
          context: context,
          appUser: appUser,
          fbUser: fbUser,
        );

    if (profileImg != null) {
      await ref.read(fbStorageService).uploadUserProfileImage(profileImg);
    }

    return created;
  }

  Future<bool> submit(BuildContext context) async {
    if (state.isEmailStep) {
      return submitEmailStepPass(context);
    }

    if (state.isInfoStep) {
      return submitInfoStep(context);
    }

    logger.e('Invalid state');

    return false;
  }

  DateTime get _defaultBirthDate => DateTime(2000);

  void birthDateOnPressed(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: state.birthDate ?? _defaultBirthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (date == null) {
      return;
    }

    birthDateOnChanged(date);
  }

  void emailOnChanged(String value) {
    state = state.copyWith(email: value);
  }

  void passOnChanged(String value) {
    state = state.copyWith(pass: value);
  }

  void usernameOnChanged(String value) {
    state = state.copyWith(userName: value);
  }

  void fullnameOnChanged(String value) {
    state = state.copyWith(fullName: value);
  }

  void profileImageOnChanged(File value) {
    state = state.copyWith(profileImage: value);
  }

  void birthDateOnChanged(DateTime value) {
    state = state.copyWith(birthDate: value);
  }

  void countryPhoneCodeOnChanged(String value) {
    state = state.copyWith(countryPhoneCode: value);
  }

  void countryLetterCodeOnChanged(String value) {
    state = state.copyWith(countryLetterCode: value);
  }

  void phoneNumberOnChanged(String value) {
    state = state.copyWith(phone: value);
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('auth:signup:validator:null:email');
    }

    if (value.isEmailValid != true) {
      return getStr('auth:signup:validator:invalid:email');
    }

    return null;
  }

  String? passValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('auth:signup:validator:invalid:password');
    }

    if (value.isPasswordValid != true) {
      return getStr('auth:signup:validator:invalid:password');
    }

    return null;
  }

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('auth:signup:validator:invalid:username');
    }

    if (value.isUsernameValid != true) {
      return getStr('auth:signup:validator:invalid:username');
    }

    return null;
  }

  String? fullnameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('auth:signup:validator:invalid:fullname');
    }

    if (value.isFullNameValid != true) {
      return getStr('auth:signup:validator:invalid:fullname');
    }

    return null;
  }

  // optional field, just validate it contains numbers
  // and it is
  String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (value.isPhoneNumberValid != true) {
      return getStr('auth:signup:validator:invalid:phone');
    }

    // if the phone number is not null, then the country code
    // must be valid
    // we don't wanna put this under the country code picker
    // as it does not fit
    if ((state.countryPhoneCode == null || state.countryPhoneCode!.isEmpty)) {
      return getStr('auth:signup:validator:empty:country_code');
    }

    return null;
  }
}
