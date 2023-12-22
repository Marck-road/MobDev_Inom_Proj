import 'dart:convert';

class detailsModel {
  String commonName;
  String officialName;
  String cca2;
  List<dynamic>? capital;
  String region;
  String? subregion;
  int? population;
  double? area;
  String? languages;
  String currencies;
  String flagSvg;
  String? flagAlt;

  detailsModel(
    this.commonName,
    this.officialName,
    this.cca2,
    this.capital,
    this.region,
    this.subregion,
    this.population,
    this.area,
    this.languages,
    this.currencies,
    this.flagSvg,
    this.flagAlt,
  );

  factory detailsModel.fromJson(String body) {
    var parsedJson = jsonDecode(body);

    List<dynamic> languagesList = parsedJson[0]["languages"].values.toList();
    String languagesString = languagesList.join(", ");
    List<dynamic> currencyList = parsedJson[0]["currencies"]
        .values
        .map((currency) => currency["name"])
        .toList();

    String currnecyString = currencyList.join(", ");

    return detailsModel(
      parsedJson[0]['name']['common'],
      parsedJson[0]['name']['official'],
      parsedJson[0]['cca2'],
      parsedJson[0]["capital"],
      parsedJson[0]["region"],
      parsedJson[0]["subregion"],
      parsedJson[0]["population"],
      parsedJson[0]["area"],
      languagesString,
      currnecyString,
      parsedJson[0]['flags']['svg'],
      parsedJson[0]['flags']['alt'],
    );
  }

  factory detailsModel.fromJsonList(dynamic json) {
    return detailsModel(
      json['name']['common'],
      json['name']['official'],
      json['cca2'],
      json['capital'],
      json['region'],
      json['subregion'],
      json['population'],
      json['area'],
      json['languages'],
      json['currencies'],
      json['flags']['svg'],
      json['flags']['alt'],
    );
  }
}
