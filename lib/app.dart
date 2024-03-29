import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ui/widgets/loading_screen.dart';
import 'utils/app_theme.dart';
import 'utils/prov/app_info_prov.dart';
import 'features/app_init/app_init_prov.dart';
import 'utils/prov/app_refresh_listenable.dart';
import 'utils/route_table.dart';
import 'utils/utils.dart';

class TheApp extends StatelessWidget {
  const TheApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      observers: [
        // StateLogger(),
      ],
      child: _App(),
    );
  }
}

class _EasyLoc extends StatelessWidget {
  final Widget child;
  const _EasyLoc({
    required this.child,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      saveLocale: true,
      path: 'assets/translations',
      supportedLocales: appLangs.map((e) => e.toLocale()).toList(),
      startLocale: getLangModel().toLocale(),
      child: child,
    );
  }
}

class _App extends ConsumerStatefulWidget {
  const _App();

  @override
  ConsumerState<_App> createState() => _AppState();
}

class _AppState extends ConsumerState<_App> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.read(appInitializerProv).init();
  }

  @override
  Widget build(BuildContext context) {
    final inited = ref.watch(appInitedProv);

    final appTheme = ref.watch(appThemeProv).lightTheme;

    if (!inited) {
      return MaterialApp(
        theme: appTheme,
        home: const LoadingScreen(),
      );
    }

    ref.listen(
      refreshListenableProvider,
      (_, __) {
        ref
            .read(
              RouteTable.routerProvider,
            )
            .refresh();
      },
    );

    final theme = Theme.of(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: theme.statusBarColor,
      ),
    );

    final router = ref.watch(RouteTable.routerProvider);

    return _EasyLoc(
      // necessary because the material app
      // can't share the same context as the
      // easy localization widget
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            debugShowMaterialGrid: false,
            localizationsDelegates: [
              ...context.localizationDelegates,
            ],
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: appTheme,
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            scaffoldMessengerKey: ref.watch(appInfoProv).scaffoldMessengerKey,
          );
        },
      ),
    );
  }
}
