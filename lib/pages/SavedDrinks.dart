import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      backgroundColor: Color(0xfffbfefe),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3E8C84),
        leading: const Icon(
          Icons.home,
          color: Color(0xFFD8F2F0),
        ),
        title: const Text("Saved Drinks"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            color: Color(0xFFD8F2F0),
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
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Saved Drinks:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF296B73),
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      getUserDrinks();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Icon(
                        Icons.refresh,
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
              // color: Color(0xFF296B73),
              height: 461,
              child: dashboardContent(),
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
            color: const Color(0xFFD8F2F0),
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
                            color: Color(0xFF0F2D40),
                          )),
                    ],
                  ),
                ),
                GestureDetector(
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF0F2D40),
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
            SvgPicture.asset(
              'assets/icons/globe.svg',
              height: 140,
            ),
            const SizedBox(
              height: 5.0,
            ),
            const Text(
              'GEOEXPLORER',
              style: TextStyle(
                fontFamily: 'Pulchella',
                fontSize: 32,
                color: Color(0xFF0F2D40),
              ),
            )
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
