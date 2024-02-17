import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inom_project/models/savedDrinkModel.dart';
import 'package:inom_project/pages/SavedDrinkDetails.dart';
import 'package:inom_project/pages/UserProfile.dart';

class SavedDrinks extends StatefulWidget {
  static const String routeName = "SavedDrinks";

  const SavedDrinks({super.key});

  @override
  State<SavedDrinks> createState() => _SavedDrinksState();
}

class _SavedDrinksState extends State<SavedDrinks> {
  List<savedDrinkModel> savedDrinks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUserDrinks();

    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF450920),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4f000b),
        leading: const Icon(
          Icons.home,
          color: Color(0xFFff9b54),
        ),
        title: const Text(
          "Saved Drinks",
          style: TextStyle(
            color: Color(0xFFff9b54),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            color: const Color(0xFFff9b54),
            onPressed: () {
              Navigator.pushNamed(context, UserProfile.routeName);
            },
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : dashboardView(),
    );
  }

  CustomScrollView dashboardView() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Logo(),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 19.0),
                    child: Text(
                      'Saved Drinks:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFff9b54),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      getUserDrinks();
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Icon(
                        Icons.refresh,
                        color: Color(0xFFff9b54),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(
              height: 461,
              child: savedDrinks.isEmpty
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        SvgPicture.asset(
                          'assets/icons/kiwi.svg',
                          // ignore: deprecated_member_use
                          color: const Color(0xFFff9b54),
                          height: 180,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Center(
                          child: Text(
                            'No saved drinks yet!',
                            style: TextStyle(
                              color: Color(0xFFff9b54),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    )
                  : dashboardContent(),
            ),
          ]),
        ),
      ],
    );
  }

  ListView dashboardContent() {
    return ListView.builder(
      itemCount: savedDrinks.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SavedDrinkDetails(
                      id: savedDrinks[index].drinkID,
                      drinkName: savedDrinks[index].drinkName),
                ));
          },
          child: Container(
            height: 115,
            color: const Color(0xFF720026),
            margin: const EdgeInsets.only(
              top: 10,
              left: 20,
              right: 20,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 10.0,
            ),
            child: Row(
              children: [
                Image.network(
                  savedDrinks[index].pictureUrl,
                  width: 70,
                  height: 80,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(savedDrinks[index].drinkName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFf9dbbd),
                          )),
                    ],
                  ),
                ),
                GestureDetector(
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFFf9dbbd),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Row Logo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Image.asset(
              'assets/pictures/altLogo.png',
              height: 210,
            ),
            const SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ],
    );
  }

  void settings() {
    Navigator.pushNamed(context, UserProfile.routeName);
  }

  Future<List<savedDrinkModel>> getUserDrinks() async {
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user!.uid;

    List<savedDrinkModel> userDrinks = [];

    // Fetch drinks from Firestore for the current user
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('Users')
        .doc(userId)
        .collection('savedDrinks')
        .get();

    userDrinks = querySnapshot.docs
        .map((document) => savedDrinkModel.fromJson(document.data()))
        .toList();

    setState(() {
      savedDrinks = userDrinks;
    });

    return userDrinks;
  }
}
