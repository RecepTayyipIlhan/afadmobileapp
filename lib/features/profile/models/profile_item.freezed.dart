// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProfileItem {
  String get title => throw _privateConstructorUsedError;
  Future<bool> Function(BuildContext) get onTap =>
      throw _privateConstructorUsedError;
  bool get isDangerous => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProfileItemCopyWith<ProfileItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileItemCopyWith<$Res> {
  factory $ProfileItemCopyWith(
          ProfileItem value, $Res Function(ProfileItem) then) =
      _$ProfileItemCopyWithImpl<$Res, ProfileItem>;
  @useResult
  $Res call(
      {String title,
      Future<bool> Function(BuildContext) onTap,
      bool isDangerous});
}

/// @nodoc
class _$ProfileItemCopyWithImpl<$Res, $Val extends ProfileItem>
    implements $ProfileItemCopyWith<$Res> {
  _$ProfileItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? onTap = null,
    Object? isDangerous = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      onTap: null == onTap
          ? _value.onTap
          : onTap // ignore: cast_nullable_to_non_nullable
              as Future<bool> Function(BuildContext),
      isDangerous: null == isDangerous
          ? _value.isDangerous
          : isDangerous // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProfileItemCopyWith<$Res>
    implements $ProfileItemCopyWith<$Res> {
  factory _$$_ProfileItemCopyWith(
          _$_ProfileItem value, $Res Function(_$_ProfileItem) then) =
      __$$_ProfileItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      Future<bool> Function(BuildContext) onTap,
      bool isDangerous});
}

/// @nodoc
class __$$_ProfileItemCopyWithImpl<$Res>
    extends _$ProfileItemCopyWithImpl<$Res, _$_ProfileItem>
    implements _$$_ProfileItemCopyWith<$Res> {
  __$$_ProfileItemCopyWithImpl(
      _$_ProfileItem _value, $Res Function(_$_ProfileItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? onTap = null,
    Object? isDangerous = null,
  }) {
    return _then(_$_ProfileItem(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      onTap: null == onTap
          ? _value.onTap
          : onTap // ignore: cast_nullable_to_non_nullable
              as Future<bool> Function(BuildContext),
      isDangerous: null == isDangerous
          ? _value.isDangerous
          : isDangerous // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ProfileItem extends _ProfileItem {
  const _$_ProfileItem(
      {required this.title, required this.onTap, this.isDangerous = false})
      : super._();

  @override
  final String title;
  @override
  final Future<bool> Function(BuildContext) onTap;
  @override
  @JsonKey()
  final bool isDangerous;

  @override
  String toString() {
    return 'ProfileItem(title: $title, onTap: $onTap, isDangerous: $isDangerous)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProfileItem &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.onTap, onTap) || other.onTap == onTap) &&
            (identical(other.isDangerous, isDangerous) ||
                other.isDangerous == isDangerous));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, onTap, isDangerous);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProfileItemCopyWith<_$_ProfileItem> get copyWith =>
      __$$_ProfileItemCopyWithImpl<_$_ProfileItem>(this, _$identity);
}

abstract class _ProfileItem extends ProfileItem {
  const factory _ProfileItem(
      {required final String title,
      required final Future<bool> Function(BuildContext) onTap,
      final bool isDangerous}) = _$_ProfileItem;
  const _ProfileItem._() : super._();

  @override
  String get title;
  @override
  Future<bool> Function(BuildContext) get onTap;
  @override
  bool get isDangerous;
  @override
  @JsonKey(ignore: true)
  _$$_ProfileItemCopyWith<_$_ProfileItem> get copyWith =>
      throw _privateConstructorUsedError;
}
