import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_item.freezed.dart';

@freezed
class ProfileItem with _$ProfileItem {
  const ProfileItem._();

  const factory ProfileItem({
    required String title,
    required Future<bool> Function(BuildContext context) onTap,
    @Default(false) bool isDangerous,
  }) = _ProfileItem;
}
