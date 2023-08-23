// gorouter wants me to use
// GoRouter.of(context).namedLocation instead
// of state.namedLocation but that one throws error
// and I dont really have time for this right now
// ignore_for_file: deprecated_member_use

import 'package:afad_app/features/admin/ui/detailed_person_page.dart';
import 'package:afad_app/features/auth/models/app_user.dart';

import '../features/admin/ui/admin_home_screen.dart';
import '../features/home/prov/network_detector_prov.dart';
import '../features/home/ui/bottom_nav_screen.dart';
import '../features/home/ui/no_connection_screen.dart';
import '../features/profile/ui/edit_profile_screen.dart';
import '../features/profile/ui/profile_screen.dart';
import '../features/home/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/ui/login_screen.dart';
import '../features/auth/ui/signup_screen.dart';
import '../ui/widgets/error_screen.dart';
import '../ui/widgets/loading_screen.dart';
import 'prov/auth_prov.dart';

export 'package:go_router/go_router.dart' show GoRouter;

typedef GoRouterWidgetBuilder = Widget Function(
  BuildContext context,
  GoRouterState state,
);

final navKeyProv = Provider(
  (_) => GlobalKey<NavigatorState>(),
);

final shellKeyPRov = Provider(
  (_) => GlobalKey<NavigatorState>(),
);

class RouteTable {
  RouteTable._();

  static const String
      //
      rLoginScreen = 'login_screen',
      rSignupScreen = 'signup_screen',
      rDeleteAccountScreen = 'delete_account_screen',
      rForgotPassScreen = 'forgot_pass_screen'
      //
      ;

  static const String
      //
      rSplashScreen = 'splash_screen',
      rHome = 'home_screen',
      rPrivacyPolicyScreen = 'privacy_policy_screen',
      rProfileScreen = 'profile_screen',
      rEditProfileScreen = 'edit_profile_screen',
      rErrorScreen = 'error_screen',
      rLoadingScreen = 'loading_screen',
      rEstimationQuizScreen = 'estimation_quiz_screen',
      rMultiQuizScreen = 'multi_quiz_screen'
//
      ;
// admin
  static const String
      //
      rAdminHome = 'admin_home_screen',
      rAdminDetailedPersonPage = 'admin_detailed_person_page'
      //
      ;

  static const String initialLocation = '/';

  static const String rNoConnection = 'no_connection';

  static GoRoute _authRoute() => GoRoute(
        name: rLoginScreen,
        path: '/auth',
        builder: (context, state) => const LoginScreen(),
        routes: [
          GoRoute(
            name: rSignupScreen,
            path: 'signup',
            builder: (context, state) => const SignupScreen(),
          ),
        ],
      );

  static GoRoute _userRoute(AutoDisposeProviderRef ref) => GoRoute(
        name: rSplashScreen,
        path: '/',
        builder: (context, state) {
          return const SplashScreen();
        },
        routes: [
          GoRoute(
            name: rHome,
            path: 'home',
            builder: (context, state) {
              // return const HomeScreen();
              return const BottomNavScreen();
            },
          ),
          GoRoute(
            name: rProfileScreen,
            path: 'profile',
            builder: (context, state) {
              return const ProfileScreen();
            },
            routes: [
              GoRoute(
                name: rEditProfileScreen,
                path: 'edit',
                builder: (context, state) {
                  return const EditProfileScreen();
                },
              ),
            ],
          ),
          GoRoute(
            name: rErrorScreen,
            path: 'error',
            builder: (context, state) => const ErrorScreen.empty(),
          ),
          GoRoute(
            name: rLoadingScreen,
            path: 'loading',
            builder: (context, state) => const LoadingScreen(),
          ),
        ],
      );

  static GoRoute _adminRoute() => GoRoute(
        name: rAdminHome,
        path: '/admin',
        builder: (context, state) => const AdminHomeScreen(),
        routes: [
          GoRoute(
            name: rAdminDetailedPersonPage,
            path: 'detailed_person_page',
            builder: (context, state) => DetailedPersonPage(
              user: state.extra as AppUser,
            ),
          ),
        ],
      );

  static final routerProvider = Provider.autoDispose<GoRouter>(
    (ref) {
      final authState = ref.watch(authProvider);

      final key = ref.watch(navKeyProv);

      final connection = ref.watch(networkAwareProvider);

      return GoRouter(
        navigatorKey: key,
        debugLogDiagnostics: true,
        // initialLocation: connection.isOn ? initialLocation : '/no_connection',
        initialLocation: initialLocation,
        routes: [
          _authRoute(),
          GoRoute(
            name: rNoConnection,
            path: '/no_connection',
            builder: (context, state) {
              return const NoConnectionScreen();
            },
          ),
          _userRoute(ref),
          _adminRoute(),
        ],
        errorBuilder: (context, state) {
          return ErrorScreen.routeError();
        },
        redirect: (context, state) async {
          // if (state.location == '/no_connection') {
          //   return null;
          // }

          const splashLoc = '/';
          final homeLoc = state.namedLocation(rHome);
          final adminHomeLoc = state.namedLocation(rAdminHome);
          final loginLoc = state.namedLocation(rLoginScreen);
          final signupLoc = state.namedLocation(rSignupScreen);

          final isSplash = state.location == splashLoc;
          final isAuth = state.location.startsWith('/auth') == true;

          // If our async state is loading, don't perform redirects, yet
          if (authState.isLoading ||
              authState.hasError ||
              authState.isAccountBeingDeleted) {
            return splashLoc;
          }

          final isAdmin = authState.isAdmin;

          // This has to do with how the FirebaseAuth SDK handles the "log-in" state
          // Returning `null` means "we are not authorized"
          final isLoggedIn = authState.isLoggedIn;

          final isHalfSignedUp = authState.isHalfSignedUp;

          String? letThemIn() {
            final isGoingToAdminRoute = state.location.startsWith('/admin');

            // if not admin and trying to go to admin route, redirect to home
            if (!isAdmin) {
              if (isGoingToAdminRoute) {
                return homeLoc;
              }

              if (isSplash) {
                return homeLoc;
              }

              return null;
            }

            // admin zone

            // if admin and trying to go to home route, redirect to admin home.
            // this is useful as every user will try to go to '/',
            // but we want to redirect them to the admin home
            if (!isGoingToAdminRoute) {
              return adminHomeLoc;
            }

            if (isSplash) {
              return adminHomeLoc;
            }

            return null;
          }

          if (isLoggedIn) {
            return letThemIn();
          }

          // not loggged in zone

          // if going to a route under auth, let them in
          if (isAuth) {
            return null;
          }

          final isGoingToSignup = state.location == signupLoc;
          if (isHalfSignedUp) {
            if (isGoingToSignup) {
              return null;
            }

            return signupLoc;
          }

          // if not going to login, redirect to login
          final isGoingToLogin = state.location == loginLoc;
          if (isGoingToLogin) {
            return null;
          }

          return loginLoc;
        },
      );
    },
  );
}

extension GR on GoRouter {
  void onPop(VoidCallback onPop) {
    final loc = location;

    listener() async {
      if (location == loc) {
        onPop();
        removeListener(listener);
      }
    }

    addListener(listener);
  }

  void popUntilLocation(String location) {
    while (this.location != location) {
      if (isInitial || !canPop()) {
        break;
      }
      pop();
    }
  }

  void popUntil(bool Function(String location) condition) {
    while (!condition(location)) {
      if (isInitial || !canPop()) {
        break;
      }
      pop();
    }
  }

  void popUntilInitial() {
    while (!isInitial && canPop()) {
      pop();
    }
  }

  bool get isInitial {
    return location == RouteTable.initialLocation;
  }
}
