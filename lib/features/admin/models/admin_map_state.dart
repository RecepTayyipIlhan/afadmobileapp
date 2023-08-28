import 'package:afad_app/features/auth/models/app_user.dart';
import 'package:afad_app/features/mayday_call/help_message.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:afad_app/features/admin/models/il_ilce_model.dart';
part 'admin_map_state.freezed.dart';

@freezed
class AdminMapState with _$AdminMapState {
  const AdminMapState._();

  const factory AdminMapState({
    GoogleMapController? mapController,
    LatLng? selectedLocation,
    required Set<Marker> mapMarkers,
    required bool show,
    required int selectedRowIndex,
    required List<AppUser> users,
    required List<HelpMessage> messages,
    required int
        sortColumnIndex, // Initialize with the index of the "Tür" column.
    required bool sortAscending,
    required List<IlModel> iller,
  }) = _AdminMapState;

  factory AdminMapState.initial() => const AdminMapState(
        mapMarkers: {},
        show: true,
        selectedRowIndex: -1,
        messages: [],
        users: [],
        sortColumnIndex: 1,
        sortAscending: true,
        iller: [],
      );

  CameraPosition get defaultCamerapPosition => const CameraPosition(
        target: LatLng(41.086058, 28.918416),
        zoom: 10.0,
      );

  bool isRowSelected(int rowIndex) => selectedRowIndex == rowIndex;
}
