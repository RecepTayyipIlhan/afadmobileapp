import 'package:afad_app/features/auth/models/app_user.dart';
import 'package:afad_app/features/mayday_call/help_message.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    required CameraPosition cameraPosition,
    required List<AppUser> users,
    required List<HelpMessage> messages,
  }) = _AdminMapState;

  factory AdminMapState.initial() => const AdminMapState(
        mapMarkers: {},
        show: true,
        selectedRowIndex: -1,
        cameraPosition: CameraPosition(
          target: LatLng(41.086058, 28.918416),
          zoom: 10.0,
        ),
        messages: [],
        users: [],
      );

  bool isRowSelected(int rowIndex) => selectedRowIndex == rowIndex;

  List<DataColumn> get dataTableColumns => const <DataColumn>[
        DataColumn(label: Text("Id")),
        DataColumn(label: Text("İsim")),
        DataColumn(label: Text("Tür")),
        /* DataColumn(label: Text("Mesaj")),
                            DataColumn(label: Text("Konum")),    */
      ];
}
