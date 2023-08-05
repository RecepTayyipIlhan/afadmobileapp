import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading/loading.dart';
import '../../../utils/extensions/auth_extensions.dart';

import '../../../utils/prov/auth_prov.dart';
import '../../../utils/utils.dart';
import '../models/login_state.dart';

final loginStateProvider =
    StateNotifierProvider<LoginStateNotifier, LoginState>(
  LoginStateNotifier.new,
);

class LoginStateNotifier extends StateNotifier<LoginState> {
  final Ref ref;
  LoginStateNotifier(this.ref) : super(LoginState.initial());

  bool get isValid {
    if (state.formKey.currentState?.validate() != true) {
      return false;
    }

    return true;
  }

  Future<bool> loginWithGoogle(BuildContext context) async {
    try {
      Loading.load(context);

      final res = await ref.read(authProvider.notifier).loginWithGoogle(
            context: context,
          );

      Loading.unload(context);

      return res;
    } catch (e) {
      logger.e(e);

      Loading.unload(context);
      return false;
    }
  }

  Future<bool> loginWithApple(BuildContext context) async {
    try {
      Loading.load(context);

      final res = await ref.read(authProvider.notifier).loginWithApple(
            context: context,
          );

      Loading.unload(context);

      return res;
    } catch (e) {
      logger.e(e);

      Loading.unload(context);
      return false;
    }
  }

  Future<bool> submit(BuildContext context) async {
    if (isValid == false) {
      return false;
    }

    return _handlePassLogin(context);
  }

  Future<bool> _handlePassLogin(BuildContext context) async {
    final res = await ref.read(authProvider.notifier).login(
          context: context,
          email: state.email!,
          password: state.pass!,
        );

    return res;
  }

  void loginWithLink(BuildContext context) async {}

  void emailOnChanged(String value) {
    state = state.copyWith(email: value);
  }

  void passOnChanged(String value) {
    state = state.copyWith(pass: value);
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('auth:login:validator:null:email');
    }

    if (value.isEmailValid != true) {
      return getStr('auth:login:validator:invalid:email');
    }

    return null;
  }

  String? passValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('auth:login:validator:invalid:password');
    }

    if (value.isPasswordValid != true) {
      return getStr('auth:login:validator:invalid:password');
    }

    return null;
  }
}
