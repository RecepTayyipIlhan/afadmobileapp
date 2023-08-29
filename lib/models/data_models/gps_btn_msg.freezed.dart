// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gps_btn_msg.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GpsBtnMsg {
  LatLng get latLng => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GpsBtnMsgCopyWith<GpsBtnMsg> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GpsBtnMsgCopyWith<$Res> {
  factory $GpsBtnMsgCopyWith(GpsBtnMsg value, $Res Function(GpsBtnMsg) then) =
      _$GpsBtnMsgCopyWithImpl<$Res, GpsBtnMsg>;
  @useResult
  $Res call({LatLng latLng});
}

/// @nodoc
class _$GpsBtnMsgCopyWithImpl<$Res, $Val extends GpsBtnMsg>
    implements $GpsBtnMsgCopyWith<$Res> {
  _$GpsBtnMsgCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latLng = null,
  }) {
    return _then(_value.copyWith(
      latLng: null == latLng
          ? _value.latLng
          : latLng // ignore: cast_nullable_to_non_nullable
              as LatLng,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GpsBtnMsgCopyWith<$Res> implements $GpsBtnMsgCopyWith<$Res> {
  factory _$$_GpsBtnMsgCopyWith(
          _$_GpsBtnMsg value, $Res Function(_$_GpsBtnMsg) then) =
      __$$_GpsBtnMsgCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LatLng latLng});
}

/// @nodoc
class __$$_GpsBtnMsgCopyWithImpl<$Res>
    extends _$GpsBtnMsgCopyWithImpl<$Res, _$_GpsBtnMsg>
    implements _$$_GpsBtnMsgCopyWith<$Res> {
  __$$_GpsBtnMsgCopyWithImpl(
      _$_GpsBtnMsg _value, $Res Function(_$_GpsBtnMsg) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latLng = null,
  }) {
    return _then(_$_GpsBtnMsg(
      latLng: null == latLng
          ? _value.latLng
          : latLng // ignore: cast_nullable_to_non_nullable
              as LatLng,
    ));
  }
}

/// @nodoc

class _$_GpsBtnMsg extends _GpsBtnMsg {
  _$_GpsBtnMsg({required this.latLng}) : super._();

  @override
  final LatLng latLng;

  @override
  String toString() {
    return 'GpsBtnMsg(latLng: $latLng)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GpsBtnMsg &&
            (identical(other.latLng, latLng) || other.latLng == latLng));
  }

  @override
  int get hashCode => Object.hash(runtimeType, latLng);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GpsBtnMsgCopyWith<_$_GpsBtnMsg> get copyWith =>
      __$$_GpsBtnMsgCopyWithImpl<_$_GpsBtnMsg>(this, _$identity);
}

abstract class _GpsBtnMsg extends GpsBtnMsg {
  factory _GpsBtnMsg({required final LatLng latLng}) = _$_GpsBtnMsg;
  _GpsBtnMsg._() : super._();

  @override
  LatLng get latLng;
  @override
  @JsonKey(ignore: true)
  _$$_GpsBtnMsgCopyWith<_$_GpsBtnMsg> get copyWith =>
      throw _privateConstructorUsedError;
}
