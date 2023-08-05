import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading/loading.dart';
import '../../../ui/widgets/snackbars.dart';
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

  void switchModeToLink() {
    state = state.copyWith(mode: AuthMode.emailLink);
  }

  void switchModeToPass() {
    state = state.copyWith(mode: AuthMode.emailPass);
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

    if (state.isModePass) {
      return _handlePassLogin(context);
    }

    if (state.isModeLink) {
      return _handleLinkLogin(context);
    }

    return false;
  }

  Future<bool> _handlePassLogin(BuildContext context) async {
    final res = await ref.read(authProvider.notifier).login(
          context: context,
          email: state.email!,
          password: state.pass!,
        );

    return res;
  }

  Timer? _emailLinkResendTimer;

  Future<bool> _handleLinkLogin(BuildContext context) async {
    try {
      Loading.load(context);

      final res = await ref.read(authProvider.notifier).sendEmailLoginLink(
            context: context,
            email: state.email!,
          );

      if (!res) {
        Loading.unload(context);

        return false;
      }

      state = state.copyWith(
        emailLinkResendSecondsLeft: state.emailLinkResendDuration.inSeconds,
      );

      if (_emailLinkResendTimer != null) {
        _emailLinkResendTimer!.cancel();
      }

      _emailLinkResendTimer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          state = state.copyWith(
            emailLinkResendSecondsLeft: state.emailLinkResendSecondsLeft! - 1,
          );

          if (state.emailLinkResendSecondsLeft == 0) {
            _emailLinkResendTimer!.cancel();
            timer.cancel();
          }
        },
      );

      Snackbars.showSuccessSnackBar(
        context,
        message: getStrArgs(
          'auth:login:email_link_sent',
          args: [state.email!],
        ),
      );

      Loading.unload(context);

      return res;
    } catch (e) {
      logger.e(e);

      Loading.unload(context);
      return false;
    }
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

  @override
  void dispose() {
    if (_emailLinkResendTimer != null) {
      _emailLinkResendTimer!.cancel();
    }

    super.dispose();
  }
}
