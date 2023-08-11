import 'package:afad_app/features/profile/models/profile_state.dart';
import 'package:afad_app/utils/app_theme.dart';
import 'package:afad_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../prov/profile_state_prov.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const _UserInfo(),
            const SizedBox(
              height: defPaddingSize * 3,
            ),
            const _Items(),
          ],
        ),
      ),
    );
  }
}

class _UserInfo extends ConsumerWidget {
  const _UserInfo();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileStateProvider);

    return Column(
        children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ProfileImg(state: state),
        ],
      ),
      Column(
        children: [
          if (state.fullName != null)
            Text(
              state.fullName!,
              style: Theme.of(context).textTheme.titleLarge,
            ),
        ].joinWidgetList(
          (e) => const SizedBox(
            height: quartDefPaddingSize,
          ),
        ),
      ),
    ].joinWidgetList(
      (e) => const SizedBox(
        height: defPaddingSize,
      ),
    ));
  }
}

class _ProfileImg extends StatelessWidget {
  const _ProfileImg({
    required this.state,
  });

  final ProfileState state;

  @override
  Widget build(BuildContext context) {
    const size = 120.0;
    // putting a border is not working,
    // and it is not a big deal
    const borderSize = 21.0;
    const imageSize = size - borderSize;
    return Container(
      height: size,
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Theme.of(context).profileImageBorderColor,
        child: state.photoUrl == null
            ? null
            : ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  state.photoUrl!,
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}

class _Items extends ConsumerWidget {
  const _Items();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(profileStateProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: notifier.items().map(
        (e) {
          return ListTile(
            onTap: () async {
              await e.onTap(context);
            },
            title: Text(
              e.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: e.isDangerous
                        ? Theme.of(context).profileItemDangerTextColor
                        : Theme.of(context).profileItemNoDangerTextColor,
                  ),
            ),
          );
        },
      ).joinWidgetList(
        (e) => const Divider(),
      ),
    );
  }
}
