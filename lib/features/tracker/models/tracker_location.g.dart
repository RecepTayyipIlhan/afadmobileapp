// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracker_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TrackerLocation _$$_TrackerLocationFromJson(Map<String, dynamic> json) =>
    _$_TrackerLocation(
      loc: geoPointFromJson(json['loc'] as GeoPoint),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$_TrackerLocationToJson(_$_TrackerLocation instance) =>
    <String, dynamic>{
      'loc': geoPointToJson(instance.loc),
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };
