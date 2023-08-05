import 'package:afad_app/utils/app_theme.dart';
import 'package:afad_app/utils/icons/app_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading/loading.dart';
import '../../../ui/widgets/btns/auth_icon_btn.dart';
import '../../../ui/widgets/btns/primary_btn.dart';
import '../../../ui/widgets/btns/secondary_btn.dart';
import '../../../ui/widgets/primary_field.dart';
import '../../../utils/utils.dart';

import '../../../ui/widgets/primary_image_picker.dart';
import '../prov/signup_prov.dart';

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(signupStateProvider);

    return WillPopScope(
      onWillPop: () async {
        if (formState.isInfoStep) {
          return false;
        }

        return true;
      },
      child: Loading(
        child: Scaffold(
          appBar: AppBar(
            // we do not want to show the back button when we are on the info step
            automaticallyImplyLeading: formState.isEmailStep,
            title: Text(
              getStr('auth:signup:title'),
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
      ),
    );
  }
}

class _Fields extends ConsumerWidget {
  const _Fields();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(signupStateProvider);
    final notifier = ref.watch(signupStateProvider.notifier);

    return Column(
      children: [
        // email step
        ...[
          if (formState.showEmailField)
            PrimaryField(
              labelText: getStr('auth:signup:fields:email:title'),
              onChanged: notifier.emailOnChanged,
              validator: notifier.emailValidator,
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
            ),
          if (formState.showPassField)
            PrimaryField(
              isPassword: true,
              labelText: getStr('auth:signup:fields:password:title'),
              onChanged: notifier.passOnChanged,
              validator: notifier.passValidator,
              maxLines: 1,
            ),
        ],
        // info step
        ...[
          if (formState.showProfileImageField)
            Container(
              height: 120,
              child: PrimaryImagePicker.ProfileImage(
                pickedImage: formState.profileImage,
                onImagePicked: notifier.profileImageOnChanged,
              ),
            ),
          if (formState.showUserNameField)
            PrimaryField(
              labelText: getStr('auth:signup:fields:username:title'),
              onChanged: notifier.usernameOnChanged,
              validator: notifier.usernameValidator,
              maxLines: 1,
            ),
          if (formState.showFullNameField)
            PrimaryField(
              labelText: getStr('auth:signup:fields:fullname:title'),
              onChanged: notifier.fullnameOnChanged,
              validator: notifier.fullnameValidator,
              maxLines: 1,
            ),
          if (formState.showBirthDateField)
            PrimaryField(
              labelText: getStr('auth:signup:fields:birthdate:title'),
              onTap: () => notifier.birthDateOnPressed(context),
              value: formState.birthDateFormatted(context),
              enabled: false,
              enabledStyle: true,
              suffixIcon: Icon(
                AppIcons.profile_edit_calendar,
                color: Theme.of(context).editProfileFieldsSuffixIconColor,
              ),
            ),
        ],
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
    final formState = ref.watch(signupStateProvider);
    final notifier = ref.watch(signupStateProvider.notifier);

    return Column(
      children: [
        PrimaryBtn(
          isExpanded: true,
          onPressed: () => notifier.submit(context),
          text: getStr('auth:signup:signup_btn'),
          eventName: 'auth:signup:signup_btn',
        ),
        ...[
          if (formState.isEmailStep)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // AuthIconBtn(
                //   eventName: 'apple log in',
                //   icon: FontAwesomeIcons.apple,
                //   onPressed: () {
                //     notifier.loginWithApple(context);
                //   },
                // ),
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
        ).toList(),
      ].joinWidgetList(
        (index) => const SizedBox(
          height: defPaddingSize,
        ),
      ),
    );
  }
}
