// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_user_role.dart';
import 'auth_mode.dart';

part 'app_user.g.dart';
part 'app_user.freezed.dart';

@freezed
class AppUser with _$AppUser {
  const AppUser._();

  factory AppUser({
    required String id,
    required String email,
    required String userName,
    required String fullName,
    required AppUserRole role,
    required AuthMode authMode,
    @JsonKey(defaultValue: false) required bool confirmedEmailMarketing,
    String? profilePicUrl,
    DateTime? birthDate,
    String? countryPhoneCode,
    String? countryLetterCode,
    String? phone,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(false)
    bool isLoading,
    DateTime? lastUpdated,
  }) = _AppUser;

  factory AppUser.fromFormState({
    required String email,
    required String userName,
    required String fullName,
    required AuthMode authMode,
    required bool confirmedEmailMarketing,
    DateTime? birthDate,
    String? countryPhoneCode,
    String? countryLetterCode,
    String? phone,
  }) =>
      AppUser(
        id: '',
        email: email,
        userName: userName,
        fullName: fullName,
        role: AppUserRole.user,
        isLoading: true,
        authMode: authMode,
        confirmedEmailMarketing: confirmedEmailMarketing,
        birthDate: birthDate,
        countryPhoneCode: countryPhoneCode,
        countryLetterCode: countryLetterCode,
        phone: phone,
      );

  factory AppUser.fromEditProfileFormState({
    required String id,
    required String email,
    required String userName,
    required String fullName,
    required AppUserRole role,
    required AuthMode authMode,
    required bool confirmedEmailMarketing,
    required String? profilePicUrl,
    required DateTime? birthDate,
    required String? countryPhoneCode,
    required String? countryLetterCode,
    required String? phone,
  }) =>
      AppUser(
        id: id,
        email: email,
        userName: userName,
        fullName: fullName,
        role: role,
        isLoading: true,
        authMode: authMode,
        confirmedEmailMarketing: confirmedEmailMarketing,
        birthDate: birthDate,
        countryPhoneCode: countryPhoneCode,
        countryLetterCode: countryLetterCode,
        phone: phone,
        profilePicUrl: profilePicUrl,
      );

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
