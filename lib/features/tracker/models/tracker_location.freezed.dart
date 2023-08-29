// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracker_location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TrackerLocation _$TrackerLocationFromJson(Map<String, dynamic> json) {
  return _TrackerLocation.fromJson(json);
}

/// @nodoc
mixin _$TrackerLocation {
  @JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson)
  GeoPoint get loc => throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrackerLocationCopyWith<TrackerLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackerLocationCopyWith<$Res> {
  factory $TrackerLocationCopyWith(
          TrackerLocation value, $Res Function(TrackerLocation) then) =
      _$TrackerLocationCopyWithImpl<$Res, TrackerLocation>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson)
      GeoPoint loc,
      DateTime lastUpdated});
}

/// @nodoc
class _$TrackerLocationCopyWithImpl<$Res, $Val extends TrackerLocation>
    implements $TrackerLocationCopyWith<$Res> {
  _$TrackerLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loc = null,
    Object? lastUpdated = null,
  }) {
    return _then(_value.copyWith(
      loc: null == loc
          ? _value.loc
          : loc // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TrackerLocationCopyWith<$Res>
    implements $TrackerLocationCopyWith<$Res> {
  factory _$$_TrackerLocationCopyWith(
          _$_TrackerLocation value, $Res Function(_$_TrackerLocation) then) =
      __$$_TrackerLocationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson)
      GeoPoint loc,
      DateTime lastUpdated});
}

/// @nodoc
class __$$_TrackerLocationCopyWithImpl<$Res>
    extends _$TrackerLocationCopyWithImpl<$Res, _$_TrackerLocation>
    implements _$$_TrackerLocationCopyWith<$Res> {
  __$$_TrackerLocationCopyWithImpl(
      _$_TrackerLocation _value, $Res Function(_$_TrackerLocation) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loc = null,
    Object? lastUpdated = null,
  }) {
    return _then(_$_TrackerLocation(
      loc: null == loc
          ? _value.loc
          : loc // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TrackerLocation extends _TrackerLocation {
  _$_TrackerLocation(
      {@JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson)
      required this.loc,
      required this.lastUpdated})
      : super._();

  factory _$_TrackerLocation.fromJson(Map<String, dynamic> json) =>
      _$$_TrackerLocationFromJson(json);

  @override
  @JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson)
  final GeoPoint loc;
  @override
  final DateTime lastUpdated;

  @override
  String toString() {
    return 'TrackerLocation(loc: $loc, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TrackerLocation &&
            (identical(other.loc, loc) || other.loc == loc) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, loc, lastUpdated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TrackerLocationCopyWith<_$_TrackerLocation> get copyWith =>
      __$$_TrackerLocationCopyWithImpl<_$_TrackerLocation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TrackerLocationToJson(
      this,
    );
  }
}

abstract class _TrackerLocation extends TrackerLocation {
  factory _TrackerLocation(
      {@JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson)
      required final GeoPoint loc,
      required final DateTime lastUpdated}) = _$_TrackerLocation;
  _TrackerLocation._() : super._();

  factory _TrackerLocation.fromJson(Map<String, dynamic> json) =
      _$_TrackerLocation.fromJson;

  @override
  @JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson)
  GeoPoint get loc;
  @override
  DateTime get lastUpdated;
  @override
  @JsonKey(ignore: true)
  _$$_TrackerLocationCopyWith<_$_TrackerLocation> get copyWith =>
      throw _privateConstructorUsedError;
}
