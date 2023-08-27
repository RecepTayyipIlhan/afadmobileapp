import 'dart:io';

import 'package:afad_app/app_runner.dart';
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
    String? fullName,
    BloodGroup? bloodGroup,
    String? idNumber,
    String? relativePhone,
    String? relativeCountryPhoneCode,
    String? relativeCountryLetterCode,
    RelativeType? relativeType,
    String? diseases,
    String? medicines,
    String? peopleAtSameAddress,
    String? address,
    String? buildingAge,
    String? buildingDurability,
    File? profileImage,
    DateTime? birthDate,
    String? countryPhoneCode,
    String? countryLetterCode,
    String? phone,
    @Default(true) bool isEmailLinkRequested,
    required Ref ref,
    required GlobalKey<FormState> formKey,
    int? emailLinkResendSecondsLeft,
    String? plakaKodu,
    String? ilceKodu,
  }) = _SignupState;

  factory SignupState.initial({required Ref ref}) {
    return SignupState(
      formKey: GlobalKey<FormState>(),
      ref: ref,
    );
  }

  AppUser toAppUser(User fbUser) => AppUser.fromFormState(
        email: fbUser.email!,
        fullName: fullName!,
        bloodGroup: bloodGroup!,
        idNumber: idNumber!,
        relativePhone: relativePhone!,
        relativeCountryPhoneCode: relativeCountryPhoneCode!,
        relativeCountryLetterCode: relativeCountryLetterCode!,
        relativeType: relativeType!,
        diseases: diseases,
        medicines: medicines,
        peopleAtSameAddress: peopleAtSameAddress,
        address: address,
        buildingAge: buildingAge,
        buildingDurability: buildingDurability,
        birthDate: birthDate,
        countryPhoneCode: countryPhoneCode!,
        countryLetterCode: countryLetterCode!,
        phone: phone!,
        ilceKodu: ilceKodu!,
        plakaKodu: plakaKodu!,
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

  String? relativeCountryCodeFormatted(BuildContext context) {
    if (relativeCountryPhoneCode == null) {
      return null;
    }

    return '+$relativeCountryPhoneCode';
  }

  bool get _isEmailVerified => ref.watch(authProvider).isEmailVerified;

  SignupStep get step => _isEmailVerified ? SignupStep.info : SignupStep.email;

  bool get isEmailStep => step == SignupStep.email;
  bool get isInfoStep => step == SignupStep.info;

  bool get showPassField => isEmailStep;
  bool get showEmailField => isEmailStep;

  bool get isAfad => selectedFlavor == Flavor.AFAD;

  bool get showFullNameField => isInfoStep;
  bool get showBloodGroupField => isInfoStep;
  bool get showIdNumberField => isInfoStep;
  bool get showRelativePhoneField => isInfoStep && isAfad;
  bool get showRelativeTypeField => isInfoStep;
  bool get showRelativeCountryPhoneCodeField => isInfoStep && isAfad;
  bool get showRelativeCountryLetterCodeField => isInfoStep && isAfad;
  bool get showDiseasesField => isInfoStep && isAfad;
  bool get showMedicinesField => isInfoStep && isAfad;
  bool get showPeopleAtSameAddressField => isInfoStep && isAfad;
  bool get showAddressField => isInfoStep;
  bool get showBuildingAgeField => isInfoStep && isAfad;
  bool get showBuildingDurabilityField => isInfoStep && isAfad;
  bool get showProfileImageField => isInfoStep;
  bool get showBirthDateField => isInfoStep;
  bool get showPhoneField => isInfoStep;
  bool get showPlakaKoduField => isInfoStep;
  bool get showIlceKoduField => plakaKodu != null && isInfoStep;
}
