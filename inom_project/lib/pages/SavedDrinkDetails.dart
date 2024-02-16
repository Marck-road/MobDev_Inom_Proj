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
                        color: Color(0xFF4f000b),
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/icons/trash.svg',
                      // ignore: deprecated_member_use
                      color: const Color(0xFF4f000b),
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Image.network(
              data.pictureUrl,
              width: 250,
              height: 200,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              data.drinkName,
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
                  switchToEditMode();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Edit Details ',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFFf9dbbd),
                      ),
                    ),
                    Icon(
                      Icons.edit,
                      size: 18,
                      color: Color(0xFFf9dbbd),
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
                              data.category,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Color(0xFFf9dbbd),
                              ),
                            )),
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
                              data.type,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Color(0xFFf9dbbd),
                              ),
                            )),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Tags:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFf9dbbd),
                                )),
                            const SizedBox(
                              width: 90,
                            ),
                            Expanded(
                              child: Text(
                                data.tags ?? "None",
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
                            const Text('Glass:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFf9dbbd),
                                )),
                            const SizedBox(
                              width: 85,
                            ),
                            Expanded(
                              child: Text(
                                data.glass,
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
                            const Text('Ingredients:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFf9dbbd),
                                )),
                            const SizedBox(
                              width: 41,
                            ),
                            Expanded(
                              child: Text(
                                data.ingredients,
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
                                    data.instructions,
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
                    height: 30,
                  ),
                  Image.network(
                    data.pictureUrl,
                    width: 250,
                    height: 200,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      controller: drinkNameController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Color(0xFFf9dbbd)),
                      decoration: const InputDecoration(
                        labelText: "Drink Name",
                        labelStyle: TextStyle(color: Color(0xFFf9dbbd)),
                        hintStyle: TextStyle(color: Color(0xFFf9dbbd)),
                        fillColor: Color(0xFFf9dbbd),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          borderSide: BorderSide(
                            color: Color(0xFFf9dbbd),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          borderSide: BorderSide(
                            color: Color(0xFFf9dbbd),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
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
                                      style: const TextStyle(
                                        color: Color(0xFFf9dbbd),
                                      ),
                                      controller: categoryController,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Color(0xFFf9dbbd)),
                                        hintStyle:
                                            TextStyle(color: Color(0xFFf9dbbd)),
                                        fillColor: Color(0xFFf9dbbd),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0xFFf9dbbd),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0xFFf9dbbd),
                                          ),
                                        ),
                                        labelText: "Category",
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 10.0,
                                          horizontal: 20.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: TextFormField(
                                      style: const TextStyle(
                                        color: Color(0xFFf9dbbd),
                                      ),
                                      controller: typeController,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        labelText: "Type",
                                        labelStyle:
                                            TextStyle(color: Color(0xFFf9dbbd)),
                                        hintStyle:
                                            TextStyle(color: Color(0xFFf9dbbd)),
                                        fillColor: Color(0xFFf9dbbd),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0xFFf9dbbd),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0xFFf9dbbd),
                                          ),
                                        ),
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 10.0,
                                          horizontal: 20.0,
                                        ),
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
                                      style: const TextStyle(
                                        color: Color(0xFFf9dbbd),
                                      ),
                                      controller: tagsController,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        labelText: "Tags",
                                        labelStyle:
                                            TextStyle(color: Color(0xFFf9dbbd)),
                                        hintStyle:
                                            TextStyle(color: Color(0xFFf9dbbd)),
                                        fillColor: Color(0xFFf9dbbd),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0xFFf9dbbd),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0xFFf9dbbd),
                                          ),
                                        ),
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 10.0,
                                          horizontal: 20.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: TextFormField(
                                      style: const TextStyle(
                                        color: Color(0xFFf9dbbd),
                                      ),
                                      controller: glassController,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        labelText: "Glass",
                                        labelStyle:
                                            TextStyle(color: Color(0xFFf9dbbd)),
                                        hintStyle:
                                            TextStyle(color: Color(0xFFf9dbbd)),
                                        fillColor: Color(0xFFf9dbbd),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0xFFf9dbbd),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0xFFf9dbbd),
                                          ),
                                        ),
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 10.0,
                                          horizontal: 20.0,
                                        ),
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
                                      style: const TextStyle(
                                        color: Color(0xFFf9dbbd),
                                      ),
                                      controller: ingredientsController,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        labelText: "Ingredients",
                                        labelStyle:
                                            TextStyle(color: Color(0xFFf9dbbd)),
                                        hintStyle:
                                            TextStyle(color: Color(0xFFf9dbbd)),
                                        fillColor: Color(0xFFf9dbbd),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0xFFf9dbbd),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0xFFf9dbbd),
                                          ),
                                        ),
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 10.0,
                                          horizontal: 20.0,
                                        ),
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
                                      style: const TextStyle(
                                        color: Color(0xFFf9dbbd),
                                      ),
                                      controller: instructionsController,
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        labelText: "Instructions",
                                        labelStyle:
                                            TextStyle(color: Color(0xFFf9dbbd)),
                                        hintStyle:
                                            TextStyle(color: Color(0xFFf9dbbd)),
                                        fillColor: Color(0xFFf9dbbd),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0xFFf9dbbd),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0xFFf9dbbd),
                                          ),
                                        ),
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 40.0,
                                          horizontal: 20.0,
                                        ),
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
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Cancel',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFFf9dbbd),
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
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Save',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFFf9dbbd),
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Some error occured!'),
            duration: Duration(seconds: 3),
          ),
        );

        print('Document does not exist');
        return null;
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Some error occured!'),
          duration: Duration(seconds: 3),
        ),
      );
      print('Error fetching document: $error');
      return null;
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Drink successfully removed! Please reload page'),
              duration: Duration(seconds: 3), // You can customize the duration
            ),
          );
          Navigator.pop(context);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Some error occured!'),
              duration: Duration(seconds: 3),
            ),
          );
          print('Error removing drink');
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Drink removed successfully! Please reload page'),
            duration: Duration(seconds: 3),
          ),
        );
        print('Drink removed successfully!');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Some error occured!'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Some error occured!'),
          duration: Duration(seconds: 3),
        ),
      );
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

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Drink data updated successfully!'),
            duration: Duration(seconds: 3), // You can customize the duration
          ),
        );

        print('Drink data updated successfully!');
      } else {
        print('Error updating drink data.');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Some error occured!'),
          duration: Duration(seconds: 3),
        ),
      );
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
