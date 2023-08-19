// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'help_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HelpMessage _$$_HelpMessageFromJson(Map<String, dynamic> json) =>
    _$_HelpMessage(
      loc: geoPointFromJson(json['loc'] as GeoPoint),
      mt: messageTypeFromJson(json['mt'] as int),
      ui: json['ui'] as String,
    );

Map<String, dynamic> _$$_HelpMessageToJson(_$_HelpMessage instance) =>
    <String, dynamic>{
      'loc': geoPointToJson(instance.loc),
      'mt': messageTypeToJson(instance.mt),
      'ui': instance.ui,
    };
