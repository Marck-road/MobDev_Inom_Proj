class Cocktail {
  String drinkName;
  String drinkID;
  String drinkPic;

  Cocktail(
    this.drinkName,
    this.drinkID,
    this.drinkPic,
  );

  factory Cocktail.fromJson(Map<String, dynamic> json) {
    return Cocktail(
      json['strDrink'],
      json['idDrink'],
      json['strDrinkThumb'],
    );
  }

  factory Cocktail.fromJsonList(List<dynamic> json) {
    return Cocktail(
      json[0]['strDrink'],
      json[0]['idDrink'],
      json[0]['strDrinkThumb'],
    );
  }
}
