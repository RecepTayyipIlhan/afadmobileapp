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
  String get fullName => throw _privateConstructorUsedError;
  AppUserRole get role => throw _privateConstructorUsedError;
  BloodGroup get bloodGroup => throw _privateConstructorUsedError;
  String get idNumber => throw _privateConstructorUsedError;
  String get relativePhone => throw _privateConstructorUsedError;
  String? get relativeCountryPhoneCode => throw _privateConstructorUsedError;
  String? get relativeCountryLetterCode => throw _privateConstructorUsedError;
  RelativeType get relativeType => throw _privateConstructorUsedError;
  String? get diseases => throw _privateConstructorUsedError;
  String? get medicines => throw _privateConstructorUsedError;
  String? get peopleAtSameAddress => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get buildingAge => throw _privateConstructorUsedError;
  String? get buildingDurability => throw _privateConstructorUsedError;
  String? get profilePicUrl => throw _privateConstructorUsedError;
  DateTime? get birthDate => throw _privateConstructorUsedError;
  String get countryPhoneCode => throw _privateConstructorUsedError;
  String get countryLetterCode => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get isLoading => throw _privateConstructorUsedError;
  DateTime? get lastUpdated => throw _privateConstructorUsedError;
  String? get cihazid => throw _privateConstructorUsedError;

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
      String fullName,
      AppUserRole role,
      BloodGroup bloodGroup,
      String idNumber,
      String relativePhone,
      String? relativeCountryPhoneCode,
      String? relativeCountryLetterCode,
      RelativeType relativeType,
      String? diseases,
      String? medicines,
      String? peopleAtSameAddress,
      String? address,
      String? buildingAge,
      String? buildingDurability,
      String? profilePicUrl,
      DateTime? birthDate,
      String countryPhoneCode,
      String countryLetterCode,
      String phone,
      @JsonKey(includeFromJson: false, includeToJson: false) bool isLoading,
      DateTime? lastUpdated,
      String? cihazid});
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
    Object? fullName = null,
    Object? role = null,
    Object? bloodGroup = null,
    Object? idNumber = null,
    Object? relativePhone = null,
    Object? relativeCountryPhoneCode = freezed,
    Object? relativeCountryLetterCode = freezed,
    Object? relativeType = null,
    Object? diseases = freezed,
    Object? medicines = freezed,
    Object? peopleAtSameAddress = freezed,
    Object? address = freezed,
    Object? buildingAge = freezed,
    Object? buildingDurability = freezed,
    Object? profilePicUrl = freezed,
    Object? birthDate = freezed,
    Object? countryPhoneCode = null,
    Object? countryLetterCode = null,
    Object? phone = null,
    Object? isLoading = null,
    Object? lastUpdated = freezed,
    Object? cihazid = freezed,
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
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as AppUserRole,
      bloodGroup: null == bloodGroup
          ? _value.bloodGroup
          : bloodGroup // ignore: cast_nullable_to_non_nullable
              as BloodGroup,
      idNumber: null == idNumber
          ? _value.idNumber
          : idNumber // ignore: cast_nullable_to_non_nullable
              as String,
      relativePhone: null == relativePhone
          ? _value.relativePhone
          : relativePhone // ignore: cast_nullable_to_non_nullable
              as String,
      relativeCountryPhoneCode: freezed == relativeCountryPhoneCode
          ? _value.relativeCountryPhoneCode
          : relativeCountryPhoneCode // ignore: cast_nullable_to_non_nullable
              as String?,
      relativeCountryLetterCode: freezed == relativeCountryLetterCode
          ? _value.relativeCountryLetterCode
          : relativeCountryLetterCode // ignore: cast_nullable_to_non_nullable
              as String?,
      relativeType: null == relativeType
          ? _value.relativeType
          : relativeType // ignore: cast_nullable_to_non_nullable
              as RelativeType,
      diseases: freezed == diseases
          ? _value.diseases
          : diseases // ignore: cast_nullable_to_non_nullable
              as String?,
      medicines: freezed == medicines
          ? _value.medicines
          : medicines // ignore: cast_nullable_to_non_nullable
              as String?,
      peopleAtSameAddress: freezed == peopleAtSameAddress
          ? _value.peopleAtSameAddress
          : peopleAtSameAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      buildingAge: freezed == buildingAge
          ? _value.buildingAge
          : buildingAge // ignore: cast_nullable_to_non_nullable
              as String?,
      buildingDurability: freezed == buildingDurability
          ? _value.buildingDurability
          : buildingDurability // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePicUrl: freezed == profilePicUrl
          ? _value.profilePicUrl
          : profilePicUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      birthDate: freezed == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      countryPhoneCode: null == countryPhoneCode
          ? _value.countryPhoneCode
          : countryPhoneCode // ignore: cast_nullable_to_non_nullable
              as String,
      countryLetterCode: null == countryLetterCode
          ? _value.countryLetterCode
          : countryLetterCode // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cihazid: freezed == cihazid
          ? _value.cihazid
          : cihazid // ignore: cast_nullable_to_non_nullable
              as String?,
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
      String fullName,
      AppUserRole role,
      BloodGroup bloodGroup,
      String idNumber,
      String relativePhone,
      String? relativeCountryPhoneCode,
      String? relativeCountryLetterCode,
      RelativeType relativeType,
      String? diseases,
      String? medicines,
      String? peopleAtSameAddress,
      String? address,
      String? buildingAge,
      String? buildingDurability,
      String? profilePicUrl,
      DateTime? birthDate,
      String countryPhoneCode,
      String countryLetterCode,
      String phone,
      @JsonKey(includeFromJson: false, includeToJson: false) bool isLoading,
      DateTime? lastUpdated,
      String? cihazid});
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
    Object? fullName = null,
    Object? role = null,
    Object? bloodGroup = null,
    Object? idNumber = null,
    Object? relativePhone = null,
    Object? relativeCountryPhoneCode = freezed,
    Object? relativeCountryLetterCode = freezed,
    Object? relativeType = null,
    Object? diseases = freezed,
    Object? medicines = freezed,
    Object? peopleAtSameAddress = freezed,
    Object? address = freezed,
    Object? buildingAge = freezed,
    Object? buildingDurability = freezed,
    Object? profilePicUrl = freezed,
    Object? birthDate = freezed,
    Object? countryPhoneCode = null,
    Object? countryLetterCode = null,
    Object? phone = null,
    Object? isLoading = null,
    Object? lastUpdated = freezed,
    Object? cihazid = freezed,
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
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as AppUserRole,
      bloodGroup: null == bloodGroup
          ? _value.bloodGroup
          : bloodGroup // ignore: cast_nullable_to_non_nullable
              as BloodGroup,
      idNumber: null == idNumber
          ? _value.idNumber
          : idNumber // ignore: cast_nullable_to_non_nullable
              as String,
      relativePhone: null == relativePhone
          ? _value.relativePhone
          : relativePhone // ignore: cast_nullable_to_non_nullable
              as String,
      relativeCountryPhoneCode: freezed == relativeCountryPhoneCode
          ? _value.relativeCountryPhoneCode
          : relativeCountryPhoneCode // ignore: cast_nullable_to_non_nullable
              as String?,
      relativeCountryLetterCode: freezed == relativeCountryLetterCode
          ? _value.relativeCountryLetterCode
          : relativeCountryLetterCode // ignore: cast_nullable_to_non_nullable
              as String?,
      relativeType: null == relativeType
          ? _value.relativeType
          : relativeType // ignore: cast_nullable_to_non_nullable
              as RelativeType,
      diseases: freezed == diseases
          ? _value.diseases
          : diseases // ignore: cast_nullable_to_non_nullable
              as String?,
      medicines: freezed == medicines
          ? _value.medicines
          : medicines // ignore: cast_nullable_to_non_nullable
              as String?,
      peopleAtSameAddress: freezed == peopleAtSameAddress
          ? _value.peopleAtSameAddress
          : peopleAtSameAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      buildingAge: freezed == buildingAge
          ? _value.buildingAge
          : buildingAge // ignore: cast_nullable_to_non_nullable
              as String?,
      buildingDurability: freezed == buildingDurability
          ? _value.buildingDurability
          : buildingDurability // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePicUrl: freezed == profilePicUrl
          ? _value.profilePicUrl
          : profilePicUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      birthDate: freezed == birthDate
          ? _value.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      countryPhoneCode: null == countryPhoneCode
          ? _value.countryPhoneCode
          : countryPhoneCode // ignore: cast_nullable_to_non_nullable
              as String,
      countryLetterCode: null == countryLetterCode
          ? _value.countryLetterCode
          : countryLetterCode // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cihazid: freezed == cihazid
          ? _value.cihazid
          : cihazid // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppUser extends _AppUser {
  _$_AppUser(
      {required this.id,
      required this.email,
      required this.fullName,
      required this.role,
      required this.bloodGroup,
      required this.idNumber,
      required this.relativePhone,
      this.relativeCountryPhoneCode,
      this.relativeCountryLetterCode,
      required this.relativeType,
      this.diseases,
      this.medicines,
      this.peopleAtSameAddress,
      required this.address,
      this.buildingAge,
      this.buildingDurability,
      this.profilePicUrl,
      this.birthDate,
      required this.countryPhoneCode,
      required this.countryLetterCode,
      required this.phone,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.isLoading = false,
      this.lastUpdated,
      this.cihazid})
      : super._();

  factory _$_AppUser.fromJson(Map<String, dynamic> json) =>
      _$$_AppUserFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String fullName;
  @override
  final AppUserRole role;
  @override
  final BloodGroup bloodGroup;
  @override
  final String idNumber;
  @override
  final String relativePhone;
  @override
  final String? relativeCountryPhoneCode;
  @override
  final String? relativeCountryLetterCode;
  @override
  final RelativeType relativeType;
  @override
  final String? diseases;
  @override
  final String? medicines;
  @override
  final String? peopleAtSameAddress;
  @override
  final String? address;
  @override
  final String? buildingAge;
  @override
  final String? buildingDurability;
  @override
  final String? profilePicUrl;
  @override
  final DateTime? birthDate;
  @override
  final String countryPhoneCode;
  @override
  final String countryLetterCode;
  @override
  final String phone;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool isLoading;
  @override
  final DateTime? lastUpdated;
  @override
  final String? cihazid;

  @override
  String toString() {
    return 'AppUser(id: $id, email: $email, fullName: $fullName, role: $role, bloodGroup: $bloodGroup, idNumber: $idNumber, relativePhone: $relativePhone, relativeCountryPhoneCode: $relativeCountryPhoneCode, relativeCountryLetterCode: $relativeCountryLetterCode, relativeType: $relativeType, diseases: $diseases, medicines: $medicines, peopleAtSameAddress: $peopleAtSameAddress, address: $address, buildingAge: $buildingAge, buildingDurability: $buildingDurability, profilePicUrl: $profilePicUrl, birthDate: $birthDate, countryPhoneCode: $countryPhoneCode, countryLetterCode: $countryLetterCode, phone: $phone, isLoading: $isLoading, lastUpdated: $lastUpdated, cihazid: $cihazid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.bloodGroup, bloodGroup) ||
                other.bloodGroup == bloodGroup) &&
            (identical(other.idNumber, idNumber) ||
                other.idNumber == idNumber) &&
            (identical(other.relativePhone, relativePhone) ||
                other.relativePhone == relativePhone) &&
            (identical(
                    other.relativeCountryPhoneCode, relativeCountryPhoneCode) ||
                other.relativeCountryPhoneCode == relativeCountryPhoneCode) &&
            (identical(other.relativeCountryLetterCode,
                    relativeCountryLetterCode) ||
                other.relativeCountryLetterCode == relativeCountryLetterCode) &&
            (identical(other.relativeType, relativeType) ||
                other.relativeType == relativeType) &&
            (identical(other.diseases, diseases) ||
                other.diseases == diseases) &&
            (identical(other.medicines, medicines) ||
                other.medicines == medicines) &&
            (identical(other.peopleAtSameAddress, peopleAtSameAddress) ||
                other.peopleAtSameAddress == peopleAtSameAddress) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.buildingAge, buildingAge) ||
                other.buildingAge == buildingAge) &&
            (identical(other.buildingDurability, buildingDurability) ||
                other.buildingDurability == buildingDurability) &&
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
                other.lastUpdated == lastUpdated) &&
            (identical(other.cihazid, cihazid) || other.cihazid == cihazid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        email,
        fullName,
        role,
        bloodGroup,
        idNumber,
        relativePhone,
        relativeCountryPhoneCode,
        relativeCountryLetterCode,
        relativeType,
        diseases,
        medicines,
        peopleAtSameAddress,
        address,
        buildingAge,
        buildingDurability,
        profilePicUrl,
        birthDate,
        countryPhoneCode,
        countryLetterCode,
        phone,
        isLoading,
        lastUpdated,
        cihazid
      ]);

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
      required final String fullName,
      required final AppUserRole role,
      required final BloodGroup bloodGroup,
      required final String idNumber,
      required final String relativePhone,
      final String? relativeCountryPhoneCode,
      final String? relativeCountryLetterCode,
      required final RelativeType relativeType,
      final String? diseases,
      final String? medicines,
      final String? peopleAtSameAddress,
      required final String? address,
      final String? buildingAge,
      final String? buildingDurability,
      final String? profilePicUrl,
      final DateTime? birthDate,
      required final String countryPhoneCode,
      required final String countryLetterCode,
      required final String phone,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final bool isLoading,
      final DateTime? lastUpdated,
      final String? cihazid}) = _$_AppUser;
  _AppUser._() : super._();

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$_AppUser.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String get fullName;
  @override
  AppUserRole get role;
  @override
  BloodGroup get bloodGroup;
  @override
  String get idNumber;
  @override
  String get relativePhone;
  @override
  String? get relativeCountryPhoneCode;
  @override
  String? get relativeCountryLetterCode;
  @override
  RelativeType get relativeType;
  @override
  String? get diseases;
  @override
  String? get medicines;
  @override
  String? get peopleAtSameAddress;
  @override
  String? get address;
  @override
  String? get buildingAge;
  @override
  String? get buildingDurability;
  @override
  String? get profilePicUrl;
  @override
  DateTime? get birthDate;
  @override
  String get countryPhoneCode;
  @override
  String get countryLetterCode;
  @override
  String get phone;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get isLoading;
  @override
  DateTime? get lastUpdated;
  @override
  String? get cihazid;
  @override
  @JsonKey(ignore: true)
  _$$_AppUserCopyWith<_$_AppUser> get copyWith =>
      throw _privateConstructorUsedError;
}
