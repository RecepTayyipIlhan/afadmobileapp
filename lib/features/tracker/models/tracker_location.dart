// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'tracker_location.g.dart';
part 'tracker_location.freezed.dart';

GeoPoint geoPointFromJson(GeoPoint object) {
  return object;
}

GeoPoint geoPointToJson(GeoPoint object) {
  return object;
}

@freezed
class TrackerLocation with _$TrackerLocation {
  const TrackerLocation._();

  factory TrackerLocation({
    @JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson)
    required GeoPoint loc,
    required DateTime lastUpdated,
  }) = _TrackerLocation;

  factory TrackerLocation.fromJson(Map<String, dynamic> json) =>
      _$TrackerLocationFromJson(json);
}
