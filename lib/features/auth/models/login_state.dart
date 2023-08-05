import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const LoginState._();

  const factory LoginState({
    String? email,
    String? pass,
    required GlobalKey<FormState> formKey,
  }) = _LoginState;

  factory LoginState.initial() => LoginState(
        formKey: GlobalKey<FormState>(),
      );
}
