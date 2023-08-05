enum AuthMode {
  emailPass,
  emailLink;

  bool get isEmailLink => this == AuthMode.emailLink;
  bool get isEmailPass => this == AuthMode.emailPass;
}
