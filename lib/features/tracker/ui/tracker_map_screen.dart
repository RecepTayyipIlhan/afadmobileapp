import 'package:afad_app/features/tracker/prov/tracker_map_prov.dart';
import 'package:afad_app/ui/widgets/error_screen.dart';
import 'package:afad_app/ui/widgets/loading_screen.dart';
import 'package:afad_app/utils/app_theme.dart';
import 'package:afad_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackerMapScreen extends ConsumerStatefulWidget {
  const TrackerMapScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TrackerMapScreen> createState() => _TrackerMapScreenState();
}

class _TrackerMapScreenState extends ConsumerState<TrackerMapScreen> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData screen = MediaQuery.of(context);
    final pageState = ref.watch(trackerMapStateProv);
    final pageNotifier = ref.watch(trackerMapStateProv.notifier);

    return Scaffold(
      body: Builder(builder: (context) {
        final locProv = ref.watch(trakckerLocationProv);

        return locProv.when(
          loading: LoadingScreen.new,
          error: ErrorScreen.new,
          data: (data) {
            return SizedBox(
              height: screen.size.height,
              width: screen.size.width,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: pageState.defaultCamerapPosition,
                    markers: {
                      Marker(
                        markerId: MarkerId(
                          [data.loc.latitude, data.loc.longitude].join(","),
                        ),
                        position: LatLng(
                          data.loc.latitude,
                          data.loc.longitude,
                        ),
                      )
                    },
                    onMapCreated: pageNotifier.onMapCreated,
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
