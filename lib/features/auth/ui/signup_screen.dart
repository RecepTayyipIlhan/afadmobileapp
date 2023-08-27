import 'package:afad_app/features/admin/models/il_ilce_model.dart';
import 'package:afad_app/features/app_init/app_init_prov.dart';
import 'package:afad_app/features/auth/models/app_user.dart';
import 'package:afad_app/ui/widgets/primary_dropdown.dart';
import 'package:afad_app/utils/app_theme.dart';
import 'package:afad_app/utils/icons/app_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading/loading.dart';
import '../../../ui/widgets/btns/auth_icon_btn.dart';
import '../../../ui/widgets/btns/primary_btn.dart';
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
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    // the height of the screen - safearea - keyboard
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.vertical,
                  ),
                  child: Builder(builder: (context) {
                    // this is a disgusting thing. flutter is breaking
                    // when giving a maxwidth of 500 to screens that
                    // are smaller than 500. so we have to do this
                    // disgusting thing.
                    final w = MediaQuery.of(context).size.width;
                    if (w < 500) {
                      return const _Bod();
                    }

                    return Row(
                      children: [
                        const Expanded(
                          child: SizedBox(),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 500,
                          ),
                          child: const _Bod(),
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Bod extends StatelessWidget {
  const _Bod();

  @override
  Widget build(BuildContext context) {
    return Container(
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
            SizedBox(
              height: 120,
              child: PrimaryImagePicker.ProfileImage(
                pickedImage: formState.profileImage,
                onImagePicked: notifier.profileImageOnChanged,
              ),
            ),
          if (formState.showFullNameField)
            PrimaryField(
              labelText: getStr('auth:signup:fields:fullname:title'),
              onChanged: notifier.fullnameOnChanged,
              validator: notifier.fullnameValidator,
              maxLines: 1,
            ),
          if (formState.showBloodGroupField)
            PrimaryDropdown<BloodGroup>(
              labelText: getStr('auth:signup:fields:bloodgroup:title'),
              onChanged: notifier.bloodGroupOnChanged,
              validator: notifier.bloodGroupValidator,
              items: BloodGroup.values
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        getStr(
                          e.toString(),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          if (formState.showIdNumberField)
            PrimaryField(
              labelText: getStr('auth:signup:fields:idnumber:title'),
              onChanged: notifier.idNumberOnChanged,
              validator: notifier.idNumberValidator,
              maxLines: 1,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          if (formState.showBirthDateField)
            PrimaryField(
              labelText: getStr('auth:signup:fields:birthdate:title'),
              onTap: () => notifier.birthDateOnPressed(context),
              value: formState.birthDateFormatted(context),
              validator: notifier.birthDateValidator,
              enabled: false,
              enabledStyle: true,
              suffixIcon: Icon(
                AppIcons.profile_edit_calendar,
                color: Theme.of(context).editProfileFieldsSuffixIconColor,
              ),
            ),
          if (formState.showPlakaKoduField)
            PrimaryDropdown<String>(
              labelText: getStr('auth:signup:fields:plakakodu:title'),
              onChanged: notifier.plakaKoduOnChanged,
              validator: notifier.plakaKoduValidator,
              initialValue: formState.plakaKodu,
              key: formState.plakaKodu != null
                  ? Key(formState.plakaKodu.toString())
                  : null,
              items: ref
                  .watch(appInitStateProv)
                  .iller!
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.plakaKodu,
                      child: Text(
                        getStr(
                          e.ilAdi.toString(),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          if (formState.showIlceKoduField)
            PrimaryDropdown<String>(
              labelText: getStr('auth:signup:fields:ilcekodu:title'),
              onChanged: notifier.ilceKoduOnChanged,
              validator: notifier.ilceKoduValidator,
              initialValue: formState.ilceKodu,
              key: formState.ilceKodu != null
                  ? Key(formState.ilceKodu.toString())
                  : null,
              items: ref
                  .watch(appInitStateProv)
                  .iller!
                  .firstWhere(
                      (element) => element.plakaKodu == formState.plakaKodu)
                  .ilceler
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.ilceKodu,
                      child: Text(
                        getStr(
                          e.ilceAdi.toString(),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          if (formState.showPhoneField) ...[
            PrimaryField(
              icon: SizedBox(
                width: 80,
                child: PrimaryField(
                  onTap: () => notifier.countryCodeOnPressed(context),
                  value: formState.countryCodeFormatted(context),
                  enabled: false,
                  enabledStyle: true,
                  textAlign: TextAlign.center,
                ),
              ),
              onChanged: notifier.phoneNumberOnChanged,
              labelText: getStr('auth:signup:fields:phone:title'),
              validator: notifier.phoneNumberValidator,
              keyboardType: TextInputType.phone,
            ),
          ],
          if (formState.showRelativePhoneField) ...[
            PrimaryField(
              icon: SizedBox(
                width: 80,
                child: PrimaryField(
                  onTap: () => notifier.relativeCountryCodeOnPressed(context),
                  value: formState.relativeCountryCodeFormatted(context),
                  enabled: false,
                  enabledStyle: true,
                  textAlign: TextAlign.center,
                ),
              ),
              onChanged: notifier.relativePhoneNumberOnChanged,
              labelText: getStr('auth:signup:fields:relativephone:title'),
              validator: notifier.relativePhoneNumberValidator,
              keyboardType: TextInputType.phone,
            ),
          ],
          if (formState.showRelativeTypeField) ...[
            PrimaryDropdown<RelativeType>(
              labelText: getStr('auth:signup:fields:relativetype:title'),
              onChanged: notifier.relativeTypeOnChanged,
              validator: notifier.relativeTypeValidator,
              items: RelativeType.values
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        getStr(
                          e.toString(),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
          if (formState.showPeopleAtSameAddressField) ...[
            PrimaryField(
              labelText: getStr('auth:signup:fields:peopleatsameaddress:title'),
              onChanged: notifier.peopleAtSameAddressOnChanged,
              validator: notifier.peopleAtSameAddressValidator,
              maxLines: 1,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ],
          if (formState.showAddressField) ...[
            PrimaryField(
              labelText: getStr('auth:signup:fields:address:title'),
              onChanged: notifier.addressOnChanged,
              validator: notifier.addressValidator,
              maxLines: 3,
            ),
          ],
          // optional
          if (formState.showDiseasesField) ...[
            PrimaryField(
              labelText: getStr('auth:signup:fields:diseases:title'),
              onChanged: notifier.diseasesOnChanged,
              maxLines: 1,
            ),
          ],
          // optional
          if (formState.showMedicinesField) ...[
            PrimaryField(
              labelText: getStr('auth:signup:fields:medicines:title'),
              onChanged: notifier.medicinesOnChanged,
              maxLines: 1,
            ),
          ],
          // optional
          if (formState.showBuildingAgeField) ...[
            PrimaryField(
              labelText: getStr('auth:signup:fields:buildingage:title'),
              onChanged: notifier.buildingAgeOnChanged,
              validator: notifier.buildingAgeValidator,
              maxLines: 1,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ],
          // optional
          if (formState.showBuildingDurabilityField) ...[
            PrimaryField(
              labelText: getStr('auth:signup:fields:buildingdurability:title'),
              onChanged: notifier.buildingDurabilityOnChanged,
              maxLines: 1,
            ),
          ],
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
