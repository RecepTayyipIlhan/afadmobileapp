// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_account_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DeleteAccountState {
  AuthMode? get authMode => throw _privateConstructorUsedError;
  Ref<Object?> get ref => throw _privateConstructorUsedError;
  DeleteAccountPassState? get passState => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeleteAccountStateCopyWith<DeleteAccountState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteAccountStateCopyWith<$Res> {
  factory $DeleteAccountStateCopyWith(
          DeleteAccountState value, $Res Function(DeleteAccountState) then) =
      _$DeleteAccountStateCopyWithImpl<$Res, DeleteAccountState>;
  @useResult
  $Res call(
      {AuthMode? authMode,
      Ref<Object?> ref,
      DeleteAccountPassState? passState});

  $DeleteAccountPassStateCopyWith<$Res>? get passState;
}

/// @nodoc
class _$DeleteAccountStateCopyWithImpl<$Res, $Val extends DeleteAccountState>
    implements $DeleteAccountStateCopyWith<$Res> {
  _$DeleteAccountStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authMode = freezed,
    Object? ref = null,
    Object? passState = freezed,
  }) {
    return _then(_value.copyWith(
      authMode: freezed == authMode
          ? _value.authMode
          : authMode // ignore: cast_nullable_to_non_nullable
              as AuthMode?,
      ref: null == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as Ref<Object?>,
      passState: freezed == passState
          ? _value.passState
          : passState // ignore: cast_nullable_to_non_nullable
              as DeleteAccountPassState?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DeleteAccountPassStateCopyWith<$Res>? get passState {
    if (_value.passState == null) {
      return null;
    }

    return $DeleteAccountPassStateCopyWith<$Res>(_value.passState!, (value) {
      return _then(_value.copyWith(passState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_DeleteAccountStateCopyWith<$Res>
    implements $DeleteAccountStateCopyWith<$Res> {
  factory _$$_DeleteAccountStateCopyWith(_$_DeleteAccountState value,
          $Res Function(_$_DeleteAccountState) then) =
      __$$_DeleteAccountStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AuthMode? authMode,
      Ref<Object?> ref,
      DeleteAccountPassState? passState});

  @override
  $DeleteAccountPassStateCopyWith<$Res>? get passState;
}

/// @nodoc
class __$$_DeleteAccountStateCopyWithImpl<$Res>
    extends _$DeleteAccountStateCopyWithImpl<$Res, _$_DeleteAccountState>
    implements _$$_DeleteAccountStateCopyWith<$Res> {
  __$$_DeleteAccountStateCopyWithImpl(
      _$_DeleteAccountState _value, $Res Function(_$_DeleteAccountState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authMode = freezed,
    Object? ref = null,
    Object? passState = freezed,
  }) {
    return _then(_$_DeleteAccountState(
      authMode: freezed == authMode
          ? _value.authMode
          : authMode // ignore: cast_nullable_to_non_nullable
              as AuthMode?,
      ref: null == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as Ref<Object?>,
      passState: freezed == passState
          ? _value.passState
          : passState // ignore: cast_nullable_to_non_nullable
              as DeleteAccountPassState?,
    ));
  }
}

/// @nodoc

class _$_DeleteAccountState extends _DeleteAccountState {
  const _$_DeleteAccountState(
      {required this.authMode, required this.ref, required this.passState})
      : super._();

  @override
  final AuthMode? authMode;
  @override
  final Ref<Object?> ref;
  @override
  final DeleteAccountPassState? passState;

  @override
  String toString() {
    return 'DeleteAccountState(authMode: $authMode, ref: $ref, passState: $passState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeleteAccountState &&
            (identical(other.authMode, authMode) ||
                other.authMode == authMode) &&
            (identical(other.ref, ref) || other.ref == ref) &&
            (identical(other.passState, passState) ||
                other.passState == passState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, authMode, ref, passState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeleteAccountStateCopyWith<_$_DeleteAccountState> get copyWith =>
      __$$_DeleteAccountStateCopyWithImpl<_$_DeleteAccountState>(
          this, _$identity);
}

abstract class _DeleteAccountState extends DeleteAccountState {
  const factory _DeleteAccountState(
          {required final AuthMode? authMode,
          required final Ref<Object?> ref,
          required final DeleteAccountPassState? passState}) =
      _$_DeleteAccountState;
  const _DeleteAccountState._() : super._();

  @override
  AuthMode? get authMode;
  @override
  Ref<Object?> get ref;
  @override
  DeleteAccountPassState? get passState;
  @override
  @JsonKey(ignore: true)
  _$$_DeleteAccountStateCopyWith<_$_DeleteAccountState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DeleteAccountPassState {
  Ref<Object?> get ref => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeleteAccountPassStateCopyWith<DeleteAccountPassState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteAccountPassStateCopyWith<$Res> {
  factory $DeleteAccountPassStateCopyWith(DeleteAccountPassState value,
          $Res Function(DeleteAccountPassState) then) =
      _$DeleteAccountPassStateCopyWithImpl<$Res, DeleteAccountPassState>;
  @useResult
  $Res call({Ref<Object?> ref, String? password});
}

/// @nodoc
class _$DeleteAccountPassStateCopyWithImpl<$Res,
        $Val extends DeleteAccountPassState>
    implements $DeleteAccountPassStateCopyWith<$Res> {
  _$DeleteAccountPassStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ref = null,
    Object? password = freezed,
  }) {
    return _then(_value.copyWith(
      ref: null == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as Ref<Object?>,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DeleteAccountPassStateCopyWith<$Res>
    implements $DeleteAccountPassStateCopyWith<$Res> {
  factory _$$_DeleteAccountPassStateCopyWith(_$_DeleteAccountPassState value,
          $Res Function(_$_DeleteAccountPassState) then) =
      __$$_DeleteAccountPassStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Ref<Object?> ref, String? password});
}

/// @nodoc
class __$$_DeleteAccountPassStateCopyWithImpl<$Res>
    extends _$DeleteAccountPassStateCopyWithImpl<$Res,
        _$_DeleteAccountPassState>
    implements _$$_DeleteAccountPassStateCopyWith<$Res> {
  __$$_DeleteAccountPassStateCopyWithImpl(_$_DeleteAccountPassState _value,
      $Res Function(_$_DeleteAccountPassState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ref = null,
    Object? password = freezed,
  }) {
    return _then(_$_DeleteAccountPassState(
      ref: null == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as Ref<Object?>,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_DeleteAccountPassState extends _DeleteAccountPassState {
  const _$_DeleteAccountPassState({required this.ref, this.password})
      : super._();

  @override
  final Ref<Object?> ref;
  @override
  final String? password;

  @override
  String toString() {
    return 'DeleteAccountPassState(ref: $ref, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeleteAccountPassState &&
            (identical(other.ref, ref) || other.ref == ref) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ref, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeleteAccountPassStateCopyWith<_$_DeleteAccountPassState> get copyWith =>
      __$$_DeleteAccountPassStateCopyWithImpl<_$_DeleteAccountPassState>(
          this, _$identity);
}

abstract class _DeleteAccountPassState extends DeleteAccountPassState {
  const factory _DeleteAccountPassState(
      {required final Ref<Object?> ref,
      final String? password}) = _$_DeleteAccountPassState;
  const _DeleteAccountPassState._() : super._();

  @override
  Ref<Object?> get ref;
  @override
  String? get password;
  @override
  @JsonKey(ignore: true)
  _$$_DeleteAccountPassStateCopyWith<_$_DeleteAccountPassState> get copyWith =>
      throw _privateConstructorUsedError;
}
