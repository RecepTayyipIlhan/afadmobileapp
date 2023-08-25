// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_style.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MapStyleItem _$MapStyleItemFromJson(Map<String, dynamic> json) {
  return _MapStyleItem.fromJson(json);
}

/// @nodoc
mixin _$MapStyleItem {
  String? get featureType => throw _privateConstructorUsedError;
  String? get elementType => throw _privateConstructorUsedError;
  List<Map<String, String>>? get stylers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MapStyleItemCopyWith<MapStyleItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapStyleItemCopyWith<$Res> {
  factory $MapStyleItemCopyWith(
          MapStyleItem value, $Res Function(MapStyleItem) then) =
      _$MapStyleItemCopyWithImpl<$Res, MapStyleItem>;
  @useResult
  $Res call(
      {String? featureType,
      String? elementType,
      List<Map<String, String>>? stylers});
}

/// @nodoc
class _$MapStyleItemCopyWithImpl<$Res, $Val extends MapStyleItem>
    implements $MapStyleItemCopyWith<$Res> {
  _$MapStyleItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? featureType = freezed,
    Object? elementType = freezed,
    Object? stylers = freezed,
  }) {
    return _then(_value.copyWith(
      featureType: freezed == featureType
          ? _value.featureType
          : featureType // ignore: cast_nullable_to_non_nullable
              as String?,
      elementType: freezed == elementType
          ? _value.elementType
          : elementType // ignore: cast_nullable_to_non_nullable
              as String?,
      stylers: freezed == stylers
          ? _value.stylers
          : stylers // ignore: cast_nullable_to_non_nullable
              as List<Map<String, String>>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MapStyleItemCopyWith<$Res>
    implements $MapStyleItemCopyWith<$Res> {
  factory _$$_MapStyleItemCopyWith(
          _$_MapStyleItem value, $Res Function(_$_MapStyleItem) then) =
      __$$_MapStyleItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? featureType,
      String? elementType,
      List<Map<String, String>>? stylers});
}

/// @nodoc
class __$$_MapStyleItemCopyWithImpl<$Res>
    extends _$MapStyleItemCopyWithImpl<$Res, _$_MapStyleItem>
    implements _$$_MapStyleItemCopyWith<$Res> {
  __$$_MapStyleItemCopyWithImpl(
      _$_MapStyleItem _value, $Res Function(_$_MapStyleItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? featureType = freezed,
    Object? elementType = freezed,
    Object? stylers = freezed,
  }) {
    return _then(_$_MapStyleItem(
      featureType: freezed == featureType
          ? _value.featureType
          : featureType // ignore: cast_nullable_to_non_nullable
              as String?,
      elementType: freezed == elementType
          ? _value.elementType
          : elementType // ignore: cast_nullable_to_non_nullable
              as String?,
      stylers: freezed == stylers
          ? _value._stylers
          : stylers // ignore: cast_nullable_to_non_nullable
              as List<Map<String, String>>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MapStyleItem implements _MapStyleItem {
  const _$_MapStyleItem(
      {this.featureType,
      this.elementType,
      final List<Map<String, String>>? stylers})
      : _stylers = stylers;

  factory _$_MapStyleItem.fromJson(Map<String, dynamic> json) =>
      _$$_MapStyleItemFromJson(json);

  @override
  final String? featureType;
  @override
  final String? elementType;
  final List<Map<String, String>>? _stylers;
  @override
  List<Map<String, String>>? get stylers {
    final value = _stylers;
    if (value == null) return null;
    if (_stylers is EqualUnmodifiableListView) return _stylers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MapStyleItem(featureType: $featureType, elementType: $elementType, stylers: $stylers)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MapStyleItem &&
            (identical(other.featureType, featureType) ||
                other.featureType == featureType) &&
            (identical(other.elementType, elementType) ||
                other.elementType == elementType) &&
            const DeepCollectionEquality().equals(other._stylers, _stylers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, featureType, elementType,
      const DeepCollectionEquality().hash(_stylers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MapStyleItemCopyWith<_$_MapStyleItem> get copyWith =>
      __$$_MapStyleItemCopyWithImpl<_$_MapStyleItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MapStyleItemToJson(
      this,
    );
  }
}

abstract class _MapStyleItem implements MapStyleItem {
  const factory _MapStyleItem(
      {final String? featureType,
      final String? elementType,
      final List<Map<String, String>>? stylers}) = _$_MapStyleItem;

  factory _MapStyleItem.fromJson(Map<String, dynamic> json) =
      _$_MapStyleItem.fromJson;

  @override
  String? get featureType;
  @override
  String? get elementType;
  @override
  List<Map<String, String>>? get stylers;
  @override
  @JsonKey(ignore: true)
  _$$_MapStyleItemCopyWith<_$_MapStyleItem> get copyWith =>
      throw _privateConstructorUsedError;
}

MapStyle _$MapStyleFromJson(Map<String, dynamic> json) {
  return _MapStyle.fromJson(json);
}

/// @nodoc
mixin _$MapStyle {
  List<MapStyleItem>? get styleItems => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MapStyleCopyWith<MapStyle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapStyleCopyWith<$Res> {
  factory $MapStyleCopyWith(MapStyle value, $Res Function(MapStyle) then) =
      _$MapStyleCopyWithImpl<$Res, MapStyle>;
  @useResult
  $Res call({List<MapStyleItem>? styleItems});
}

/// @nodoc
class _$MapStyleCopyWithImpl<$Res, $Val extends MapStyle>
    implements $MapStyleCopyWith<$Res> {
  _$MapStyleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? styleItems = freezed,
  }) {
    return _then(_value.copyWith(
      styleItems: freezed == styleItems
          ? _value.styleItems
          : styleItems // ignore: cast_nullable_to_non_nullable
              as List<MapStyleItem>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MapStyleCopyWith<$Res> implements $MapStyleCopyWith<$Res> {
  factory _$$_MapStyleCopyWith(
          _$_MapStyle value, $Res Function(_$_MapStyle) then) =
      __$$_MapStyleCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<MapStyleItem>? styleItems});
}

/// @nodoc
class __$$_MapStyleCopyWithImpl<$Res>
    extends _$MapStyleCopyWithImpl<$Res, _$_MapStyle>
    implements _$$_MapStyleCopyWith<$Res> {
  __$$_MapStyleCopyWithImpl(
      _$_MapStyle _value, $Res Function(_$_MapStyle) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? styleItems = freezed,
  }) {
    return _then(_$_MapStyle(
      styleItems: freezed == styleItems
          ? _value._styleItems
          : styleItems // ignore: cast_nullable_to_non_nullable
              as List<MapStyleItem>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MapStyle implements _MapStyle {
  const _$_MapStyle({final List<MapStyleItem>? styleItems})
      : _styleItems = styleItems;

  factory _$_MapStyle.fromJson(Map<String, dynamic> json) =>
      _$$_MapStyleFromJson(json);

  final List<MapStyleItem>? _styleItems;
  @override
  List<MapStyleItem>? get styleItems {
    final value = _styleItems;
    if (value == null) return null;
    if (_styleItems is EqualUnmodifiableListView) return _styleItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MapStyle(styleItems: $styleItems)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MapStyle &&
            const DeepCollectionEquality()
                .equals(other._styleItems, _styleItems));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_styleItems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MapStyleCopyWith<_$_MapStyle> get copyWith =>
      __$$_MapStyleCopyWithImpl<_$_MapStyle>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MapStyleToJson(
      this,
    );
  }
}

abstract class _MapStyle implements MapStyle {
  const factory _MapStyle({final List<MapStyleItem>? styleItems}) = _$_MapStyle;

  factory _MapStyle.fromJson(Map<String, dynamic> json) = _$_MapStyle.fromJson;

  @override
  List<MapStyleItem>? get styleItems;
  @override
  @JsonKey(ignore: true)
  _$$_MapStyleCopyWith<_$_MapStyle> get copyWith =>
      throw _privateConstructorUsedError;
}
