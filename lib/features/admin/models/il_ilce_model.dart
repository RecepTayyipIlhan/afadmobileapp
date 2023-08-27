import 'package:freezed_annotation/freezed_annotation.dart';
part 'il_ilce_model.freezed.dart';
part 'il_ilce_model.g.dart';

@freezed
class IlModel with _$IlModel {
  const IlModel._();

  const factory IlModel({
    @JsonKey(name: 'il_adi') required String ilAdi,
    @JsonKey(name: 'plaka_kodu') required String plakaKodu,
    @JsonKey(name: 'alan_kodu') required String alanKodu,
    @JsonKey(name: 'nufus') required String nufus,
    @JsonKey(name: 'bolge') required String bolge,
    @JsonKey(name: 'yuzolcumu') required String yuzolcumu,
    @JsonKey(name: 'nufus_artisi') required String nufusArtisi,
    @JsonKey(name: 'erkek_nufus_yuzde') required String erkekNufusYuzde,
    @JsonKey(name: 'erkek_nufus') required String erkekNufus,
    @JsonKey(name: 'kadin_nufus_yuzde') required String kadinNufusYuzde,
    @JsonKey(name: 'kadin_nufus') required String kadinNufus,
    @JsonKey(name: 'nufus_yuzdesi_genel') required String nufusYuzdesiGenel,
    @JsonKey(name: 'ilceler') required List<IlceModel> ilceler,
  }) = _IlModel;

  factory IlModel.fromJson(Map<String, dynamic> json) =>
      _$IlModelFromJson(json);
}

@freezed
class IlceModel with _$IlceModel {
  const IlceModel._();

  const factory IlceModel({
    @JsonKey(name: 'plaka_kodu') required String plakaKodu,
    @JsonKey(name: 'ilce_kodu') required String ilceKodu,
    @JsonKey(name: 'il_adi') required String ilAdi,
    @JsonKey(name: 'ilce_adi') required String ilceAdi,
    @JsonKey(name: 'nufus') required String nufus,
    @JsonKey(name: 'erkek_nufus') required String erkekNufus,
    @JsonKey(name: 'kadin_nufus') required String kadinNufus,
  }) = _IlceModel;

  factory IlceModel.fromJson(Map<String, dynamic> json) =>
      _$IlceModelFromJson(json);
}
