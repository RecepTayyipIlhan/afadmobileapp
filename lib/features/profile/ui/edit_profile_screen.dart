import 'package:afad_app/app_runner.dart';
import 'package:afad_app/features/app_init/app_init_prov.dart';
import 'package:afad_app/features/auth/models/app_user.dart';
import 'package:afad_app/features/profile/prov/edit_profile_prov.dart';
import 'package:afad_app/ui/widgets/error_widget.dart';
import 'package:afad_app/ui/widgets/primary_dropdown.dart';
import 'package:afad_app/utils/app_theme.dart';
import 'package:afad_app/utils/icons/app_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading/loading.dart';
import '../../../ui/widgets/btns/primary_btn.dart';
import '../../../ui/widgets/primary_field.dart';
import '../../../utils/utils.dart';

import '../../../ui/widgets/primary_image_picker.dart';
import '../models/edit_profile_state.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    EditProfileState? formState;

    try {
      formState = ref.watch(editProfileStateProvider);
    } catch (e) {
      logger.e(e);

      formState = null;
    }

    return Loading(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            getStr('edit_profile:title'),
          ),
        ),
        body: SafeArea(
          child: formState == null
              ? const Center(child: ErrWidget.empty())
              : const _Body(),
        ),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(editProfileStateProvider);

    return Form(
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
    );
  }
}

class _Fields extends ConsumerWidget {
  const _Fields();

  bool get isAfad => selectedFlavor == Flavor.AFAD;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(editProfileStateProvider);
    final notifier = ref.watch(editProfileStateProvider.notifier);
    return Column(
      children: [
        SizedBox(
          height: 120,
          child: PrimaryImagePicker.ProfileImage(
            pickedImage: formState.profileImage,
            pickedImageUrl: formState.profileImageUrl,
            onImagePicked: notifier.profileImageOnChanged,
          ),
        ),
        PrimaryField(
          initialValue: formState.fullName,
          labelText: getStr('edit_profile:fields:fullname:title'),
          onChanged: notifier.fullnameOnChanged,
          validator: notifier.fullnameValidator,
        ),
        PrimaryField(
          labelText: getStr('edit_profile:fields:birthdate:title'),
          onTap: () => notifier.birthDateOnPressed(context),
          value: formState.birthDateFormatted(context),
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
            items: ref
                .watch(appInitStateProv)
                .iller!
                .map(
                  (e) => DropdownMenuItem(
                    value: e.plakaKodu,
                    child: Text(
                      e.ilAdi.toString(),
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
                      e.ilceAdi.toString(),
                    ),
                  ),
                )
                .toList(),
          ),
        PrimaryDropdown<BloodGroup>(
          initialValue: formState.bloodGroup,
          labelText: getStr('edit_profile:fields:bloodgroup:title'),
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
        PrimaryField(
          initialValue: formState.idNumber,
          labelText: getStr('edit_profile:fields:idnumber:title'),
          onChanged: notifier.idNumberOnChanged,
          validator: notifier.idNumberValidator,
          maxLines: 1,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        PrimaryField(
          initialValue: formState.phone,
          icon: SizedBox(
            width: 80,
            child: PrimaryField(
              initialValue: formState.countryPhoneCode,
              onTap: () => notifier.countryCodeOnPressed(context),
              value: formState.countryCodeFormatted(context),
              enabled: false,
              enabledStyle: true,
              textAlign: TextAlign.center,
            ),
          ),
          onChanged: notifier.phoneNumberOnChanged,
          labelText: getStr('edit_profile:fields:phone:title'),
          validator: notifier.phoneNumberValidator,
          keyboardType: TextInputType.phone,
        ),
        if (isAfad)
          PrimaryField(
            initialValue: formState.relativePhone,
            icon: SizedBox(
              width: 80,
              child: PrimaryField(
                initialValue: formState.relativeCountryPhoneCode,
                onTap: () => notifier.relativeCountryCodeOnPressed(context),
                value: formState.relativeCountryCodeFormatted(context),
                enabled: false,
                enabledStyle: true,
                textAlign: TextAlign.center,
              ),
            ),
            onChanged: notifier.relativePhoneNumberOnChanged,
            labelText: getStr('edit_profile:fields:relativephone:title'),
            validator: notifier.relativePhoneNumberValidator,
            keyboardType: TextInputType.phone,
          ),
        PrimaryDropdown<RelativeType>(
          initialValue: formState.relativeType,
          labelText: getStr('edit_profile:fields:relativetype:title'),
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
        if (isAfad)
          PrimaryField(
            initialValue: formState.peopleAtSameAddress,
            labelText: getStr('edit_profile:fields:peopleatsameaddress:title'),
            onChanged: notifier.peopleAtSameAddressOnChanged,
            validator: notifier.peopleAtSameAddressValidator,
            maxLines: 1,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        PrimaryField(
          initialValue: formState.address,
          labelText: getStr('edit_profile:fields:address:title'),
          onChanged: notifier.addressOnChanged,
          validator: notifier.addressValidator,
          maxLines: 3,
        ),
        if (isAfad)
          // optional
          PrimaryField(
            initialValue: formState.diseases,
            labelText: getStr('edit_profile:fields:diseases:title'),
            onChanged: notifier.diseasesOnChanged,
            maxLines: 1,
          ),
        if (isAfad)
          // optional
          PrimaryField(
            initialValue: formState.medicines,
            labelText: getStr('edit_profile:fields:medicines:title'),
            onChanged: notifier.medicinesOnChanged,
            maxLines: 1,
          ),
        if (isAfad)
          // optional
          PrimaryField(
            initialValue: formState.buildingAge,
            labelText: getStr('edit_profile:fields:buildingage:title'),
            onChanged: notifier.buildingAgeOnChanged,
            validator: notifier.buildingAgeValidator,
            maxLines: 1,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        if (isAfad)
          // optional
          PrimaryField(
            initialValue: formState.buildingDurability,
            labelText: getStr('edit_profile:fields:buildingdurability:title'),
            onChanged: notifier.buildingDurabilityOnChanged,
            maxLines: 1,
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
    final formState = ref.watch(editProfileStateProvider);
    final notifier = ref.watch(editProfileStateProvider.notifier);

    return Column(
      children: [
        ...[
          PrimaryBtn(
            isExpanded: true,
            onPressed: () => notifier.submit(context),
            text: getStr('edit_profile:submit_btn'),
            eventName: 'edit_profile:submit_btn',
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
