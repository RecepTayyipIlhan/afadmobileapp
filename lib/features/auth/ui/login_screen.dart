import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading/loading.dart';
import '../../../ui/widgets/btns/auth_icon_btn.dart';
import '../../../ui/widgets/btns/text_btn.dart';
import '../prov/login_prov.dart';
import '../../../ui/widgets/primary_field.dart';
import '../../../utils/utils.dart';

import '../../../ui/widgets/btns/primary_btn.dart';
import '../../../ui/widgets/btns/secondary_btn.dart';
import '../../../utils/route_table.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(loginStateProvider);

    return Loading(
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: formState.formKey,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  // the height of the screen - safearea - keyboard
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.vertical,
                ),
                child: Container(
                  margin: defPaddingAll,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            getStr('auth:login:title'),
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const _Fields(),
                          const _Btns(),
                        ].joinWidgetList(
                          (index) => const SizedBox(
                            height: defPaddingSize * 2,
                          ),
                        ),
                      ),
                      // makes sense when keyboard is open
                      const SizedBox(
                        height: defPaddingSize,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            getStr('auth:login:dont_have_an_account:text_part'),
                          ),
                          TextBtn(
                            text: getStr(
                                'auth:login:dont_have_an_account:button_part'),
                            onPressed: () {
                              GoRouter.of(context).pushNamed(
                                RouteTable.rSignupScreen,
                              );
                            },
                            eventName:
                                'auth:login:dont_have_an_account:button_part',
                          ),
                        ],
                      ),
                    ],
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
    final formState = ref.watch(loginStateProvider);
    final notifier = ref.watch(loginStateProvider.notifier);

    return Column(
      children: [
        // fields
        ...[
          PrimaryField(
            labelText: getStr('auth:login:fields:email:title'),
            onChanged: notifier.emailOnChanged,
            validator: notifier.emailValidator,
            maxLines: 1,
            keyboardType: TextInputType.emailAddress,
          ),
          if (formState.showPassField)
            PrimaryField(
              labelText: getStr('auth:login:fields:password:title'),
              onChanged: notifier.passOnChanged,
              validator: notifier.passValidator,
              isPassword: true,
              maxLines: 1,
            ),
        ].joinWidgetList(
          (index) => const SizedBox(
            height: defPaddingSize,
          ),
        ),
        // forgot pass
        ...[
          Row(
            children: [
              TextBtn(
                text: getStr('auth:login:forgot_password'),
                onPressed: () {
                  GoRouter.of(context).pushNamed(
                    RouteTable.rForgotPassScreen,
                  );
                },
                eventName: 'auth:login:forgot_password',
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _Btns extends ConsumerWidget {
  const _Btns();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(loginStateProvider);
    final notifier = ref.watch(loginStateProvider.notifier);

    return Column(
      children: [
        // submit btns
        ...[
          if (formState.isModeLink)
            PrimaryBtn(
              isExpanded: true,
              onPressed: formState.isEmailLinkResendAllowed
                  ? () {
                      notifier.submit(context);
                    }
                  : null,
              text: formState.isEmailLinkResendAllowed
                  ? getStr('auth:login:send_link_btn')
                  : getStrArgs(
                      'auth:login:send_link_btn:unsendable_seconds',
                      args: [
                        formState.emailLinkResendSecondsLeft.toString(),
                      ],
                    ),
              eventName: 'auth:login:send_link_btn',
            ),
          if (formState.isModePass)
            PrimaryBtn(
              isExpanded: true,
              onPressed: () => notifier.submit(context),
              text: getStr('auth:login:login_btn'),
              eventName: 'auth:login:login_btn',
            ),
        ],
        // mode switchers
        ...[
          if (formState.isModePass)
            SecondaryBtn(
              isExpanded: true,
              onPressed: notifier.switchModeToLink,
              text: getStr('auth:login:login_use_link_btn'),
              eventName: 'auth:login:login_use_link_btn',
            ),
          if (formState.isModeLink)
            SecondaryBtn(
              isExpanded: true,
              onPressed: notifier.switchModeToPass,
              text: getStr('auth:login:login_use_pass_btn'),
              eventName: 'auth:login:login_use_pass_btn',
            ),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthIconBtn(
              eventName: 'apple log in',
              icon: FontAwesomeIcons.apple,
              onPressed: () {
                notifier.loginWithApple(context);
              },
            ),
            AuthIconBtn(
              eventName: 'google log in',
              icon: FontAwesomeIcons.google,
              onPressed: () {
                notifier.loginWithGoogle(context);
              },
            ),
          ],
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
