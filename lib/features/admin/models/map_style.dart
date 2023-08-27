import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_style.g.dart';
part 'map_style.freezed.dart';

@freezed
class MapStyleItem with _$MapStyleItem {
  const factory MapStyleItem({
    String? featureType,
    String? elementType,
    List<Map<String, String>>? stylers,
  }) = _MapStyleItem;

  factory MapStyleItem.fromJson(Map<String, dynamic> json) =>
      _$MapStyleItemFromJson(json);
}

@freezed
class MapStyle with _$MapStyle {
  const MapStyle._();

  const factory MapStyle({
    List<MapStyleItem>? styleItems,
  }) = _MapStyle;

  factory MapStyle.fromJson(Map<String, dynamic> json) =>
      _$MapStyleFromJson(json);

  Map<String, dynamic> toJsonForMap() => toJson()['styleItems'];
}
