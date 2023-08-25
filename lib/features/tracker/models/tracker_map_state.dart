import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'tracker_map_state.freezed.dart';

@freezed
class TrackerMapState with _$TrackerMapState {
  const TrackerMapState._();

  const factory TrackerMapState({
    GoogleMapController? mapController,
  }) = _TrackerMapState;

  factory TrackerMapState.initial() => const TrackerMapState();

  CameraPosition get defaultCamerapPosition => const CameraPosition(
        target: LatLng(41.086058, 28.918416),
        zoom: 10.0,
      );
}
