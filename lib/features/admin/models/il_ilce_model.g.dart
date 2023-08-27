// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'il_ilce_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IlModel _$$_IlModelFromJson(Map<String, dynamic> json) => _$_IlModel(
      ilAdi: json['il_adi'] as String,
      plakaKodu: json['plaka_kodu'] as String,
      alanKodu: json['alan_kodu'] as String,
      nufus: json['nufus'] as String,
      bolge: json['bolge'] as String,
      yuzolcumu: json['yuzolcumu'] as String,
      nufusArtisi: json['nufus_artisi'] as String,
      erkekNufusYuzde: json['erkek_nufus_yuzde'] as String,
      erkekNufus: json['erkek_nufus'] as String,
      kadinNufusYuzde: json['kadin_nufus_yuzde'] as String,
      kadinNufus: json['kadin_nufus'] as String,
      nufusYuzdesiGenel: json['nufus_yuzdesi_genel'] as String,
      ilceler: (json['ilceler'] as List<dynamic>)
          .map((e) => IlceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_IlModelToJson(_$_IlModel instance) =>
    <String, dynamic>{
      'il_adi': instance.ilAdi,
      'plaka_kodu': instance.plakaKodu,
      'alan_kodu': instance.alanKodu,
      'nufus': instance.nufus,
      'bolge': instance.bolge,
      'yuzolcumu': instance.yuzolcumu,
      'nufus_artisi': instance.nufusArtisi,
      'erkek_nufus_yuzde': instance.erkekNufusYuzde,
      'erkek_nufus': instance.erkekNufus,
      'kadin_nufus_yuzde': instance.kadinNufusYuzde,
      'kadin_nufus': instance.kadinNufus,
      'nufus_yuzdesi_genel': instance.nufusYuzdesiGenel,
      'ilceler': instance.ilceler,
    };

_$_IlceModel _$$_IlceModelFromJson(Map<String, dynamic> json) => _$_IlceModel(
      plakaKodu: json['plaka_kodu'] as String,
      ilceKodu: json['ilce_kodu'] as String,
      ilAdi: json['il_adi'] as String,
      ilceAdi: json['ilce_adi'] as String,
      nufus: json['nufus'] as String,
      erkekNufus: json['erkek_nufus'] as String,
      kadinNufus: json['kadin_nufus'] as String,
    );

Map<String, dynamic> _$$_IlceModelToJson(_$_IlceModel instance) =>
    <String, dynamic>{
      'plaka_kodu': instance.plakaKodu,
      'ilce_kodu': instance.ilceKodu,
      'il_adi': instance.ilAdi,
      'ilce_adi': instance.ilceAdi,
      'nufus': instance.nufus,
      'erkek_nufus': instance.erkekNufus,
      'kadin_nufus': instance.kadinNufus,
    };
