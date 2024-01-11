import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inom_project/models/savedDrinkModel.dart';

class SavedDrinkDetails extends StatefulWidget {
  final String id;
  final String drinkName;

  const SavedDrinkDetails({
    super.key,
    required this.id,
    required this.drinkName,
  });

  @override
  State<SavedDrinkDetails> createState() => _SavedDrinkDetailsState();
}

class _SavedDrinkDetailsState extends State<SavedDrinkDetails> {
  bool isdrinkSaved = false;
  bool viewMode = true;
  bool editMode = false;
  TextEditingController drinkNameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  TextEditingController glassController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Call isDrinkSaved when the widget is first created
    isDrinkSaved(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFEFE),
      appBar: AppBar(
        title: Text(widget.drinkName),
        backgroundColor: const Color(0xFF3E8C84),
      ),
      body: FutureBuilder(
          future: callDatabase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Text("Some error occurred");
            } else {
              final data = snapshot.data;
              drinkNameController.text = data.drinkName;
              categoryController.text = data.category;
              typeController.text = data.type;
              tagsController.text = data.tags;
              glassController.text = data.glass;
              ingredientsController.text = data.ingredients;
              instructionsController.text = data.instructions;

              if (viewMode && !editMode) {
                return detailsContainer(data);
              } else if (editMode && !viewMode) {
                return EditModeContainer(data);
              } else {
                return detailsContainer(data);
              }
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
            Container(
              margin: const EdgeInsets.only(
                top: 10,
              ),
              child: GestureDetector(
                onTap: () {
                  removeSavedDrink(data);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      isdrinkSaved ? 'Remove Drink ' : 'Save Drink ',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF0F2D40),
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/icons/trash.svg',
                      // ignore: deprecated_member_use
                      color: Color.fromARGB(255, 44, 65, 63),
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15, // Adjust the height to your preference
            ),
            Image.network(
              data.pictureUrl,
              width: 250,
              height: 200,
            ),
            const SizedBox(
              height: 15, // Adjust the height to your preference
            ),
            Text(
              data.drinkName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F2D40),
              ),
            ),
            const SizedBox(
              height: 10, // Adjust the height to your preference
            ),
            Container(
              height: 30,
              width: 120, // Set the desired width
              decoration: BoxDecoration(
                color: Colors.blueGrey, // Set the background color here
                borderRadius:
                    BorderRadius.circular(8), // Optional: add rounded corners
              ),
              child: GestureDetector(
                onTap: () {
                  switchToEditMode();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Edit Details ',
                      // isdrinkSaved ? 'Drink Saved' : 'Save Drink',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF0F2D40),
                      ),
                    ),
                    Icon(
                      Icons.edit,
                      size: 18,
                      color: Color(0xFF0F2D40),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10, // Adjust the height to your preference
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
                              data.category,
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
                              data.type,
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
                                data.tags ?? "None",
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
                              data.glass,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Ingredients:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            const SizedBox(
                              width: 43,
                            ),
                            Expanded(
                              child: Text(
                                data.ingredients,
                                textAlign: TextAlign.left,
                              ),
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
                                  maxHeight:
                                      175, // Adjust the maxHeight to your preference
                                ),
                                child: SingleChildScrollView(
                                  child: Text(
                                    data.instructions,
                                    textAlign: TextAlign.justify,
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

  Container EditModeContainer(data) {
    return Container(
      alignment: Alignment.topCenter,
      color: Colors.transparent,
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              margin: const EdgeInsets.all(30),
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
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
                    height: 30, // Adjust the height to your preference
                  ),
                  Image.network(
                    data.pictureUrl,
                    width: 250,
                    height: 200,
                  ),
                  const SizedBox(
                    height: 15, // Adjust the height to your preference
                  ),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      controller: drinkNameController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        labelText: "Drink Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20.0,
                        ), // Adjust the padding as needed
                      ),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: TextFormField(
                                      controller: categoryController,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        labelText: "Category",
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 10.0,
                                          horizontal: 20.0,
                                        ), // Adjust the padding as needed
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: TextFormField(
                                      controller: typeController,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        labelText: "Type",
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 10.0,
                                          horizontal: 20.0,
                                        ), // Adjust the padding as needed
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: TextFormField(
                                      controller: tagsController,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        labelText: "Tags",
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 10.0,
                                          horizontal: 20.0,
                                        ), // Adjust the padding as needed
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: TextFormField(
                                      controller: glassController,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        labelText: "Glass",
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 10.0,
                                          horizontal: 20.0,
                                        ), // Adjust the padding as needed
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 310,
                                    child: TextFormField(
                                      controller: ingredientsController,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        labelText: "Ingredients",
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 10.0,
                                          horizontal: 20.0,
                                        ), // Adjust the padding as needed
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 310,
                                    child: TextFormField(
                                      controller: instructionsController,
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        labelText: "Instructions",
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 40.0,
                                          horizontal: 20.0,
                                        ), // Adjust the padding as needed
                                      ),
                                      textAlignVertical: TextAlignVertical.top,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      switchToViewMode();
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 120, // Set the desired width
                                      decoration: BoxDecoration(
                                        color: Colors
                                            .blueGrey, // Set the background color here
                                        borderRadius: BorderRadius.circular(
                                            8), // Optional: add rounded corners
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Cancel',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors
                                                  .white, // Set the text color
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      updateDrinkData(
                                        drinkNameController.text,
                                        categoryController.text,
                                        typeController.text,
                                        tagsController.text,
                                        glassController.text,
                                        ingredientsController.text,
                                        instructionsController.text,
                                      );
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 120, // Set the desired width
                                      decoration: BoxDecoration(
                                        color: Colors
                                            .blueGrey, // Set the background color here
                                        borderRadius: BorderRadius.circular(
                                            8), // Optional: add rounded corners
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Save',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors
                                                  .white, // Set the text color
                                            ),
                                          ),
                                        ],
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
          )
        ],
      ),
    );
  }

  Future callDatabase() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String userId = user!.uid;

      savedDrinkModel Drink;

      DocumentReference<Map<String, dynamic>> documentReference =
          FirebaseFirestore.instance
              .collection('Users')
              .doc(userId)
              .collection('savedDrinks')
              .doc(widget.id);

      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await documentReference.get();

      if (documentSnapshot.exists) {
        savedDrinkModel drink =
            savedDrinkModel.fromJson(documentSnapshot.data()!);
        return drink;
      } else {
        print('Document does not exist');
        return null;
      }

      return documentSnapshot;
    } catch (error) {
      print('Error fetching document: $error');
      return null;
    }
  }

  Future<void> addSavedDrink(data) async {
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
          await savedDrinksCollection.doc(data.drinkID).set({
            'id': data.drinkID,
            'name': data.drinkName,
            'pictureUrl': data.drinkpicture,
            'category': data.category,
            'type': data.alcoholic,
            'tags': data.tags ?? "None",
            'glass': data.glass,
            'ingredients': data.ingredients,
            'instructions': data.instructions,
          });

          setState(() {
            isdrinkSaved = true;
          });
        } catch (e) {
          print('Error saving drink');
          return;
        }

        print('Drink saved successfully!');
      } else {
        print('User not logged in.');
      }
    } catch (error) {
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
          await savedDrinksCollection.doc(data.drinkID).delete();

          Navigator.pop(context);
        } catch (e) {
          print('Error removing drink');
          return;
        }

        print('Drink removed successfully!');
      } else {
        print('User not logged in.');
      }
    } catch (error) {
      print('Error removing drink: $error');
    }
  }

  Future<DocumentSnapshot<Object?>?> isDrinkSaved(String id) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        // Reference to the user's saved drinks collection
        CollectionReference savedDrinksCollection = FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .collection('savedDrinks');

        // Query to check if the specific drinkId exists in the user's saved drinks
        DocumentSnapshot<Object?> documentSnapshot =
            await savedDrinksCollection.doc(id).get();

        bool doesitExist = documentSnapshot.exists;
        setState(() {
          isdrinkSaved = doesitExist;
        });

        // Return the DocumentSnapshot for further processing
        return documentSnapshot;
      } else {
        print('User not logged in.');
        return null;
      }
    } catch (error) {
      print('Error checking if drink is saved: $error');
      return null;
    }
  }

  void updateDrinkData(
    String newDrinkName,
    String newCategory,
    String newType,
    String newTags,
    String newGlass,
    String newIngredients,
    String newInstructions,
  ) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        DocumentReference<Map<String, dynamic>> documentReference =
            FirebaseFirestore.instance
                .collection('Users')
                .doc(userId)
                .collection('savedDrinks')
                .doc(widget.id);

        await documentReference.update({
          'name': newDrinkName,
          'category': newCategory,
          'type': newType,
          'tags': newTags,
          'glass': newGlass,
          'ingredients': newIngredients,
          'instructions': newInstructions,
        });

        setState(() {
          switchToViewMode();
        });

        print('Drink data updated successfully!');
      } else {
        print('User not logged in.');
      }
    } catch (error) {
      print('Error updating drink data: $error');
    }
  }

  switchToEditMode() {
    setState(() {
      viewMode = false;
      editMode = true;
    });
  }

  switchToViewMode() {
    setState(() {
      viewMode = true;
      editMode = false;
    });
  }
}
