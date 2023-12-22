import 'dart:convert';

class Post {
  String commonName;
  String officialName;
  String cca2;
  List<dynamic>? capital;
  String region;
  String? subregion;
  int? population;
  double? area;
  Map<String, dynamic>? languages;
  Map<String, dynamic>? currencies;
  String flagSvg;
  String? flagAlt;

  Post(
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

  factory Post.fromJson(String body) {
    var parsedJson = jsonDecode(body);

    return Post(
      parsedJson[0]['name']['common'],
      parsedJson[0]['name']['official'],
      parsedJson[0]['cca2'],
      parsedJson[0]["capital"],
      parsedJson[0]["region"],
      parsedJson[0]["subregion"],
      parsedJson[0]["population"],
      parsedJson[0]["area"],
      parsedJson[0]["languages"],
      parsedJson[0]["currencies"],
      parsedJson[0]['flags']['svg'],
      parsedJson[0]['flags']['alt'],
    );
  }

  factory Post.fromJsonList(dynamic json) {
    return Post(
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
