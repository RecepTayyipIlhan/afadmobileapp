// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginState {
  String? get email => throw _privateConstructorUsedError;
  String? get pass => throw _privateConstructorUsedError;
  GlobalKey<FormState> get formKey => throw _privateConstructorUsedError;
  AuthMode get mode => throw _privateConstructorUsedError;
  int? get emailLinkResendSecondsLeft => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginStateCopyWith<LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res, LoginState>;
  @useResult
  $Res call(
      {String? email,
      String? pass,
      GlobalKey<FormState> formKey,
      AuthMode mode,
      int? emailLinkResendSecondsLeft});
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? pass = freezed,
    Object? formKey = null,
    Object? mode = null,
    Object? emailLinkResendSecondsLeft = freezed,
  }) {
    return _then(_value.copyWith(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      pass: freezed == pass
          ? _value.pass
          : pass // ignore: cast_nullable_to_non_nullable
              as String?,
      formKey: null == formKey
          ? _value.formKey
          : formKey // ignore: cast_nullable_to_non_nullable
              as GlobalKey<FormState>,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as AuthMode,
      emailLinkResendSecondsLeft: freezed == emailLinkResendSecondsLeft
          ? _value.emailLinkResendSecondsLeft
          : emailLinkResendSecondsLeft // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LoginStateCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory _$$_LoginStateCopyWith(
          _$_LoginState value, $Res Function(_$_LoginState) then) =
      __$$_LoginStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? email,
      String? pass,
      GlobalKey<FormState> formKey,
      AuthMode mode,
      int? emailLinkResendSecondsLeft});
}

/// @nodoc
class __$$_LoginStateCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$_LoginState>
    implements _$$_LoginStateCopyWith<$Res> {
  __$$_LoginStateCopyWithImpl(
      _$_LoginState _value, $Res Function(_$_LoginState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? pass = freezed,
    Object? formKey = null,
    Object? mode = null,
    Object? emailLinkResendSecondsLeft = freezed,
  }) {
    return _then(_$_LoginState(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      pass: freezed == pass
          ? _value.pass
          : pass // ignore: cast_nullable_to_non_nullable
              as String?,
      formKey: null == formKey
          ? _value.formKey
          : formKey // ignore: cast_nullable_to_non_nullable
              as GlobalKey<FormState>,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as AuthMode,
      emailLinkResendSecondsLeft: freezed == emailLinkResendSecondsLeft
          ? _value.emailLinkResendSecondsLeft
          : emailLinkResendSecondsLeft // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_LoginState extends _LoginState {
  const _$_LoginState(
      {this.email,
      this.pass,
      required this.formKey,
      required this.mode,
      this.emailLinkResendSecondsLeft})
      : super._();

  @override
  final String? email;
  @override
  final String? pass;
  @override
  final GlobalKey<FormState> formKey;
  @override
  final AuthMode mode;
  @override
  final int? emailLinkResendSecondsLeft;

  @override
  String toString() {
    return 'LoginState(email: $email, pass: $pass, formKey: $formKey, mode: $mode, emailLinkResendSecondsLeft: $emailLinkResendSecondsLeft)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoginState &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.pass, pass) || other.pass == pass) &&
            (identical(other.formKey, formKey) || other.formKey == formKey) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.emailLinkResendSecondsLeft,
                    emailLinkResendSecondsLeft) ||
                other.emailLinkResendSecondsLeft ==
                    emailLinkResendSecondsLeft));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, email, pass, formKey, mode, emailLinkResendSecondsLeft);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoginStateCopyWith<_$_LoginState> get copyWith =>
      __$$_LoginStateCopyWithImpl<_$_LoginState>(this, _$identity);
}

abstract class _LoginState extends LoginState {
  const factory _LoginState(
      {final String? email,
      final String? pass,
      required final GlobalKey<FormState> formKey,
      required final AuthMode mode,
      final int? emailLinkResendSecondsLeft}) = _$_LoginState;
  const _LoginState._() : super._();

  @override
  String? get email;
  @override
  String? get pass;
  @override
  GlobalKey<FormState> get formKey;
  @override
  AuthMode get mode;
  @override
  int? get emailLinkResendSecondsLeft;
  @override
  @JsonKey(ignore: true)
  _$$_LoginStateCopyWith<_$_LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}
