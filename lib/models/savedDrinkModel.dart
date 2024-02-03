class savedDrinkModel {
  String drinkName;
  String drinkID;
  String pictureUrl;
  String category;
  String type;
  String? tags;
  String glass;
  String instructions;
  String ingredients;

  savedDrinkModel(
    this.drinkName,
    this.drinkID,
    this.pictureUrl,
    this.category,
    this.type,
    this.tags,
    this.glass,
    this.instructions,
    this.ingredients,
  );

  factory savedDrinkModel.fromJson(Map<String, dynamic> json) {
    return savedDrinkModel(
      json['name'],
      json['id'],
      json["pictureUrl"],
      json["category"],
      json["type"],
      json["tags"] ?? null,
      json["glass"],
      json["instructions"],
      json["ingredients"] ?? '',
    );
  }
}
