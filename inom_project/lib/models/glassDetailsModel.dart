import 'dart:convert';

class glassModel {
  String drinkName;
  String drinkID;
  String drinkPic;

  glassModel(
    this.drinkID,
    this.drinkName,
    this.drinkPic,
  );

  factory glassModel.fromJson(String body) {
    var parsedJson = jsonDecode(body);

    return glassModel(
      parsedJson['strDrink'],
      parsedJson["strDrinkThumb"],
      parsedJson["idDrink"],
    );
  }

  factory glassModel.fromJsonList(dynamic json) {
    return glassModel(
      json['strDrink'],
      json['strDrinkThumb'],
      json['idDrink'],
    );
  }
}
