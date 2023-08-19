// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'help_message.g.dart';
part 'help_message.freezed.dart';

enum MessageType {
  EnkazAltindayim,
  EtrafimdaEnkazAltindaInsan,
}

MessageType messageTypeFromJson(int json) {
  return MessageType.values[json];
}

int messageTypeToJson(MessageType object) {
  return object.index;
}

GeoPoint geoPointFromJson(GeoPoint object) {
  return object;
}

GeoPoint geoPointToJson(GeoPoint object) {
  return object;
}

@freezed
class HelpMessage with _$HelpMessage {
  const HelpMessage._();

  factory HelpMessage({
    @JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson)
    required GeoPoint loc,
    @JsonKey(fromJson: messageTypeFromJson, toJson: messageTypeToJson)
    required MessageType mt,
    required String ui,
  }) = _HelpMessage;

  factory HelpMessage.fromJson(Map<String, dynamic> json) =>
      _$HelpMessageFromJson(json);
}
