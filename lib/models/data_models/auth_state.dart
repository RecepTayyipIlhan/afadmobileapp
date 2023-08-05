import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../features/auth/models/app_user.dart';
import '../../features/auth/models/app_user_role.dart';

import '../../utils/prov/auth_prov.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState({
    User? firebaseUser,
    AppUser? appUser,
    @Default(false) bool isLoading,
    String? errorMessage,
    DateTime? lastLoginAt,
    required Ref ref,
  }) = _AuthState;

  bool get isAccountBeingDeleted =>
      ref.watch(isAccountBeingDeletedProv) && firebaseUser != null;

  factory AuthState.error({
    required Ref ref,
    required String? message,
  }) =>
      AuthState(
        ref: ref,
        errorMessage: message ?? 'An error occurred',
      );

  bool get hasError => errorMessage != null;

  bool get isLoggedIn => firebaseUser != null && appUser != null;

  bool get isEmailVerified =>
      firebaseUser != null && appUser == null && isLoading == false;
  bool get isHalfSignedUp => isEmailVerified;

  bool get isAdmin => appUser?.role == AppUserRole.admin;
  bool get isUser => appUser?.role == AppUserRole.user;
}
