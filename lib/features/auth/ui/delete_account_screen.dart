import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../ui/widgets/btns/primary_btn.dart';
import '../../../ui/widgets/btns/secondary_btn.dart';
import '../../../ui/widgets/primary_field.dart';
import '../../../utils/utils.dart';

import '../prov/delete_account_prov.dart';

class DeleteAccountScreen extends ConsumerWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(deleteAccountProv);

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        constraints: const BoxConstraints(minHeight: 200),
        padding: defPaddingAll,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (formState.isEmailLink) const _EmailLink(),
            if (formState.isEmailPass) const _EmailPass(),
          ],
        ),
      ),
    );
  }
}

class _EmailLink extends ConsumerWidget {
  const _EmailLink();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(deleteAccountProv);
    final notifier = ref.watch(deleteAccountProv.notifier);

    return Column(
      children: [
        Text(
          getStr('auth:delete_account:title'),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          getStr('auth:delete_account:mode_link:subtitle'),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        if (formState.isSendingConfirmEmail) ...[
          Text(
            getStr('auth:delete_account:mode_link:sending_email_link'),
          ),
        ],
        if (formState.isSentConfirmEmail && formState.email != null) ...[
          Text(
            getStrArgs(
              'auth:delete_account:mode_link:email_link_sent',
              args: [formState.email!],
            ),
          ),
        ],
        if (formState.isConfirmedEmail) ...[
          Text(
            getStr('auth:delete_account:mode_link:confirm_message'),
          ),
          PrimaryBtn(
            onPressed: notifier.onDeleteAccountLinkPressed,
            text: getStr('auth:delete_account:mode_link:confirm_btn'),
            eventName: 'auth:delete_account:mode_link:confirm_btn',
          ),
          SecondaryBtn(
            onPressed: () => notifier.onCancelPressed(context),
            text: getStr('auth:delete_account:mode_link:cancel_btn'),
            eventName: 'auth:delete_account:mode_link:cancel_btn',
          ),
        ]
      ].joinWidgetList(
        (index) => const SizedBox(
          height: halfDefPaddingSize,
        ),
      ),
    );
  }
}

class _EmailPass extends ConsumerWidget {
  const _EmailPass();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(deleteAccountProv.notifier);

    return Column(
      children: [
        Text(
          getStr('auth:delete_account:title'),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          getStr('auth:delete_account:mode_pass:subtitle'),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        PrimaryField(
          onChanged: notifier.onPasswordChanged,
        ),
        PrimaryBtn(
          onPressed: () => notifier.onDeleteAccountPassPressed(context),
          text: getStr('auth:delete_account:mode_pass:delete_btn'),
          eventName: 'auth:delete_account:mode_pass:delete_btn',
        ),
        SecondaryBtn(
          onPressed: () => notifier.onCancelPressed(context),
          text: getStr('auth:delete_account:mode_pass:cancel_btn'),
          eventName: 'auth:delete_account:mode_pass:cancel_btn',
        ),
      ].joinWidgetList(
        (index) => const SizedBox(
          height: halfDefPaddingSize,
        ),
      ),
    );
  }
}
