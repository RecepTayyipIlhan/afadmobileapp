import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading/loading.dart';
import '../models/forgot_pass_state.dart';
import '../../../utils/extensions/auth_extensions.dart';
import '../../../utils/prov/auth_prov.dart';

import '../../../ui/widgets/snackbars.dart';
import '../../../utils/utils.dart';

final forgotPassStateProvider =
    StateNotifierProvider<ForgotPassStateNotifier, ForgotPassState>(
  (ref) {
    return ForgotPassStateNotifier(ref);
  },
);

class ForgotPassStateNotifier extends StateNotifier<ForgotPassState> {
  ForgotPassStateNotifier(this.ref) : super(ForgotPassState.initial());

  final Ref ref;

  void emailOnChanged(String value) {
    state = state.copyWith(email: value);
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return getStr('auth:forgot_pass:validator:null:email');
    }

    if (value.isEmailValid != true) {
      return getStr('auth:forgot_pass:validator:invalid:email');
    }

    return null;
  }

  Timer? _emailLinkResendTimer;

  Future<bool> submit(BuildContext context) async {
    try {
      Loading.load(context);

      final isSent = await ref.read(authProvider.notifier).resetPassword(
            context: context,
            email: state.email,
          );

      if (!isSent) {
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
          'auth:forgot_pass:email_link_sent',
          args: [state.email],
        ),
      );

      Loading.unload(context);

      return isSent;
    } catch (e) {
      logger.e(e);
      Loading.unload(context);
      return false;
    }
  }
}
