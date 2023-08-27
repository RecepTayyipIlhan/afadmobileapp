import 'dart:io';

import 'package:afad_app/features/auth/models/app_user.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_profile_state.freezed.dart';

@freezed
class EditProfileState with _$EditProfileState {
  const EditProfileState._();

  const factory EditProfileState({
    required String fullName,
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
    String? profileImageUrl,
    DateTime? birthDate,
    String? countryPhoneCode,
    String? countryLetterCode,
    String? phone,
    required Ref ref,
    required GlobalKey<FormState> formKey,
    required AppUser user,
    required String? plakaKodu,
    required String? ilceKodu,
  }) = _EditProfileState;

  factory EditProfileState.fromAppUser({
    required AppUser user,
    required Ref ref,
  }) {
    return EditProfileState(
      formKey: GlobalKey<FormState>(),
      ref: ref,
      fullName: user.fullName,
      bloodGroup: user.bloodGroup,
      idNumber: user.idNumber,
      relativePhone: user.relativePhone,
      relativeCountryPhoneCode: user.relativeCountryPhoneCode,
      relativeCountryLetterCode: user.relativeCountryLetterCode,
      relativeType: user.relativeType,
      diseases: user.diseases,
      medicines: user.medicines,
      peopleAtSameAddress: user.peopleAtSameAddress,
      address: user.address,
      buildingAge: user.buildingAge,
      buildingDurability: user.buildingDurability,
      birthDate: user.birthDate,
      countryLetterCode: user.countryLetterCode,
      countryPhoneCode: user.countryPhoneCode,
      phone: user.phone,
      profileImageUrl: user.profilePicUrl,
      user: user,
      plakaKodu: user.plakaKodu,
      ilceKodu: user.ilceKodu,
    );
  }

  AppUser toAppUser() {
    return AppUser.fromEditProfileFormState(
      email: user.email,
      fullName: fullName,
      bloodGroup: bloodGroup!,
      idNumber: idNumber!,
      relativePhone: relativePhone,
      relativeCountryPhoneCode: relativeCountryPhoneCode,
      relativeCountryLetterCode: relativeCountryLetterCode,
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
      id: user.id,
      profilePicUrl: profileImageUrl,
      role: user.role,
      plakaKodu: plakaKodu!,
      ilceKodu: ilceKodu!,
    );
  }

  bool get isValid {
    if (formKey.currentState?.validate() != true) {
      return false;
    }

    return true;
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

  bool get showPlakaKoduField => true;
  bool get showIlceKoduField => plakaKodu != null && true;
}
