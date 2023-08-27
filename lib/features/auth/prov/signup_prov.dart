import 'dart:async';
import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:afad_app/features/auth/models/app_user.dart';
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

    var appUser = state.toAppUser(fbUser);

    // the .signup will wreck the current state
    // so we need to save the storage service
    // ahead of time
    // final storage = ref.read(fbStorageService);
    final profileImg = state.profileImage;

    if (profileImg != null) {
      final imageUrl =
          await ref.read(fbStorageService).uploadUserProfileImage(profileImg);

      appUser = appUser.copyWith(
        profilePicUrl: imageUrl,
      );
    }

    final created = await ref.read(authProvider.notifier).signup(
          context: context,
          appUser: appUser,
          fbUser: fbUser,
        );

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

  void _openCountryPickerDialog({
    required BuildContext context,
    required void Function(Country) onSelect,
  }) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      useSafeArea: true,
      countryListTheme: const CountryListThemeData(
        margin: EdgeInsets.only(top: 10),
      ),
      favorite: const ['TR'],
      onSelect: onSelect,
    );
  }

  void countryCodeOnPressed(BuildContext context) async {
    _openCountryPickerDialog(
      context: context,
      onSelect: (Country value) {
        countryPhoneCodeOnChanged(value.phoneCode);
        countryLetterCodeOnChanged(value.countryCode);
      },
    );
  }

  void relativeCountryCodeOnPressed(BuildContext context) async {
    _openCountryPickerDialog(
      context: context,
      onSelect: (Country value) {
        relativeCountryPhoneCodeOnChanged(value.phoneCode);
        relativeCountryLetterCodeOnChanged(value.countryCode);
      },
    );
  }

  void emailOnChanged(String value) {
    state = state.copyWith(email: value);
  }

  void passOnChanged(String value) {
    state = state.copyWith(pass: value);
  }

  void fullnameOnChanged(String value) {
    state = state.copyWith(fullName: value);
  }

  void bloodGroupOnChanged(BloodGroup? value) {
    state = state.copyWith(bloodGroup: value);
  }

  void idNumberOnChanged(String value) {
    state = state.copyWith(idNumber: value);
  }

  void relativePhoneNumberOnChanged(String value) {
    state = state.copyWith(relativePhone: value);
  }

  void relativeCountryPhoneCodeOnChanged(String value) {
    state = state.copyWith(relativeCountryPhoneCode: value);
  }

  void relativeCountryLetterCodeOnChanged(String value) {
    state = state.copyWith(relativeCountryLetterCode: value);
  }

  void relativeTypeOnChanged(RelativeType? value) {
    state = state.copyWith(relativeType: value);
  }

  void plakaKoduOnChanged(String? plakakodu) {
    state = state.copyWith(
      plakaKodu: plakakodu,
      ilceKodu: null,
    );
  }

  void ilceKoduOnChanged(String? ilcekodu) {
    state = state.copyWith(ilceKodu: ilcekodu);
  }

  void diseasesOnChanged(String value) {
    state = state.copyWith(diseases: value);
  }

  void medicinesOnChanged(String value) {
    state = state.copyWith(medicines: value);
  }

  void peopleAtSameAddressOnChanged(String value) {
    state = state.copyWith(peopleAtSameAddress: value);
  }

  void addressOnChanged(String value) {
    state = state.copyWith(address: value);
  }

  void buildingAgeOnChanged(String value) {
    state = state.copyWith(buildingAge: value);
  }

  void buildingDurabilityOnChanged(String value) {
    state = state.copyWith(buildingDurability: value);
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

  String? fullnameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('auth:signup:validator:invalid:fullname');
    }

    if (value.isFullNameValid != true) {
      return getStr('auth:signup:validator:invalid:fullname');
    }

    return null;
  }

  String? birthDateValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('auth:signup:validator:invalid:birth_date');
    }

    return null;
  }

  String? bloodGroupValidator(BloodGroup? value) {
    if (value == null) {
      return getStr('auth:signup:validator:invalid:blood_group');
    }

    return null;
  }

  String? idNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('auth:signup:validator:invalid:id_number');
    }

    if (value.isIdNumberValid != true) {
      return getStr('auth:signup:validator:invalid:id_number');
    }

    return null;
  }

  String? relativeTypeValidator(RelativeType? value) {
    if (value == null) {
      return getStr('auth:signup:validator:invalid:relative_type');
    }

    return null;
  }

  String? plakaKoduValidator(String? value) {
    if (value == null) {
      return getStr('auth:signup:validator:invalid:plakakodu');
    }

    return null;
  }

  String? ilceKoduValidator(String? value) {
    if (value == null) {
      return getStr('auth:signup:validator:invalid:ilcekodu');
    }

    return null;
  }

  String? relativePhoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('auth:signup:validator:invalid:phone');
    }

    if (value.isPhoneNumberValid != true) {
      return getStr('auth:signup:validator:invalid:phone');
    }

    if ((state.relativeCountryPhoneCode == null ||
        state.relativeCountryPhoneCode!.isEmpty)) {
      return getStr('auth:signup:validator:empty:country_code');
    }

    return null;
  }

  String? peopleAtSameAddressValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('auth:signup:validator:invalid:people_at_same_address');
    }

    if (int.tryParse(value) == null) {
      return getStr('auth:signup:validator:invalid:people_at_same_address');
    }

    return null;
  }

  String? addressValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('auth:signup:validator:invalid:address');
    }

    return null;
  }

  String? buildingAgeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (int.tryParse(value) == null) {
      return getStr('auth:signup:validator:invalid:building_age');
    }

    return null;
  }

  String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('auth:signup:validator:invalid:phone');
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

  String? relativePhoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('auth:signup:validator:invalid:phone');
    }

    if (value.isPhoneNumberValid != true) {
      return getStr('auth:signup:validator:invalid:phone');
    }

    // if the phone number is not null, then the country code
    // must be valid
    // we don't wanna put this under the country code picker
    // as it does not fit
    if ((state.relativeCountryPhoneCode == null ||
        state.relativeCountryPhoneCode!.isEmpty)) {
      return getStr('auth:signup:validator:empty:country_code');
    }

    return null;
  }
}
