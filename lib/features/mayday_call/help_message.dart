// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'help_message.g.dart';
part 'help_message.freezed.dart';

enum MessageType {
  EnkazAltindayim,
  Ambulans,
  GidaTalebi,
  IlacTalebi,
  BarinmaTalebi,
  GazIhbari,
  YanginIhbari,
  EnkazIhbari,
  EvdeyimDurumumIyi,
  ToplanmaAlani,
  Kayboldum,
  YagmaciIhbari;

  String toViewString() {
    switch (this) {
      case MessageType.EnkazAltindayim:
        return "Enkaz Altında";
      case MessageType.Ambulans:
        return "Ambulans Talebi";
      case MessageType.BarinmaTalebi:
        return "Barınma Talebi";
      case MessageType.EvdeyimDurumumIyi:
        return "Evdeyim Durumum İyi";
      case MessageType.GazIhbari:
        return "Gaz İhbarı";
      case MessageType.IlacTalebi:
        return "İlaç Talebi";
      case MessageType.Kayboldum:
        return "Kayboldum";
      case MessageType.EnkazIhbari:
        return "Enkaz İhbarı";
      case MessageType.YanginIhbari:
        return "Yangın İhbarı";
      case MessageType.YagmaciIhbari:
        return "Yağmacı İhbarı";
      case MessageType.ToplanmaAlani:
        return "Toplanma Alanı";
      case MessageType.GidaTalebi:
        return "Gıda Talebi";
    }
  }

  // String toViewDescString() {
  //   switch (this) {
  //     case MessageType.EnkazAltindayim:
  //       return
  //     case MessageType.Ambulans:
  //       return "Ambulans Talebi";
  //     case MessageType.BarinmaTalebi:
  //       return "Barınma Talebi";
  //     case MessageType.EvdeyimDurumumIyi:
  //       return "Evdeyim Durumum İyi";
  //     case MessageType.GazIhbari:
  //       return "Gaz İhbarı";
  //     case MessageType.IlacTalebi:
  //       return "İlaç Talebi";
  //     case MessageType.Kayboldum:
  //       return "Kayboldum";
  //     case MessageType.EnkazIhbari:
  //       return "Enkaz İhbarı";
  //     case MessageType.YanginIhbari:
  //       return "Yangın İhbarı";
  //     case MessageType.YagmaciIhbari:
  //       return "Yağmacı İhbarı";
  //     case MessageType.ToplanmaAlani:
  //       return "Toplanma Alanı";
  //     case MessageType.GidaTalebi:
  //       return "Gıda Talebi";
  //   }
  // }
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

  // str{index}: YR7Q8HOgzJQ0IUhpOm6GCatTqP03,1,39.8833096,32.7360542
  // str{index}: userid,messagetype,lat,lng
  factory HelpMessage.decodeFromMsg(String msg) {
    final spl = msg.trim().split(",");

    final userid = spl[0];
    final messagetype = int.parse(spl[1]);
    final lat = double.parse(spl[2]);
    final lng = double.parse(spl[3]);

    return HelpMessage(
      loc: GeoPoint(
        lat,
        lng,
      ),
      ui: userid,
      mt: messageTypeFromJson(messagetype),
    );
  }
}
