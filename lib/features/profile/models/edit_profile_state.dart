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
    required String userName,
    required String fullName,
    File? profileImage,
    String? profileImageUrl,
    DateTime? birthDate,
    String? countryPhoneCode,
    String? countryLetterCode,
    String? phone,
    required Ref ref,
    required GlobalKey<FormState> formKey,
    required AppUser user,
  }) = _EditProfileState;

  factory EditProfileState.fromAppUser({
    required AppUser user,
    required Ref ref,
  }) {
    return EditProfileState(
      formKey: GlobalKey<FormState>(),
      ref: ref,
      fullName: user.fullName,
      userName: user.userName,
      birthDate: user.birthDate,
      countryLetterCode: user.countryLetterCode,
      countryPhoneCode: user.countryPhoneCode,
      phone: user.phone,
      profileImageUrl: user.profilePicUrl,
      user: user,
    );
  }

  AppUser toAppUser() {
    return AppUser.fromEditProfileFormState(
      email: user.email,
      userName: userName,
      fullName: fullName,
      birthDate: birthDate,
      countryPhoneCode: countryPhoneCode,
      countryLetterCode: countryLetterCode,
      phone: phone,
      id: user.id,
      profilePicUrl: profileImageUrl,
      role: user.role,
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
}
