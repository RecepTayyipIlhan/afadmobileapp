import 'package:afad_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/prov/auth_prov.dart';

import '../models/delete_account_state.dart';

// TODO: having this property inside DeleteAccountState is not working for some reason.
// (the state is being set, but after the user goes and cliks the link, the value is being reset to null.
// this only happens in valid links, not in invalid links which are the one that are already used)
final deleteAccountSentAtDateProv = StateProvider<DateTime?>((ref) => null);

final deleteAccountProv =
    StateNotifierProvider<DeleteAccountProv, DeleteAccountState>(
  (ref) {
    return DeleteAccountProv(ref);
  },
);

DeleteAccountState _initialState(Ref ref) => DeleteAccountState.initial(
      authMode: ref.watch(authProvider).appUser?.authMode,
      ref: ref,
    );

class DeleteAccountProv extends StateNotifier<DeleteAccountState> {
  final Ref ref;
  DeleteAccountProv(this.ref) : super(_initialState(ref));

  void resetState() {
    state = _initialState(ref);
    ref.read(deleteAccountSentAtDateProv.notifier).state = null;
  }

  Future<void> handleInitial(BuildContext context) async {
    final user = ref.watch(authProvider).appUser;

    if (user == null) {
      logger.e('User is null');
      return;
    }

    final authMode = user.authMode;

    if (authMode.isEmailLink) {
      await handleSendEmailLoginLink(context);
    }
  }

  Future<bool> handleSendEmailLoginLink(BuildContext context) async {
    final user = ref.watch(authProvider).appUser;
    final email = user?.email;

    if (email == null) {
      logger.e('User is null');
      return false;
    }

    final isSent = await ref.read(authProvider.notifier).sendEmailLoginLink(
          context: context,
          email: email,
        );

    if (isSent) {
      ref.read(deleteAccountSentAtDateProv.notifier).state = DateTime.now();
    }

    return isSent;
  }

  Future<bool> onDeleteAccountLinkPressed() async {
    if (!state.isConfirmedEmail) {
      logger.e('user has not confirmed email');
    }

    final isDeleteSuccess =
        await ref.read(authProvider.notifier).deleteAccount();

    return isDeleteSuccess;
  }

  Future<bool> onDeleteAccountPassPressed(BuildContext context) async {
    final password = state.passState?.password;

    final email = ref.watch(authProvider).appUser?.email;

    if (email == null || password == null) {
      logger.e('User is null');
      return false;
    }

    final isReauthSuccess = await ref.read(authProvider.notifier).login(
          context: context,
          email: email,
          password: password,
        );

    if (!isReauthSuccess) {
      return false;
    }

    final isDeleteSuccess =
        await ref.read(authProvider.notifier).deleteAccount();

    return isDeleteSuccess;
  }

  bool onCancelPressed(BuildContext context) {
    resetState();

    Navigator.of(context).pop();

    return true;
  }

  Future<void> onPasswordChanged(String password) async {
    state = state.copyWith(
      passState: state.passState?.copyWith(
        password: password,
      ),
    );
  }

  Future<void> onPasswordSubmitted(BuildContext context) async {
    final isDeleteSuccess = await onDeleteAccountLinkPressed();

    if (isDeleteSuccess) {
      Navigator.of(context).pop();
    }
  }
}
