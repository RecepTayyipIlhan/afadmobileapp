import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geocode/geocode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
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

  Future<String?> address(GeoPoint loc) async {
    const mapApiKey = "AIzaSyBL-W31kzyBTvqVRJ_hNl867UXsCtkE1wI";
    final lat = loc.latitude;
    final lng = loc.longitude;
    String host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$host?key=$mapApiKey&language=en&latlng=$lat,$lng';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      String formattedAddress = data["results"][0]["formatted_address"];
      print("response ==== $formattedAddress");
      return formattedAddress;
    } else {
      return null;
    }
  }
}
