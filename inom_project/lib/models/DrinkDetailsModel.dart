class drinkModel {
  String drinkName;
  String drinkID;
  String drinkpicture;
  String category;
  String alcoholic;
  String? tags;
  String glass;
  String instructions;
  String ingredient1;
  String ingredient2;
  String ingredient3;
  String ingredient4;
  String ingredient5;
  String ingredient6;
  String ingredient7;
  String ingredient8;
  String ingredient9;
  String ingredient10;

  drinkModel(
    this.drinkName,
    this.drinkID,
    this.drinkpicture,
    this.category,
    this.alcoholic,
    this.tags,
    this.glass,
    this.instructions,
    this.ingredient1,
    this.ingredient2,
    this.ingredient3,
    this.ingredient4,
    this.ingredient5,
    this.ingredient6,
    this.ingredient7,
    this.ingredient8,
    this.ingredient9,
    this.ingredient10,
  );

  factory drinkModel.fromJson(Map<String, dynamic> json) {
    return drinkModel(
      json['strDrink'],
      json['idDrink'],
      json["strDrinkThumb"],
      json["strCategory"],
      json["strAlcoholic"],
      json["strTags"] ?? null,
      json["strGlass"],
      json["strInstructions"],
      json["strIngredient1"] ?? '',
      json["strIngredient2"] ?? '',
      json["strIngredient3"] ?? '',
      json["strIngredient4"] ?? '',
      json["strIngredient5"] ?? '',
      json["strIngredient6"] ?? '',
      json["strIngredient7"] ?? '',
      json["strIngredient8"] ?? '',
      json["strIngredient9"] ?? '',
      json["strIngredient10"] ?? '',
    );
  }

  factory drinkModel.fromJsonList(List<dynamic> json) {
    return drinkModel(
      json[0]["strDrink"],
      json[0]["strDrinkThumb"],
      json[0]["idDrink"],
      json[0]["strCategory"],
      json[0]["strAlcoholic"],
      json[0]["strTags"],
      json[0]["strGlass"],
      json[0]["strInstructions"],
      json[0]["strIngredient1"] ?? '',
      json[0]["strIngredient2"] ?? '',
      json[0]["strIngredient3"] ?? '',
      json[0]["strIngredient4"] ?? '',
      json[0]["strIngredient5"] ?? '',
      json[0]["strIngredient6"] ?? '',
      json[0]["strIngredient7"] ?? '',
      json[0]["strIngredient8"] ?? '',
      json[0]["strIngredient9"] ?? '',
      json[0]["strIngredient10"] ?? '',
    );
  }
}
