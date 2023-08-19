import 'dart:async';
import 'dart:io';

import 'package:afad_app/features/auth/models/app_user.dart';
import 'package:country_picker/country_picker.dart';
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

    var appUser = state.toAppUser();

    final profileImg = state.profileImage;

    final auth = ref.read(authProvider.notifier);
    final storage = ref.read(fbStorageService);

    if (profileImg != null) {
      final imageUrl = await storage.uploadUserProfileImage(profileImg);

      appUser = appUser.copyWith(profilePicUrl: imageUrl);
    }

    final created = await auth.editProfile(
      context: context,
      appUser: appUser,
      fbUser: fbUser,
    );

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

  String? fullnameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('edit_profile:invalid:fullname');
    }

    if (value.isFullNameValid != true) {
      return getStr('edit_profile:invalid:fullname');
    }

    return null;
  }

  String? birthDateValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('edit_profile:validator:invalid:birth_date');
    }

    return null;
  }

  String? bloodGroupValidator(BloodGroup? value) {
    if (value == null) {
      return getStr('edit_profile:validator:invalid:blood_group');
    }

    return null;
  }

  String? idNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('edit_profile:validator:invalid:id_number');
    }

    if (value.isIdNumberValid != true) {
      return getStr('edit_profile:validator:invalid:id_number');
    }

    return null;
  }

  String? relativeTypeValidator(RelativeType? value) {
    if (value == null) {
      return getStr('edit_profile:validator:invalid:relative_type');
    }

    return null;
  }

  String? relativePhoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('edit_profile:validator:invalid:phone');
    }

    if (value.isPhoneNumberValid != true) {
      return getStr('edit_profile:validator:invalid:phone');
    }

    if ((state.relativeCountryPhoneCode == null ||
        state.relativeCountryPhoneCode!.isEmpty)) {
      return getStr('edit_profile:validator:empty:country_code');
    }

    return null;
  }

  String? peopleAtSameAddressValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('edit_profile:validator:invalid:people_at_same_address');
    }

    if (int.tryParse(value) == null) {
      return getStr('edit_profile:validator:invalid:people_at_same_address');
    }

    return null;
  }

  String? addressValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('edit_profile:validator:invalid:address');
    }

    return null;
  }

  String? buildingAgeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (int.tryParse(value) == null) {
      return getStr('edit_profile:validator:invalid:building_age');
    }

    return null;
  }

  String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('edit_profile:validator:invalid:phone');
    }

    if (value.isPhoneNumberValid != true) {
      return getStr('edit_profile:validator:invalid:phone');
    }

    // if the phone number is not null, then the country code
    // must be valid
    // we don't wanna put this under the country code picker
    // as it does not fit
    if ((state.countryPhoneCode == null || state.countryPhoneCode!.isEmpty)) {
      return getStr('edit_profile:validator:empty:country_code');
    }

    return null;
  }

  String? relativePhoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('edit_profile:validator:invalid:phone');
    }

    if (value.isPhoneNumberValid != true) {
      return getStr('edit_profile:validator:invalid:phone');
    }

    // if the phone number is not null, then the country code
    // must be valid
    // we don't wanna put this under the country code picker
    // as it does not fit
    if ((state.relativeCountryPhoneCode == null ||
        state.relativeCountryPhoneCode!.isEmpty)) {
      return getStr('edit_profile:validator:empty:country_code');
    }

    return null;
  }
}
