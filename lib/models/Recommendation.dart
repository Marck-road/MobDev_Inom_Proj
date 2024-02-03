import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:inom_project/models/Cocktail.dart';

class ReccomendsModel {
  Cocktail drinkInfo;
  Color boxColor;

  ReccomendsModel({
    required this.boxColor,
    required this.drinkInfo,
  });

  static Future<List<ReccomendsModel>> getRecommended() async {
    List<ReccomendsModel> reccomendList = [];
    List<String> drinkNames = [
      "12754",
      "12362",
      "11007",
      "11006",
      "17207",
      "17196",
      "17204",
      "11410",
      "11113",
      "12214",
      "11690",
      "11000",
      "11202",
    ];

    for (int i = 0; i < drinkNames.length; i++) {
      Cocktail drinkInfo = await getDrinkInfo(drinkNames[i]);

      Color boxColor = i % 2 == 0
          ? const Color(0xFFD8F2F0) // Every 1st box color
          : const Color(0xFFB8ECD7); // Every 2nd box color

      reccomendList.add(
        ReccomendsModel(
          drinkInfo: drinkInfo,
          boxColor: boxColor,
        ),
      );
    }

    return reccomendList;
  }

  static Future<Cocktail> getDrinkInfo(String cocktailName) async {
    String drinkUrl =
        'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$cocktailName';

    Response response = await http.get(Uri.parse('$drinkUrl'));

    Map<String, dynamic> responseMap = jsonDecode(response.body);
    List<dynamic> jsonList = responseMap['drinks'];
    List<Cocktail> parsedPosts =
        jsonList.map((e) => Cocktail.fromJson(e)).toList();

    return parsedPosts[0];
  }
}
