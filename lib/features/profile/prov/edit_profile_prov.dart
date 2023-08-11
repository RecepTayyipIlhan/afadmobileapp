import 'dart:async';
import 'dart:io';

import 'package:afad_app/features/auth/models/app_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/cloud_storage_service.dart';
import '../../../utils/extensions/auth_extensions.dart';
import '../../../utils/prov/auth_prov.dart';
import '../../../utils/utils.dart';
import '../models/edit_profile_state.dart';

final editProfileStateProvider =
    StateNotifierProvider<EditProfileStateNotifier, EditProfileState>(
  (ref) {
    final appUser = ref.watch(authProvider).appUser;

    if (appUser == null) {
      throw Exception('appUser is null');
    }

    return EditProfileStateNotifier(ref, appUser);
  },
);

class EditProfileStateNotifier extends StateNotifier<EditProfileState> {
  final Ref ref;
  EditProfileStateNotifier(this.ref, AppUser user)
      : super(
          EditProfileState.fromAppUser(
            ref: ref,
            user: user,
          ),
        );

  Future<bool> submit(BuildContext context) async {
    if (state.isValid == false) {
      return false;
    }

    final fbUser = ref.read(authProvider).firebaseUser!;

    final appUser = state.toAppUser();

    final profileImg = state.profileImage;

    final created = await ref.read(authProvider.notifier).editProfile(
          context: context,
          appUser: appUser,
          fbUser: fbUser,
        );

    if (profileImg != null) {
      await ref.read(fbStorageService).uploadUserProfileImage(profileImg);
    }

    return created;
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

  String? fullnameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('edit_profile:invalid:fullname');
    }

    if (value.isFullNameValid != true) {
      return getStr('edit_profile:invalid:fullname');
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
      return getStr('edit_profile:invalid:phone');
    }

    // if the phone number is not null, then the country code
    // must be valid
    // we don't wanna put this under the country code picker
    // as it does not fit
    if ((state.countryPhoneCode == null || state.countryPhoneCode!.isEmpty)) {
      return getStr('edit_profile:empty:country_code');
    }

    return null;
  }
}
