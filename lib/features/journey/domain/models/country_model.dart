class CountryModel {
  final String name;
  final String code;
  final String region;
  final String subregion;
  final String flagUrl;
  final String? capital;
  final String? mapUrl;
  final String? currency;
  final List<String>? languages;

  CountryModel({
    required this.name,
    required this.code,
    required this.region,
    required this.subregion,
    required this.flagUrl,
    this.capital,
    this.mapUrl,
    this.currency,
    this.languages,
  });

  factory CountryModel.fromV3Json(Map<String, dynamic> json) {
    final name = json['name']?['common'] ?? '';
    final code = json['cca2'] ?? '';
    final flagUrl = json['flags']?['png'] ?? '';
    final capitalList = (json['capital'] as List?) ?? [];
    final capital = capitalList.isNotEmpty ? capitalList.first : null;

    final currencies = json['currencies'] as Map<String, dynamic>?;
    final currencyName = currencies != null && currencies.isNotEmpty
        ? currencies.values.first['name']
        : null;

    final languagesMap = json['languages'] as Map<String, dynamic>?;
    final languages = languagesMap?.values.map((e) => e.toString()).toList();

    return CountryModel(
      name: name,
      code: code,
      region: json['region'] ?? '',
      subregion: json['subregion'] ?? '',
      flagUrl: flagUrl,
      capital: capital,
      currency: currencyName,
      mapUrl: json['maps']?['googleMaps'],
      languages: languages,
    );
  }
}
