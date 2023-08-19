// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'help_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HelpMessage _$HelpMessageFromJson(Map<String, dynamic> json) {
  return _HelpMessage.fromJson(json);
}

/// @nodoc
mixin _$HelpMessage {
  @JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson)
  GeoPoint get loc => throw _privateConstructorUsedError;
  @JsonKey(fromJson: messageTypeFromJson, toJson: messageTypeToJson)
  MessageType get mt => throw _privateConstructorUsedError;
  String get ui => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HelpMessageCopyWith<HelpMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HelpMessageCopyWith<$Res> {
  factory $HelpMessageCopyWith(
          HelpMessage value, $Res Function(HelpMessage) then) =
      _$HelpMessageCopyWithImpl<$Res, HelpMessage>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson)
      GeoPoint loc,
      @JsonKey(fromJson: messageTypeFromJson, toJson: messageTypeToJson)
      MessageType mt,
      String ui});
}

/// @nodoc
class _$HelpMessageCopyWithImpl<$Res, $Val extends HelpMessage>
    implements $HelpMessageCopyWith<$Res> {
  _$HelpMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loc = null,
    Object? mt = null,
    Object? ui = null,
  }) {
    return _then(_value.copyWith(
      loc: null == loc
          ? _value.loc
          : loc // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      mt: null == mt
          ? _value.mt
          : mt // ignore: cast_nullable_to_non_nullable
              as MessageType,
      ui: null == ui
          ? _value.ui
          : ui // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HelpMessageCopyWith<$Res>
    implements $HelpMessageCopyWith<$Res> {
  factory _$$_HelpMessageCopyWith(
          _$_HelpMessage value, $Res Function(_$_HelpMessage) then) =
      __$$_HelpMessageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson)
      GeoPoint loc,
      @JsonKey(fromJson: messageTypeFromJson, toJson: messageTypeToJson)
      MessageType mt,
      String ui});
}

/// @nodoc
class __$$_HelpMessageCopyWithImpl<$Res>
    extends _$HelpMessageCopyWithImpl<$Res, _$_HelpMessage>
    implements _$$_HelpMessageCopyWith<$Res> {
  __$$_HelpMessageCopyWithImpl(
      _$_HelpMessage _value, $Res Function(_$_HelpMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loc = null,
    Object? mt = null,
    Object? ui = null,
  }) {
    return _then(_$_HelpMessage(
      loc: null == loc
          ? _value.loc
          : loc // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      mt: null == mt
          ? _value.mt
          : mt // ignore: cast_nullable_to_non_nullable
              as MessageType,
      ui: null == ui
          ? _value.ui
          : ui // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HelpMessage extends _HelpMessage {
  _$_HelpMessage(
      {@JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson)
      required this.loc,
      @JsonKey(fromJson: messageTypeFromJson, toJson: messageTypeToJson)
      required this.mt,
      required this.ui})
      : super._();

  factory _$_HelpMessage.fromJson(Map<String, dynamic> json) =>
      _$$_HelpMessageFromJson(json);

  @override
  @JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson)
  final GeoPoint loc;
  @override
  @JsonKey(fromJson: messageTypeFromJson, toJson: messageTypeToJson)
  final MessageType mt;
  @override
  final String ui;

  @override
  String toString() {
    return 'HelpMessage(loc: $loc, mt: $mt, ui: $ui)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HelpMessage &&
            (identical(other.loc, loc) || other.loc == loc) &&
            (identical(other.mt, mt) || other.mt == mt) &&
            (identical(other.ui, ui) || other.ui == ui));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, loc, mt, ui);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HelpMessageCopyWith<_$_HelpMessage> get copyWith =>
      __$$_HelpMessageCopyWithImpl<_$_HelpMessage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HelpMessageToJson(
      this,
    );
  }
}

abstract class _HelpMessage extends HelpMessage {
  factory _HelpMessage(
      {@JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson)
      required final GeoPoint loc,
      @JsonKey(fromJson: messageTypeFromJson, toJson: messageTypeToJson)
      required final MessageType mt,
      required final String ui}) = _$_HelpMessage;
  _HelpMessage._() : super._();

  factory _HelpMessage.fromJson(Map<String, dynamic> json) =
      _$_HelpMessage.fromJson;

  @override
  @JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson)
  GeoPoint get loc;
  @override
  @JsonKey(fromJson: messageTypeFromJson, toJson: messageTypeToJson)
  MessageType get mt;
  @override
  String get ui;
  @override
  @JsonKey(ignore: true)
  _$$_HelpMessageCopyWith<_$_HelpMessage> get copyWith =>
      throw _privateConstructorUsedError;
}
