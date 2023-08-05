// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppUser _$$_AppUserFromJson(Map<String, dynamic> json) => _$_AppUser(
      id: json['id'] as String,
      email: json['email'] as String,
      userName: json['userName'] as String,
      fullName: json['fullName'] as String,
      role: $enumDecode(_$AppUserRoleEnumMap, json['role']),
      confirmedEmailMarketing:
          json['confirmedEmailMarketing'] as bool? ?? false,
      profilePicUrl: json['profilePicUrl'] as String?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      countryPhoneCode: json['countryPhoneCode'] as String?,
      countryLetterCode: json['countryLetterCode'] as String?,
      phone: json['phone'] as String?,
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$_AppUserToJson(_$_AppUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'userName': instance.userName,
      'fullName': instance.fullName,
      'role': _$AppUserRoleEnumMap[instance.role]!,
      'confirmedEmailMarketing': instance.confirmedEmailMarketing,
      'profilePicUrl': instance.profilePicUrl,
      'birthDate': instance.birthDate?.toIso8601String(),
      'countryPhoneCode': instance.countryPhoneCode,
      'countryLetterCode': instance.countryLetterCode,
      'phone': instance.phone,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };

const _$AppUserRoleEnumMap = {
  AppUserRole.admin: 'admin',
  AppUserRole.user: 'user',
};
