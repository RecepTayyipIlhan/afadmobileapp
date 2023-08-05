import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading/loading.dart';
import '../prov/forgot_pass_prov.dart';

import '../../../ui/widgets/btns/primary_btn.dart';
import '../../../ui/widgets/primary_field.dart';
import '../../../utils/utils.dart';

class ForgotPassScreen extends ConsumerWidget {
  const ForgotPassScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(forgotPassStateProvider);

    return Loading(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            getStr('auth:forgot_pass:title'),
          ),
        ),
        body: SafeArea(
          child: Form(
            key: formState.formKey,
            child: SingleChildScrollView(
              child: Container(
                margin: defPaddingAll,
                child: Column(
                  children: [
                    const _Fields(),
                    const _Btns(),
                  ].joinWidgetList(
                    (index) => const SizedBox(
                      height: defPaddingSize * 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Fields extends ConsumerWidget {
  const _Fields();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(forgotPassStateProvider.notifier);

    return Column(
      children: [
        PrimaryField(
          labelText: getStr('auth:forgot_pass:fields:email:title'),
          onChanged: notifier.emailOnChanged,
          validator: notifier.emailValidator,
        ),
      ].joinWidgetList(
        (index) => const SizedBox(
          height: defPaddingSize,
        ),
      ),
    );
  }
}

class _Btns extends ConsumerWidget {
  const _Btns();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(forgotPassStateProvider);
    final notifier = ref.watch(forgotPassStateProvider.notifier);

    return Column(
      children: [
        PrimaryBtn(
          isExpanded: true,
          onPressed: formState.isEmailLinkResendAllowed
              ? () {
                  notifier.submit(context);
                }
              : null,
          text: formState.isEmailLinkResendAllowed
              ? getStr('auth:forgot_pass:send_link_btn')
              : getStrArgs(
                  'auth:forgot_pass:send_link_btn:unsendable_seconds',
                  args: [
                    formState.emailLinkResendSecondsLeft.toString(),
                  ],
                ),
          eventName: 'auth:forgot_pass:send_link_btn',
        ),
      ].map(
        (e) {
          return Row(
            children: [
              Expanded(
                child: e,
              ),
            ].sandwich(
              bun: const SizedBox(
                width: defPaddingSize * 2,
              ),
            ),
          );
        },
      ).joinWidgetList(
        (index) => const SizedBox(
          height: defPaddingSize,
        ),
      ),
    );
  }
}
