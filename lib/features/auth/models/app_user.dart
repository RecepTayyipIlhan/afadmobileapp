// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_user_role.dart';

part 'app_user.g.dart';
part 'app_user.freezed.dart';

enum BloodGroup {
  zeroPositive,
  zeroNegative,
  aPositive,
  aNegative,
  bPositive,
  bNegative,
  abPositive,
  abNegative,
}

enum RelativeType {
  mother,
  father,
  sibling,
  spouse,
  kid,
  grandchild,
  grandmother,
  grandfather,
  aunt,
  uncle,
  cousin,
  other,
}

@freezed
class AppUser with _$AppUser {
  const AppUser._();

  factory AppUser({
    required String id,
    required String email,
    required String fullName,
    required AppUserRole role,
    required BloodGroup bloodGroup,
    required String idNumber,
    required String relativePhone,
    String? relativeCountryPhoneCode,
    String? relativeCountryLetterCode,
    required RelativeType relativeType,
    String? diseases,
    String? medicines,
    String? peopleAtSameAddress,
    required String? address,
    String? buildingAge,
    String? buildingDurability,
    String? profilePicUrl,
    DateTime? birthDate,
    required String countryPhoneCode,
    required String countryLetterCode,
    required String phone,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(false)
    bool isLoading,
    DateTime? lastUpdated,
    String? cihazid,
    required String plakaKodu,
    required String ilceKodu,
  }) = _AppUser;

  factory AppUser.fromFormState({
    required String email,
    required String fullName,
    required BloodGroup bloodGroup,
    required String idNumber,
    required String relativePhone,
    required String relativeCountryPhoneCode,
    required String relativeCountryLetterCode,
    required RelativeType relativeType,
    String? diseases,
    String? medicines,
    required String? peopleAtSameAddress,
    required String? address,
    String? buildingAge,
    String? buildingDurability,
    DateTime? birthDate,
    required String countryPhoneCode,
    required String countryLetterCode,
    required String phone,
    String? cihazid,
    required String plakaKodu,
    required String ilceKodu,
  }) =>
      AppUser(
        id: '',
        email: email,
        fullName: fullName,
        bloodGroup: bloodGroup,
        idNumber: idNumber,
        relativePhone: relativePhone,
        relativeCountryPhoneCode: relativeCountryPhoneCode,
        relativeCountryLetterCode: relativeCountryLetterCode,
        relativeType: relativeType,
        diseases: diseases,
        medicines: medicines,
        peopleAtSameAddress: peopleAtSameAddress,
        address: address,
        buildingAge: buildingAge,
        buildingDurability: buildingDurability,
        role: AppUserRole.user,
        isLoading: true,
        birthDate: birthDate,
        countryPhoneCode: countryPhoneCode,
        countryLetterCode: countryLetterCode,
        phone: phone,
        cihazid: cihazid,
        plakaKodu: plakaKodu,
        ilceKodu: ilceKodu,
      );

  factory AppUser.fromEditProfileFormState({
    required String id,
    required String email,
    required String fullName,
    required BloodGroup bloodGroup,
    required String idNumber,
    required String relativePhone,
    required String relativeCountryPhoneCode,
    required String relativeCountryLetterCode,
    required RelativeType relativeType,
    String? diseases,
    String? medicines,
    required String? peopleAtSameAddress,
    required String? address,
    String? buildingAge,
    String? buildingDurability,
    required AppUserRole role,
    required String? profilePicUrl,
    required DateTime? birthDate,
    required String countryPhoneCode,
    required String countryLetterCode,
    required String phone,
    String? cihazid,
    required String plakaKodu,
    required String ilceKodu,
  }) =>
      AppUser(
        id: id,
        email: email,
        fullName: fullName,
        bloodGroup: bloodGroup,
        idNumber: idNumber,
        relativePhone: relativePhone,
        relativeCountryPhoneCode: relativeCountryPhoneCode,
        relativeCountryLetterCode: relativeCountryLetterCode,
        relativeType: relativeType,
        diseases: diseases,
        medicines: medicines,
        peopleAtSameAddress: peopleAtSameAddress,
        address: address,
        buildingAge: buildingAge,
        buildingDurability: buildingDurability,
        role: role,
        isLoading: true,
        birthDate: birthDate,
        countryPhoneCode: countryPhoneCode,
        countryLetterCode: countryLetterCode,
        phone: phone,
        profilePicUrl: profilePicUrl,
        cihazid: cihazid,
        plakaKodu: plakaKodu,
        ilceKodu: ilceKodu,
      );

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
