import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'auth_mode.dart';

import '../../../utils/prov/auth_prov.dart';
import '../prov/delete_account_prov.dart';

part 'delete_account_state.freezed.dart';

@freezed
class DeleteAccountState with _$DeleteAccountState {
  const DeleteAccountState._();

  const factory DeleteAccountState({
    required AuthMode? authMode,
    required Ref ref,
    required DeleteAccountPassState? passState,
  }) = _DeleteAccountState;

  factory DeleteAccountState.initial({
    required AuthMode? authMode,
    required Ref ref,
  }) =>
      DeleteAccountState(
        authMode: authMode,
        ref: ref,
        passState: authMode?.isEmailPass == true
            ? DeleteAccountPassState.initial(ref: ref)
            : null,
      );

  DateTime? get confirmEmailSentAt => ref.watch(deleteAccountSentAtDateProv);

  bool get isSendingConfirmEmail {
    return isEmailLink && !isConfirmedEmail && confirmEmailSentAt == null;
  }

  bool get isSentConfirmEmail {
    return isEmailLink && !isConfirmedEmail && confirmEmailSentAt != null;
  }

  bool get isConfirmedEmail {
    final lastLogin = ref.watch(authProvider).lastLoginAt;

    if (confirmEmailSentAt == null) {
      return false;
    }

    return isEmailLink &&
        lastLogin != null &&
        lastLogin.isAfter(confirmEmailSentAt!);
  }

  String? get email => ref.watch(authProvider).appUser?.email;

  bool get isEmailLink => authMode?.isEmailLink == true;
  bool get isEmailPass => authMode?.isEmailPass == true;
}

@freezed
class DeleteAccountPassState with _$DeleteAccountPassState {
  const DeleteAccountPassState._();

  const factory DeleteAccountPassState({
    required Ref ref,
    String? password,
  }) = _DeleteAccountPassState;

  factory DeleteAccountPassState.initial({
    required Ref ref,
  }) =>
      DeleteAccountPassState(
        ref: ref,
      );

  String? get email => ref.watch(authProvider).appUser?.email;
}
