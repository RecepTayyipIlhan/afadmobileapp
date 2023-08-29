import 'package:afad_app/services/cloud_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/tracker_map_state.dart';

final trackerMapStateProv =
    StateNotifierProvider<TrackerMapStateNotifier, TrackerMapState>(
  TrackerMapStateNotifier.new,
);

final trakckerLocationProv = StreamProvider(
  (ref) => ref.watch(fbDbProv).streamTrackerLocation(),
);

class TrackerMapStateNotifier extends StateNotifier<TrackerMapState> {
  final Ref ref;
  TrackerMapStateNotifier(this.ref) : super(TrackerMapState.initial());

  void onMapCreated(GoogleMapController controller) {
    state = state.copyWith(mapController: controller);
  }

  void setMapCameraPosition(CameraPosition position) {
    state.mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        position,
      ),
    );
  }

  void openInMapApp(GeoPoint loc) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${loc.latitude},${loc.longitude}';
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
