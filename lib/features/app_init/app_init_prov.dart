import 'dart:convert';
import 'dart:io';
import 'package:afad_app/app_runner.dart';
import 'package:afad_app/features/admin/models/il_ilce_model.dart';
import 'package:afad_app/services/analytics_service.dart';
import 'package:afad_app/services/cloud_firestore_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

import 'package:afad_app/features/app_init/models/app_init_state.dart';
import 'package:afad_app/features/app_init/models/app_settings.dart';
import 'package:afad_app/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/prov/network_detector_prov.dart';
import '../../utils/prov/auth_prov.dart';

final appInitializerProv = Provider<AppInitProv>(AppInitProv.new);

// for some reason, when I make `appInitializerProv` a `StateNotifierProvider`,
// the state updates don't work. seperating the state and the state notifier
// fixes the issue.
final appInitStateProv = StateProvider<AppInitState>(
  (ref) => AppInitState.initial(),
);

final appSettingsProv = Provider((ref) => ref.watch(appInitStateProv).settings);

final appInitedProv = Provider<bool>(
  (ref) => ref.watch(appInitStateProv).isInited,
);

class AppInitProv {
  final Ref ref;

  bool _inited = false;
  bool _initing = false;

  bool get inited => _inited;

  AppInitProv(this.ref);

  Future<bool> setAppOpened() async {
    try {
      var settings = ref.read(appInitStateProv).settings ?? AppSettings.empty();

      settings = settings.copyWith(
        isOpenedBefore: true,
      );

      await encodeSettings(settings);

      ref.read(appInitStateProv.notifier).update(
            (state) => state.copyWith(
              settings: settings,
            ),
          );

      return true;
    } catch (e) {
      logger.e(e);

      return false;
    }
  }

  Future<bool> encodeSettings(AppSettings settings) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final json = jsonEncode(settings.toJson());

      prefs.setString('settings', json);

      return true;
    } catch (e) {
      logger.e(e);

      return false;
    }
  }

  Future<AppSettings> decodeSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final json = prefs.getString('settings');

      if (json == null) {
        return AppSettings.empty();
      }

      final map = jsonDecode(json) as Map<String, dynamic>;

      return AppSettings.fromJson(map);
    } catch (e) {
      logger.e(e);

      return AppSettings.empty();
    }
  }

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    try {
      if (_inited || _initing) {
        return;
      }
      _initing = true;

      // easy localization
      await initLocalization();

      // connectivity
      await initConnectivity();

      var settings = await decodeSettings();

      // fb
      settings = await requestTracking(settings);
      encodeSettings(settings);

      await initFb();

      recordDeviceInfo();

      ref.read(appInitStateProv.notifier).update(
            (state) => state.copyWith(
              settings: settings,
              isInited: true,
            ),
          );

      _initing = false;
      _inited = true;
    } catch (e) {
      logger.e(e);
    } finally {
      // _initing = false;
      // _inited = true;
      // try {
      //   ref.read(appInitedProv.notifier).state = true;
      // } catch (e) {
      //   logger.e(e);
      // }
    }
  }

  Future<void> initLocalization() async {
    try {
      await EasyLocalization.ensureInitialized();
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> initConnectivity() async {
    try {
      await ref.read(networkAwareProvider.notifier).initialize();
    } catch (e) {
      logger.e(e);
    }
  }

  Future<AppSettings> requestTracking(AppSettings settings) async {
    try {
      final appTrackStat =
          await AppTrackingTransparency.trackingAuthorizationStatus;

      // requesting tracking authorization may not bu supported
      if (appTrackStat == TrackingStatus.notSupported ||
          appTrackStat == TrackingStatus.restricted) {
        settings = settings.copyWith(
          userTrackingStatus: UserTrackingStatus.refused,
        );

        return settings;
      }

      // the user can change the tracking status from the settings
      // so if the user disables it when they restart the app, or
      // before even opening the app for the first time, we'll
      // handle it here
      if (appTrackStat == TrackingStatus.authorized) {
        settings = settings.copyWith(
          userTrackingStatus: UserTrackingStatus.approved,
        );

        return settings;
      }

      if (appTrackStat == TrackingStatus.denied) {
        settings = settings.copyWith(
          userTrackingStatus: UserTrackingStatus.refused,
        );

        return settings;
      }

      // only TrackingStatus left is `undetermined`
      // we'll handle platform difference in settings' object
      if (settings.userTrackingStatus.notAskedYet) {
        final stat =
            await AppTrackingTransparency.requestTrackingAuthorization();

        if (stat == TrackingStatus.authorized) {
          settings = settings.copyWith(
            userTrackingStatus: UserTrackingStatus.approved,
          );
        } else {
          settings = settings.copyWith(
            userTrackingStatus: UserTrackingStatus.refused,
          );
        }
      }
    } catch (e) {
      logger.e(e);
    }

    return settings;
  }

  Future<void> initFb() async {
    await Firebase.initializeApp(
      options: appConfig.firebaseOptionsInstance.currentPlatform,
    );
    logger.i('Firebase initializeApp done');

    if (!kIsWeb)
    // fcm
    {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      debugPrint('fcmToken: $fcmToken');

      try {
        // ios and 13+ android requires permission requesting
        await FirebaseMessaging.instance.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );
      } catch (e) {
        // i've came across some 13- androids throwing an exception here
        // as this is only required for ios and 13+ androids, we can safely ignore this
        logger.e(e);
      }
    }

    // crashlytics
    {
      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };
      // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }

    // dynamic links
    ref.read(firebaseDynamicLinksInitializerProvider).init();

    // // remote config
    // {
    //   try {
    //     final remoteConfig = await FirebaseRemoteConfig.instance;
    //     await remoteConfig.setConfigSettings(
    //       RemoteConfigSettings(
    //         fetchTimeout: const Duration(seconds: 10),
    //         minimumFetchInterval: const Duration(seconds: 10),
    //       ),
    //     );
    //     await remoteConfig.fetchAndActivate();
    //   } catch (e) {
    //     logger.e(e);
    //   }
    // }

    await setIlIlce();

    try {
      ref.read(fbAnalyticsProv).appOpened();
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> setIlIlce() async {
    final json = await rootBundle.loadString('assets/il_ilce.json');

    final map = jsonDecode(json) as Map<String, dynamic>;

    final iller = (map['data'] as List<dynamic>).map(
      (e) {
        return IlModel.fromJson(e as Map<String, dynamic>);
      },
    ).toList();

    ref.read(appInitStateProv.notifier).update(
          (state) => state.copyWith(
            iller: iller,
          ),
        );
  }

  Future<void> recordDeviceInfo() async {
    try {
      if (kIsWeb) {
        return;
      }

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      final userId = ref.watch(authProvider).appUser?.id;

      // manufacturer, brand, model, product, id, os
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;

        final info = {
          'osname': 'Android',
          'manufacturer': androidInfo.manufacturer,
          'brand': androidInfo.brand,
          'model': androidInfo.model,
          'product': androidInfo.product,
          'osversion': androidInfo.version.release,
        };

        ref.read(fbDbProv).registerDeviceInfo(
              userId: userId,
              devId: androidInfo.id,
              deviceInfo: info,
            );
      }

      if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;

        final info = {
          'osname': 'iOS',
          'manufacturer': 'Apple',
          'brand': 'Apple',
          'model': iosInfo.model,
          'product': iosInfo.name,
          'osversion': iosInfo.systemVersion,
        };

        ref.read(fbDbProv).registerDeviceInfo(
              userId: userId,
              devId: iosInfo.identifierForVendor,
              deviceInfo: info,
            );
      }
    } catch (e) {
      logger.e(e);
    }
  }
}

final firebaseDynamicLinksInitializerProvider =
    Provider<FirebaseDynamicLinksInitializer>(
  FirebaseDynamicLinksInitializer.new,
);

class FirebaseDynamicLinksInitializer {
  final Ref ref;
  const FirebaseDynamicLinksInitializer(this.ref);

  void init() {
    try {
      FirebaseDynamicLinks.instance.onLink.listen(
        (event) {
          final linkUri = event.link;
          final link = linkUri.toString();

          final isSigninLink =
              FirebaseAuth.instance.isSignInWithEmailLink(link);
          if (isSigninLink) {
            ref.read(authProvider.notifier).handleEmailLoginLink(link);
          }
        },
      );
    } catch (e) {
      logger.e(e);
    }
  }
}
