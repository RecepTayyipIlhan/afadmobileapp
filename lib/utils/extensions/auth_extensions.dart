extension AuthString on String {
  bool get isEmailValid => RegExp(
        r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      ).hasMatch(this);

  bool get isPasswordValid => length >= 6;

  bool get isPhoneNumberValid {
    final regex = RegExp(r'^[0-9]{6,20}$');

    return regex.hasMatch(this);
  }

  // never assume anything about the user's name,
  bool get isFullNameValid => length >= 3;
}
