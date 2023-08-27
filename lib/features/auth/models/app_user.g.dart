// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppUser _$$_AppUserFromJson(Map<String, dynamic> json) => _$_AppUser(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      role: $enumDecode(_$AppUserRoleEnumMap, json['role']),
      bloodGroup: $enumDecode(_$BloodGroupEnumMap, json['bloodGroup']),
      idNumber: json['idNumber'] as String,
      relativePhone: json['relativePhone'] as String?,
      relativeCountryPhoneCode: json['relativeCountryPhoneCode'] as String?,
      relativeCountryLetterCode: json['relativeCountryLetterCode'] as String?,
      relativeType: $enumDecode(_$RelativeTypeEnumMap, json['relativeType']),
      diseases: json['diseases'] as String?,
      medicines: json['medicines'] as String?,
      peopleAtSameAddress: json['peopleAtSameAddress'] as String?,
      address: json['address'] as String?,
      buildingAge: json['buildingAge'] as String?,
      buildingDurability: json['buildingDurability'] as String?,
      profilePicUrl: json['profilePicUrl'] as String?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      countryPhoneCode: json['countryPhoneCode'] as String,
      countryLetterCode: json['countryLetterCode'] as String,
      phone: json['phone'] as String,
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
      cihazid: json['cihazid'] as String?,
      plakaKodu: json['plakaKodu'] as String,
      ilceKodu: json['ilceKodu'] as String,
    );

Map<String, dynamic> _$$_AppUserToJson(_$_AppUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'fullName': instance.fullName,
      'role': _$AppUserRoleEnumMap[instance.role]!,
      'bloodGroup': _$BloodGroupEnumMap[instance.bloodGroup]!,
      'idNumber': instance.idNumber,
      'relativePhone': instance.relativePhone,
      'relativeCountryPhoneCode': instance.relativeCountryPhoneCode,
      'relativeCountryLetterCode': instance.relativeCountryLetterCode,
      'relativeType': _$RelativeTypeEnumMap[instance.relativeType]!,
      'diseases': instance.diseases,
      'medicines': instance.medicines,
      'peopleAtSameAddress': instance.peopleAtSameAddress,
      'address': instance.address,
      'buildingAge': instance.buildingAge,
      'buildingDurability': instance.buildingDurability,
      'profilePicUrl': instance.profilePicUrl,
      'birthDate': instance.birthDate?.toIso8601String(),
      'countryPhoneCode': instance.countryPhoneCode,
      'countryLetterCode': instance.countryLetterCode,
      'phone': instance.phone,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
      'cihazid': instance.cihazid,
      'plakaKodu': instance.plakaKodu,
      'ilceKodu': instance.ilceKodu,
    };

const _$AppUserRoleEnumMap = {
  AppUserRole.admin: 'admin',
  AppUserRole.user: 'user',
};

const _$BloodGroupEnumMap = {
  BloodGroup.zeroPositive: 'zeroPositive',
  BloodGroup.zeroNegative: 'zeroNegative',
  BloodGroup.aPositive: 'aPositive',
  BloodGroup.aNegative: 'aNegative',
  BloodGroup.bPositive: 'bPositive',
  BloodGroup.bNegative: 'bNegative',
  BloodGroup.abPositive: 'abPositive',
  BloodGroup.abNegative: 'abNegative',
};

const _$RelativeTypeEnumMap = {
  RelativeType.mother: 'mother',
  RelativeType.father: 'father',
  RelativeType.sibling: 'sibling',
  RelativeType.spouse: 'spouse',
  RelativeType.kid: 'kid',
  RelativeType.grandchild: 'grandchild',
  RelativeType.grandmother: 'grandmother',
  RelativeType.grandfather: 'grandfather',
  RelativeType.aunt: 'aunt',
  RelativeType.uncle: 'uncle',
  RelativeType.cousin: 'cousin',
  RelativeType.other: 'other',
};
