import '../../app_runner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../services/cloud_firestore_service.dart';
import '../../services/local_storage_service.dart';

import '../../features/auth/models/app_user.dart';
import '../../models/data_models/auth_state.dart';
import '../../ui/widgets/snackbars.dart';
import '../route_table.dart';
import '../utils.dart';

final _authProv = Provider(
  (_) => FirebaseAuth.instance,
);

// https://github.com/lucavenir/go_router_riverpod/tree/master/firebase_example
// With firebase I often find myself writing simple providers
// Usually, stream-based redirects is more than enough.
// Most of the auth-related logic is handled by the SDK
final _firebaseUserProv = StreamProvider<User?>(
  (ref) {
    return ref.read(_authProv).authStateChanges();
  },
);

final _appUserProv = StreamProvider<AppUser?>(
  (ref) {
    final firebaseUser = ref.watch(_firebaseUserProv).valueOrNull;
    final userId = firebaseUser?.uid;

    if (userId == null) {
      return Stream.value(null);
    }

    final db = ref.watch(fbDbProv);

    final user = db.streamUser(userId);

    return user;
  },
);

final isAccountBeingDeletedProv = StateProvider<bool>((_) => false);

final authProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>(AuthStateNotifier.new);

class AuthStateNotifier extends StateNotifier<AuthState> {
  final Ref ref;
  AuthStateNotifier(this.ref)
      : super(
          AuthState(
            ref: ref,
            firebaseUser: ref.watch(_firebaseUserProv).value,
            appUser: ref.watch(_appUserProv).value,
            isLoading: () {
              final isLoading =
                  ref.watch(_firebaseUserProv).isLoading != false ||
                      ref.watch(_appUserProv).isLoading != false;
              return isLoading;
            }(),
          ),
        );

  Future<bool> _isEmailInUse({
    required BuildContext context,
    required String email,
  }) async {
    final methods = await ref.read(_authProv).fetchSignInMethodsForEmail(email);

    final inUse = methods.isNotEmpty;

    return inUse;
  }

  Future<bool> sendEmailSignupLink({
    required BuildContext context,
    required String email,
  }) async {
    try {
      if (await _isEmailInUse(context: context, email: email)) {
        Snackbars.showErrorSnackBar(
          context,
          message: getStr('auth:signup:validator:emailexists'),
        );

        return false;
      }

      await ref.read(_authProv).sendSignInLinkToEmail(
            email: email,
            actionCodeSettings: ActionCodeSettings(
              url: appConfig.deepLinksHost,
              androidPackageName: appConfig.androidBundleId,
              iOSBundleId: appConfig.iosBundleId,
              androidInstallApp: true,
              handleCodeInApp: true,
            ),
          );

      await ref.read(localStorageProv).setAuthEmail(email);

      return true;
    } on FirebaseAuthException catch (e) {
      logger.e(e);

      String? errorMessage;

      if (e.code == 'invalid-email') {
        errorMessage = getStr('auth:signup:validator:invalid-email');
      }

      if (errorMessage == null) {
        errorMessage = getStr('auth:signup:validator:unknownerror');
      }

      Snackbars.showErrorSnackBar(
        context,
        message: errorMessage,
      );
    } catch (e) {
      logger.e(e);
    }

    return false;
  }

  Future<bool> signupUsingPass({
    required BuildContext context,
    required String email,
    required String passowrd,
  }) async {
    try {
      if (await _isEmailInUse(context: context, email: email)) {
        Snackbars.showErrorSnackBar(
          context,
          message: getStr('auth:signup:validator:emailexists'),
        );

        return false;
      }

      await ref.read(_authProv).createUserWithEmailAndPassword(
            email: email,
            password: passowrd,
          );

      return true;
    } on FirebaseAuthException catch (e) {
      logger.e(e);

      String? errorMessage;

      if (e.code == 'weak-password') {
        errorMessage = getStr('auth:signup:validator:weak-password');
      } else if (e.code == 'email-already-in-use') {
        errorMessage = getStr('auth:signup:validator:email-already-in-use');
      } else if (e.code == 'invalid-email') {
        errorMessage = getStr('auth:signup:validator:invalid-email');
      }

      if (errorMessage == null) {
        errorMessage = getStr('auth:signup:validator:unknownerror');
      }

      Snackbars.showErrorSnackBar(
        context,
        message: errorMessage,
      );
    } catch (e) {
      logger.e(e);
    }

    return false;
  }

  Future<bool> signup({
    required BuildContext context,
    required AppUser appUser,
    required User fbUser,
  }) async {
    try {
      final db = ref.read(fbDbProv);

      appUser = appUser.copyWith(id: fbUser.uid);
      try {
        await db.createUser(appUser);

        return true;
      } catch (e) {
        // if failed to create user, delete the auth account
        await ref.read(_authProv).currentUser!.delete();

        rethrow;
      }
    } catch (e) {
      logger.e(e);

      Snackbars.showErrorSnackBar(
        context,
        message: getStr('auth:signup:validator:unknownerror'),
      );
    }

    return false;
  }

  Future<bool> editProfile({
    required BuildContext context,
    required AppUser appUser,
    required User fbUser,
  }) async {
    final db = ref.read(fbDbProv);

    try {
      await db.updateUser(appUser);

      Snackbars.showSuccessSnackBar(
        context,
        message: getStr('edit_profile:succesfully_saved'),
      );

      GoRouter.of(context).pop();

      return true;
    } catch (e) {
      logger.e(e);

      Snackbars.showErrorSnackBar(
        context,
        message: getStr('edit_profile:validator:unknownerror'),
      );
    }

    return false;
  }

  Future<bool> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final isEmailInUse = await _isEmailInUse(context: context, email: email);

      if (!isEmailInUse) {
        Snackbars.showErrorSnackBar(
          context,
          message: getStr('auth:login:validator:emailnotfound'),
        );

        return false;
      }

      await ref.read(_authProv).signInWithEmailAndPassword(
            email: email,
            password: password,
          );

      return true;
    } on FirebaseAuthException catch (e) {
      logger.e(e);

      String? errorMessage;

      if (e.code == 'user-not-found') {
        errorMessage = getStr('auth:login:validator:user-not-found');
      } else if (e.code == 'wrong-password') {
        errorMessage = getStr('auth:login:validator:wrong-password');
      } else if (e.code == 'invalid-email') {
        errorMessage = getStr('auth:login:validator:invalid-email');
      } else if (e.code == 'user-disabled') {
        errorMessage = getStr('auth:login:validator:user-disabled');
      }

      if (errorMessage == null) {
        errorMessage = getStr('auth:login:validator:unknownerror');
      }

      Snackbars.showErrorSnackBar(
        context,
        message: errorMessage,
      );
    } catch (e) {
      logger.e('login error: $e');
    }

    return false;
  }

  Future<bool> loginWithGoogle({required BuildContext context}) async {
    try {
      final gglSignIn = GoogleSignIn(
        signInOption: SignInOption.standard,
      );
      final googleUser = await gglSignIn.signIn();

      final googleAuth = await googleUser?.authentication;

      if (googleAuth != null) {
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Once signed in, return the UserCredential
        await ref.read(_authProv).signInWithCredential(credential);

        return true;
      }

      return false;
    } on FirebaseAuthException catch (e) {
      logger.e(e);

      String? errorMessage;

      if (e.code == 'web-context-canceled') {
        return true;
      }

      errorMessage = getStr('auth:login:validator:unknownerror');

      Snackbars.showErrorSnackBar(
        context,
        message: errorMessage,
      );
    } catch (e) {
      logger.e('loginWithGoogle' + e.toString());
    }

    return false;
  }

  Future<bool> loginWithApple({required BuildContext context}) async {
    try {
      final appleProvider = AppleAuthProvider();
      appleProvider.addScope('email');

      final userCredential =
          await ref.read(_authProv).signInWithProvider(appleProvider);

      final credential = userCredential.credential;

      if (credential == null) {
        logger.e('credential is null');
        return false;
      }

      // Once signed in, return the UserCredential
      await ref.read(_authProv).signInWithCredential(credential);

      return true;
    } on FirebaseAuthException catch (e) {
      logger.e(e);

      String? errorMessage;

      if (e.code == 'canceled') {
        return true;
      }
      if (e.code == 'web-context-canceled') {
        return true;
      }

      errorMessage = getStr('auth:login:validator:unknownerror');

      Snackbars.showErrorSnackBar(
        context,
        message: errorMessage,
      );
    } catch (e) {
      logger.e('loginWithApple' + e.toString());
    }

    return false;
  }

  Future<bool> resetPassword({
    required BuildContext context,
    required String email,
  }) async {
    try {
      await ref.read(_authProv).sendPasswordResetEmail(
            email: email,
          );

      return true;
    } on FirebaseAuthException catch (e) {
      logger.e(e);

      String? errorMessage;

      if (e.code == 'invalid-email') {
        errorMessage = getStr('auth:forgot_pass:validator:invalid-email');
      }

      if (e.code == 'user-not-found') {
        errorMessage = getStr('auth:forgot_pass:validator:user-not-found');
      }

      if (errorMessage == null) {
        errorMessage = getStr('auth:forgot_pass:validator:unknownerror');
      }

      Snackbars.showErrorSnackBar(
        context,
        message: errorMessage,
      );

      return false;
    } catch (e) {
      logger.e(e);

      return false;
    }
  }

  Future<bool> sendEmailLoginLink({
    required BuildContext context,
    required String email,
  }) async {
    try {
      final isEmailInUse = await _isEmailInUse(context: context, email: email);

      if (!isEmailInUse) {
        Snackbars.showErrorSnackBar(
          context,
          message: getStr('auth:login:validator:emailnotfound'),
        );

        return false;
      }

      await ref.read(_authProv).sendSignInLinkToEmail(
            email: email,
            actionCodeSettings: ActionCodeSettings(
              url: appConfig.deepLinksHost,
              androidPackageName: appConfig.androidBundleId,
              iOSBundleId: appConfig.iosBundleId,
              androidInstallApp: true,
              handleCodeInApp: true,
            ),
          );

      await ref.read(localStorageProv).setAuthEmail(email);

      return true;
    } on FirebaseAuthException catch (e) {
      logger.e(e);

      String? errorMessage;

      if (e.code == 'invalid-email') {
        errorMessage = getStr('auth:login:validator:invalid-email');
      }

      if (errorMessage == null) {
        errorMessage = getStr('auth:login:validator:unknownerror');
      }

      Snackbars.showErrorSnackBar(
        context,
        message: errorMessage,
      );
    } catch (e) {
      logger.e(e);
    }

    return false;
  }

  Future<bool> handleEmailLoginLink(String link) async {
    try {
      final email = await ref.read(localStorageProv).getAuthEmail();

      if (email == null) {
        return false;
      }

      await ref.read(localStorageProv).removeAuthEmail();

      final cred = await ref.read(_authProv).signInWithEmailLink(
            email: email,
            emailLink: link,
          );

      if (cred.user == null) {
        return false;
      }

      await ref.read(_authProv).currentUser!.reload();

      state = state.copyWith(
        lastLoginAt: DateTime.now(),
      );

      return true;
    } on FirebaseAuthException catch (e) {
      logger.e(e);

      String? errorMessage;

      if (e.code == 'invalid-email') {
        errorMessage = getStr('auth:login:validator:invalid-email');
      } else if (e.code == 'user-disabled') {
        errorMessage = getStr('auth:login:validator:user-disabled');
      } else if (e.code == 'expired-action-code') {
        errorMessage = getStr('auth:login:validator:expired-action-code');
      }
      // for some reason not mentioned in the docs,
      // this will be thrown if the link is invalid
      // e.g. user clicks an old link
      else if (e.code == 'invalid-action-code') {
        errorMessage = getStr('auth:login:validator:invalid-action-code');
      }

      if (errorMessage == null) {
        errorMessage = getStr('auth:login:validator:unknownerror');
      }

      final context = ref.read(navKeyProv).currentState?.context;
      if (context == null) {
        return false;
      }

      Snackbars.showErrorSnackBar(
        context,
        message: errorMessage,
      );
    } catch (e) {
      logger.e(e);
    }

    return false;
  }

  Future<void> logout() async {
    try {
      await ref.read(_authProv).signOut();
    } on FirebaseAuthException catch (e) {
      logger.e(e);

      state = AuthState.error(
        ref: ref,
        message: e.message,
      );
    }
  }

  Future<bool> deleteAccount() async {
    try {
      final db = ref.read(fbDbProv);

      final user = ref.read(_authProv).currentUser!;

      ref.read(isAccountBeingDeletedProv.notifier).state = true;
      final isDeletedDb = await db.deleteUser(user.uid);

      if (isDeletedDb) {
        await user.delete();

        return true;
      }

      return false;
    } on FirebaseAuthException catch (e) {
      logger.e(e);

      state = AuthState.error(
        ref: ref,
        message: e.message,
      );
    } catch (e) {
      logger.e(e);
    }

    return false;
  }
}
