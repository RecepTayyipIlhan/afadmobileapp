// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_style.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MapStyleItem _$$_MapStyleItemFromJson(Map<String, dynamic> json) =>
    _$_MapStyleItem(
      featureType: json['featureType'] as String?,
      elementType: json['elementType'] as String?,
      stylers: (json['stylers'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList(),
    );

Map<String, dynamic> _$$_MapStyleItemToJson(_$_MapStyleItem instance) =>
    <String, dynamic>{
      'featureType': instance.featureType,
      'elementType': instance.elementType,
      'stylers': instance.stylers,
    };

_$_MapStyle _$$_MapStyleFromJson(Map<String, dynamic> json) => _$_MapStyle(
      styleItems: (json['styleItems'] as List<dynamic>?)
          ?.map((e) => MapStyleItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_MapStyleToJson(_$_MapStyle instance) =>
    <String, dynamic>{
      'styleItems': instance.styleItems,
    };
