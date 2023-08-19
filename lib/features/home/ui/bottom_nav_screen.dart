import 'package:afad_app/features/education_videos/ui/education_videos_screen.dart';
import 'package:afad_app/features/home/models/bottom_bar/bottom_bar_index.dart';
import 'package:afad_app/features/profile/ui/profile_screen.dart';
import 'package:afad_app/services/bluetooth/devices_screen.dart';
import 'package:afad_app/utils/app_theme.dart';
import 'package:afad_app/utils/icons/app_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/utils.dart';
import '../prov/bottom_bar_prov.dart';

class BottomNavScreen extends ConsumerWidget {
  const BottomNavScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bottomBarStateProvider);
    final notifier = ref.read(bottomBarStateProvider.notifier);

    Widget bod;

    switch (state.bottomBarIndex) {
      case BottomBarIndex.devices:
        bod = const DevicesScreen();
        break;
      case BottomBarIndex.educationVideos:
        bod = const EducationVideosScreen();
        break;
      case BottomBarIndex.profile:
        bod = const ProfileScreen();
        break;
    }

    return Scaffold(
      body: bod,
      bottomNavigationBar: ClipRRect(
        borderRadius: Theme.of(context).bottomBarBorderRadius,
        // TODO: spread items
        child: BottomNavigationBar(
          backgroundColor: Theme.of(context).bottomBarBgColor,
          selectedItemColor: Theme.of(context).bottomBarSelectedIconColor,
          unselectedItemColor: Theme.of(context).bottomBarUnSelectedIconColor,
          onTap: notifier.onBottomBarTap,
          currentIndex: state.bottomBarIndex.index,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.devices_other),
              label: getStr('bottom_bar_items:devices'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.cast_for_education),
              label: getStr('bottom_bar_items:education_videos'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(AppIcons.tabbar_profile),
              label: getStr('bottom_bar_items:profile'),
            ),
          ],
        ),
      ),
    );
  }
}
