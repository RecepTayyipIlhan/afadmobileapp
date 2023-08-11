import 'package:afad_app/features/profile/prov/edit_profile_prov.dart';
import 'package:afad_app/ui/widgets/error_widget.dart';
import 'package:afad_app/utils/app_theme.dart';
import 'package:afad_app/utils/icons/app_icons_icons.dart';
import 'package:flutter/material.dart';
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
