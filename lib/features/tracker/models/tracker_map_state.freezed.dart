// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracker_map_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TrackerMapState {
  GoogleMapController? get mapController => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TrackerMapStateCopyWith<TrackerMapState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackerMapStateCopyWith<$Res> {
  factory $TrackerMapStateCopyWith(
          TrackerMapState value, $Res Function(TrackerMapState) then) =
      _$TrackerMapStateCopyWithImpl<$Res, TrackerMapState>;
  @useResult
  $Res call({GoogleMapController? mapController});
}

/// @nodoc
class _$TrackerMapStateCopyWithImpl<$Res, $Val extends TrackerMapState>
    implements $TrackerMapStateCopyWith<$Res> {
  _$TrackerMapStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mapController = freezed,
  }) {
    return _then(_value.copyWith(
      mapController: freezed == mapController
          ? _value.mapController
          : mapController // ignore: cast_nullable_to_non_nullable
              as GoogleMapController?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TrackerMapStateCopyWith<$Res>
    implements $TrackerMapStateCopyWith<$Res> {
  factory _$$_TrackerMapStateCopyWith(
          _$_TrackerMapState value, $Res Function(_$_TrackerMapState) then) =
      __$$_TrackerMapStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GoogleMapController? mapController});
}

/// @nodoc
class __$$_TrackerMapStateCopyWithImpl<$Res>
    extends _$TrackerMapStateCopyWithImpl<$Res, _$_TrackerMapState>
    implements _$$_TrackerMapStateCopyWith<$Res> {
  __$$_TrackerMapStateCopyWithImpl(
      _$_TrackerMapState _value, $Res Function(_$_TrackerMapState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mapController = freezed,
  }) {
    return _then(_$_TrackerMapState(
      mapController: freezed == mapController
          ? _value.mapController
          : mapController // ignore: cast_nullable_to_non_nullable
              as GoogleMapController?,
    ));
  }
}

/// @nodoc

class _$_TrackerMapState extends _TrackerMapState {
  const _$_TrackerMapState({this.mapController}) : super._();

  @override
  final GoogleMapController? mapController;

  @override
  String toString() {
    return 'TrackerMapState(mapController: $mapController)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TrackerMapState &&
            (identical(other.mapController, mapController) ||
                other.mapController == mapController));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mapController);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TrackerMapStateCopyWith<_$_TrackerMapState> get copyWith =>
      __$$_TrackerMapStateCopyWithImpl<_$_TrackerMapState>(this, _$identity);
}

abstract class _TrackerMapState extends TrackerMapState {
  const factory _TrackerMapState({final GoogleMapController? mapController}) =
      _$_TrackerMapState;
  const _TrackerMapState._() : super._();

  @override
  GoogleMapController? get mapController;
  @override
  @JsonKey(ignore: true)
  _$$_TrackerMapStateCopyWith<_$_TrackerMapState> get copyWith =>
      throw _privateConstructorUsedError;
}
