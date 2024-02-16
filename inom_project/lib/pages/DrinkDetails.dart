import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:inom_project/models/DrinkDetailsModel.dart';

class DrinkDetails extends StatefulWidget {
  final String id;
  final String drinkName;

  const DrinkDetails({
    super.key,
    required this.id,
    required this.drinkName,
  });

  @override
  State<DrinkDetails> createState() => _DrinkDetailsState();
}

class _DrinkDetailsState extends State<DrinkDetails> {
  bool isdrinkSaved = false;
  @override
  void initState() {
    super.initState();
    isDrinkSaved(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF450920),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFFff9b54),
        ),
        title: Text(
          widget.drinkName,
          style: const TextStyle(
            color: Color(0xFFff9b54),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF4f000b),
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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFff9b54),
              Color(0xFF89043d),
            ],
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
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
                color: Color(0xFFf9dbbd),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 30,
              width: 120,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFce4257),
                    Color(0xFFa53860),
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: GestureDetector(
                onTap: () {
                  if (isdrinkSaved) {
                    // Drink is already saved, perform removal
                    removeSavedDrink(data);
                  } else {
                    // Drink is not saved, perform addition
                    addSavedDrink(data);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isdrinkSaved ? 'Drink Saved' : 'Save Drink',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFf9dbbd),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
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
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFf9dbbd),
                              ),
                            ),
                            const SizedBox(
                              width: 56,
                            ),
                            Expanded(
                              child: Text(
                                data[0].category,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Color(0xFFf9dbbd),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Type of Drink:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFf9dbbd),
                              ),
                            ),
                            const SizedBox(
                              width: 29,
                            ),
                            Expanded(
                              child: Text(
                                data[0].alcoholic,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Color(0xFFf9dbbd),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tags:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFf9dbbd),
                              ),
                            ),
                            const SizedBox(
                              width: 90,
                            ),
                            Expanded(
                              child: Text(
                                data[0].tags ?? "None",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Color(0xFFf9dbbd),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Glass:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFf9dbbd),
                              ),
                            ),
                            const SizedBox(
                              width: 85,
                            ),
                            Expanded(
                              child: Text(
                                data[0].glass,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Color(0xFFf9dbbd),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Ingredients:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFf9dbbd),
                              ),
                            ),
                            const SizedBox(
                              width: 41,
                            ),
                            Expanded(
                              child: Text(
                                buildIngredientsText(data[0]),
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Color(0xFFf9dbbd),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Instructions:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFf9dbbd),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                constraints: const BoxConstraints(
                                  maxHeight: 180,
                                ),
                                child: SingleChildScrollView(
                                  child: Text(
                                    data[0].instructions,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      color: Color(0xFFf9dbbd),
                                    ),
                                  ),
                                ),
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

  String buildIngredientsText(drinkModel data) {
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

    return result;
  }

  Future callApi() async {
    Response response = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=${widget.id}'));

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

  Future<void> addSavedDrink(data) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        CollectionReference savedDrinksCollection = FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .collection('savedDrinks');

        try {
          await savedDrinksCollection.doc(data[0].drinkID).set({
            'id': data[0].drinkID,
            'name': data[0].drinkName,
            'pictureUrl': data[0].drinkpicture,
            'category': data[0].category,
            'type': data[0].alcoholic,
            'tags': data[0].tags ?? "None",
            'glass': data[0].glass,
            'ingredients': buildIngredientsText(data[0]),
            'instructions': data[0].instructions,
          });

          setState(() {
            isdrinkSaved = true;
          });
        } catch (e) {
          print('Error saving drink');
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Drink saved successfully!'),
            duration: Duration(seconds: 3),
          ),
        );
        print('Drink saved successfully!');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error saving drink!'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error saving drink!'),
          duration: Duration(seconds: 3),
        ),
      );
      print('Error saving drink: $error');
    }
  }

  Future<void> removeSavedDrink(data) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        // Reference to the user's saved drinks collection
        CollectionReference savedDrinksCollection = FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .collection('savedDrinks');

        // Add the drink data to the collection
        try {
          await savedDrinksCollection.doc(data[0].drinkID).delete();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Drink removed successfully!'),
              duration: Duration(seconds: 3), // You can customize the duration
            ),
          );

          setState(() {
            isdrinkSaved = false;
          });
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error removing drink!'),
              duration: Duration(seconds: 3),
            ),
          );
          return;
        }

        print('Drink removed successfully!');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error removing drink!'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error removing drink!'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<DocumentSnapshot<Object?>?> isDrinkSaved(String id) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        CollectionReference savedDrinksCollection = FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .collection('savedDrinks');

        DocumentSnapshot<Object?> documentSnapshot =
            await savedDrinksCollection.doc(id).get();

        bool doesitExist = documentSnapshot.exists;
        setState(() {
          isdrinkSaved = doesitExist;
        });

        return documentSnapshot;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Some error occured!'),
            duration: Duration(seconds: 3),
          ),
        );
        return null;
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Some error occured!'),
          duration: Duration(seconds: 3),
        ),
      );
      return null;
    }
  }
}
