import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'gps_btn_msg.freezed.dart';

@freezed
class GpsBtnMsg with _$GpsBtnMsg {
  const GpsBtnMsg._();

  factory GpsBtnMsg({
    required LatLng latLng,
  }) = _GpsBtnMsg;

  // gps{index}: 41.059946,28.896104
  // gps{index}: lat,lng
  factory GpsBtnMsg.decodeFromMsg(String msg) {
    final spl = msg.split(",");

    return GpsBtnMsg(
      latLng: LatLng(
        double.parse(spl[0]),
        double.parse(spl[1]),
      ),
    );
  }
}
