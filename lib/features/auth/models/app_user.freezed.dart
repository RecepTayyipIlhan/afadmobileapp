// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return _AppUser.fromJson(json);
}

/// @nodoc
mixin _$AppUser {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  AppUserRole get role => throw _privateConstructorUsedError;
  AuthMode get authMode => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false)
  bool get confirmedEmailMarketing => throw _privateConstructorUsedError;
  String? get profilePicUrl => throw _privateConstructorUsedError;
  DateTime? get birthDate => throw _privateConstructorUsedError;
  String? get countryPhoneCode => throw _privateConstructorUsedError;
  String? get countryLetterCode => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get isLoading => throw _privateConstructorUsedError;
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppUserCopyWith<AppUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) then) =
      _$AppUserCopyWithImpl<$Res, AppUser>;
  @useResult
  $Res call(
      {String id,
      String email,
      String userName,
      String fullName,
      AppUserRole role,
      AuthMode authMode,
      @JsonKey(defaultValue: false) bool confirmedEmailMarketing,
      String? profilePicUrl,
      DateTime? birthDate,
      String? countryPhoneCode,
      String? countryLetterCode,
      String? phone,
      @JsonKey(includeFromJson: false, includeToJson: false) bool isLoading,
      DateTime? lastUpdated});
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res, $Val extends AppUser>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? userName = null,
    Object? fullName = null,
    Object? role = null,
    Object? authMode = null,
    Object? confirmedEmailMarketing = null,
    Object? profilePicUrl = freezed,
    Object? birthDate = freezed,
    Object? countryPhoneCode = freezed,
    Object? countryLetterCode = freezed,
    Object? phone = freezed,
    Object? isLoading = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as AppUserRole,
      authMode: null == authMode
          ? _value.authMode
          : authMode // ignore: cast_nullable_to_non_nullable
              as AuthMode,
      confirmedEmailMarketing: null == confirmedEmailMarketing
          ? _value.confirmedEmailMarketing
          : confirmedEmailMarketing // ignore: cast_nullable_to_non_nullable
              as bool,
      profilePicUrl: freezed == profilePicUrl
          ? _value.profilePicUrl
          : profilePicUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      birthDate: freezed == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      countryPhoneCode: freezed == countryPhoneCode
          ? _value.countryPhoneCode
          : countryPhoneCode // ignore: cast_nullable_to_non_nullable
              as String?,
      countryLetterCode: freezed == countryLetterCode
          ? _value.countryLetterCode
          : countryLetterCode // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppUserCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$$_AppUserCopyWith(
          _$_AppUser value, $Res Function(_$_AppUser) then) =
      __$$_AppUserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String email,
      String userName,
      String fullName,
      AppUserRole role,
      AuthMode authMode,
      @JsonKey(defaultValue: false) bool confirmedEmailMarketing,
      String? profilePicUrl,
      DateTime? birthDate,
      String? countryPhoneCode,
      String? countryLetterCode,
      String? phone,
      @JsonKey(includeFromJson: false, includeToJson: false) bool isLoading,
      DateTime? lastUpdated});
}

/// @nodoc
class __$$_AppUserCopyWithImpl<$Res>
    extends _$AppUserCopyWithImpl<$Res, _$_AppUser>
    implements _$$_AppUserCopyWith<$Res> {
  __$$_AppUserCopyWithImpl(_$_AppUser _value, $Res Function(_$_AppUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? userName = null,
    Object? fullName = null,
    Object? role = null,
    Object? authMode = null,
    Object? confirmedEmailMarketing = null,
    Object? profilePicUrl = freezed,
    Object? birthDate = freezed,
    Object? countryPhoneCode = freezed,
    Object? countryLetterCode = freezed,
    Object? phone = freezed,
    Object? isLoading = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(_$_AppUser(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as AppUserRole,
      authMode: null == authMode
          ? _value.authMode
          : authMode // ignore: cast_nullable_to_non_nullable
              as AuthMode,
      confirmedEmailMarketing: null == confirmedEmailMarketing
          ? _value.confirmedEmailMarketing
          : confirmedEmailMarketing // ignore: cast_nullable_to_non_nullable
              as bool,
      profilePicUrl: freezed == profilePicUrl
          ? _value.profilePicUrl
          : profilePicUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      birthDate: freezed == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      countryPhoneCode: freezed == countryPhoneCode
          ? _value.countryPhoneCode
          : countryPhoneCode // ignore: cast_nullable_to_non_nullable
              as String?,
      countryLetterCode: freezed == countryLetterCode
          ? _value.countryLetterCode
          : countryLetterCode // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppUser extends _AppUser {
  _$_AppUser(
      {required this.id,
      required this.email,
      required this.userName,
      required this.fullName,
      required this.role,
      required this.authMode,
      @JsonKey(defaultValue: false)
          required this.confirmedEmailMarketing,
      this.profilePicUrl,
      this.birthDate,
      this.countryPhoneCode,
      this.countryLetterCode,
      this.phone,
      @JsonKey(includeFromJson: false, includeToJson: false)
          this.isLoading = false,
      this.lastUpdated})
      : super._();

  factory _$_AppUser.fromJson(Map<String, dynamic> json) =>
      _$$_AppUserFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String userName;
  @override
  final String fullName;
  @override
  final AppUserRole role;
  @override
  final AuthMode authMode;
  @override
  @JsonKey(defaultValue: false)
  final bool confirmedEmailMarketing;
  @override
  final String? profilePicUrl;
  @override
  final DateTime? birthDate;
  @override
  final String? countryPhoneCode;
  @override
  final String? countryLetterCode;
  @override
  final String? phone;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool isLoading;
  @override
  final DateTime? lastUpdated;

  @override
  String toString() {
    return 'AppUser(id: $id, email: $email, userName: $userName, fullName: $fullName, role: $role, authMode: $authMode, confirmedEmailMarketing: $confirmedEmailMarketing, profilePicUrl: $profilePicUrl, birthDate: $birthDate, countryPhoneCode: $countryPhoneCode, countryLetterCode: $countryLetterCode, phone: $phone, isLoading: $isLoading, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.authMode, authMode) ||
                other.authMode == authMode) &&
            (identical(
                    other.confirmedEmailMarketing, confirmedEmailMarketing) ||
                other.confirmedEmailMarketing == confirmedEmailMarketing) &&
            (identical(other.profilePicUrl, profilePicUrl) ||
                other.profilePicUrl == profilePicUrl) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.countryPhoneCode, countryPhoneCode) ||
                other.countryPhoneCode == countryPhoneCode) &&
            (identical(other.countryLetterCode, countryLetterCode) ||
                other.countryLetterCode == countryLetterCode) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      email,
      userName,
      fullName,
      role,
      authMode,
      confirmedEmailMarketing,
      profilePicUrl,
      birthDate,
      countryPhoneCode,
      countryLetterCode,
      phone,
      isLoading,
      lastUpdated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppUserCopyWith<_$_AppUser> get copyWith =>
      __$$_AppUserCopyWithImpl<_$_AppUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppUserToJson(
      this,
    );
  }
}

abstract class _AppUser extends AppUser {
  factory _AppUser(
      {required final String id,
      required final String email,
      required final String userName,
      required final String fullName,
      required final AppUserRole role,
      required final AuthMode authMode,
      @JsonKey(defaultValue: false)
          required final bool confirmedEmailMarketing,
      final String? profilePicUrl,
      final DateTime? birthDate,
      final String? countryPhoneCode,
      final String? countryLetterCode,
      final String? phone,
      @JsonKey(includeFromJson: false, includeToJson: false)
          final bool isLoading,
      final DateTime? lastUpdated}) = _$_AppUser;
  _AppUser._() : super._();

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$_AppUser.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String get userName;
  @override
  String get fullName;
  @override
  AppUserRole get role;
  @override
  AuthMode get authMode;
  @override
  @JsonKey(defaultValue: false)
  bool get confirmedEmailMarketing;
  @override
  String? get profilePicUrl;
  @override
  DateTime? get birthDate;
  @override
  String? get countryPhoneCode;
  @override
  String? get countryLetterCode;
  @override
  String? get phone;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get isLoading;
  @override
  DateTime? get lastUpdated;
  @override
  @JsonKey(ignore: true)
  _$$_AppUserCopyWith<_$_AppUser> get copyWith =>
      throw _privateConstructorUsedError;
}
