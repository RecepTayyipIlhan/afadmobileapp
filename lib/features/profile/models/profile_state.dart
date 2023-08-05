import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const ProfileState._();

  const factory ProfileState({
    required Ref ref,
    required String? fullName,
    required String? userName,
    required String? photoUrl,
  }) = _ProfileState;
}
