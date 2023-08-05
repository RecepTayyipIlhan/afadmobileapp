import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'auth_mode.dart';
export 'auth_mode.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const LoginState._();

  const factory LoginState({
    String? email,
    String? pass,
    required GlobalKey<FormState> formKey,
    required AuthMode mode,
    int? emailLinkResendSecondsLeft,
  }) = _LoginState;

  factory LoginState.initial() => LoginState(
        formKey: GlobalKey<FormState>(),
        mode: AuthMode.emailLink,
      );

  Duration get emailLinkResendDuration => const Duration(seconds: 30);

  bool get isEmailLinkResendAllowed =>
      emailLinkResendSecondsLeft == null || emailLinkResendSecondsLeft! <= 0;

  bool get showPassField => mode == AuthMode.emailPass;

  bool get isModeLink => mode == AuthMode.emailLink;
  bool get isModePass => mode == AuthMode.emailPass;
}
