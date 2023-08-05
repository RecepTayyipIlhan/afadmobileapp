import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_pass_state.freezed.dart';

@freezed
class ForgotPassState with _$ForgotPassState {
  const factory ForgotPassState({
    required String email,
    required GlobalKey<FormState> formKey,
    int? emailLinkResendSecondsLeft,
  }) = _ForgotPassState;

  const ForgotPassState._();

  factory ForgotPassState.initial() => ForgotPassState(
        email: '',
        formKey: GlobalKey<FormState>(),
      );

  Duration get emailLinkResendDuration => const Duration(seconds: 30);

  bool get isEmailLinkResendAllowed =>
      emailLinkResendSecondsLeft == null || emailLinkResendSecondsLeft! <= 0;
}
