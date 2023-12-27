import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:inom_project/models/DrinkDetailsModel.dart';

class drinkDetails extends StatelessWidget {
  final String id;
  const drinkDetails({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFEFE),
      appBar: AppBar(
        title: const Text("Details"),
        backgroundColor: const Color(0xFF3E8C84),
      ),
      body: FutureBuilder(
          future: callApi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Text("Some error occurred");
            } else {
              final data = snapshot.data;
              return detailsContainer(data);
            }
          }),
    );
  }

  Container detailsContainer(data) {
    return Container(
      alignment: Alignment.topCenter,
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft, // Start from the top-left corner
            end: Alignment.bottomRight, // End at the bottom-right corner,
            colors: [
              Color(0xFFD8F2F0),
              Color(0xFFB8ECD7),
            ],
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50, // Adjust the height to your preference
            ),
            Image.network(
              data[0].drinkpicture,
              width: 250,
              height: 200,
            ),
            Text(
              data[0].drinkName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F2D40),
              ),
            ),
            const SizedBox(
              height: 30, // Adjust the height to your preference
            ),
            Container(
              width: 1200,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Category:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 56,
                            ),
                            Expanded(
                                child: Text(
                              data[0].category,
                              textAlign: TextAlign.left,
                            )),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Type of Drink:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                                child: Text(
                              data[0].alcoholic,
                              textAlign: TextAlign.left,
                            )),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Tags:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(
                              width: 89,
                            ),
                            Expanded(
                              child: Text(
                                data[0].tags ?? "None",
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Glass:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(
                              width: 86,
                            ),
                            Text(
                              data[0].glass,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Ingredients:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(
                              width: 43,
                            ),
                            Expanded(
                              child: buildIngredientsText(data[0]),
                            ),
                          ],
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Instructions:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 39,
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                data[0].instructions,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIngredientsText(drinkModel data) {
    List<String?> ingredients = [
      data.ingredient1,
      data.ingredient2,
      data.ingredient3,
      data.ingredient4,
      data.ingredient5,
      data.ingredient6,
      data.ingredient7,
      data.ingredient8,
      data.ingredient9,
      data.ingredient10,
    ];

    String result = '';

    for (int i = 0; i < ingredients.length; i++) {
      if (ingredients[i] != null && ingredients[i]!.isNotEmpty) {
        if (result.isNotEmpty) {
          result += ', ';
        }
        result += ingredients[i]!;
      } else {
        // If ingredient is null or empty, break the loop
        break;
      }
    }

    return Text(
      result,
      textAlign: TextAlign.left,
    );
  }

  Future callApi() async {
    Response response = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$id'));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      List<dynamic> jsonList = responseMap['drinks'];
      List<drinkModel> newDisplay =
          jsonList.map((e) => drinkModel.fromJson(e)).toList();

      return newDisplay;
    } else {
      throw Exception("Failed to Load Data");
    }
  }
}
