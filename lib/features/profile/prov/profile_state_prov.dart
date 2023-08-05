import 'package:afad_app/utils/extensions/pretty_extensions.dart';
import 'package:afad_app/utils/route_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/prov/auth_prov.dart';
import '../../../utils/utils.dart';
import '../models/profile_item.dart';
import '../models/profile_state.dart';

final profileStateProvider =
    StateNotifierProvider<ProfileStateNotifier, ProfileState>(
  ProfileStateNotifier.new,
);

class ProfileStateNotifier extends StateNotifier<ProfileState> {
  final Ref ref;
  ProfileStateNotifier(this.ref)
      : super(
          ProfileState(
            ref: ref,
            fullName: ref.watch(authProvider).appUser?.fullName,
            userName: ref.watch(authProvider).appUser?.userName.userNameDisplay,
            photoUrl: ref.watch(authProvider).appUser?.profilePicUrl,
          ),
        );

  Future<bool> editProfileOnPressed(BuildContext _) async {
    GoRouter.of(_).pushNamed(RouteTable.rEditProfileScreen);

    return true;
  }

  Future<bool> privacyPolicyOnPressed(BuildContext _) async {
    GoRouter.of(_).pushNamed(RouteTable.rPrivacyPolicyScreen);

    return true;
  }

  Future<bool> logOutOnPressed(BuildContext _) async {
    ref.read(authProvider.notifier).logout();

    return true;
  }

  List<ProfileItem> items() {
    return [
      ProfileItem(
        title: getStr('profile_items:edit_profile'),
        onTap: editProfileOnPressed,
      ),
      ProfileItem(
        title: getStr('profile_items:logout'),
        onTap: logOutOnPressed,
        isDangerous: true,
      ),
    ];
  }
}
