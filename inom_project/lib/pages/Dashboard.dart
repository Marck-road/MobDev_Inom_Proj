import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:inom_project/models/Cocktail.dart';
import 'package:inom_project/models/PopSection.dart';
import 'package:inom_project/models/Recommendation.dart';
import 'package:inom_project/models/filterSearchModel.dart';
import 'package:inom_project/pages/DrinkDetails.dart';
import 'package:inom_project/pages/SearchResults.dart';
import 'package:inom_project/pages/UserProfile.dart';

class Dashboard extends StatefulWidget {
  static const String routeName = "Dashboard";
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _SearchState();
}

class _SearchState extends State<Dashboard> {
  List<ReccomendsModel> reccomendations = [];
  List<PopModel> popVisits = [];
  List<Cocktail> Alcoholic = [];
  List<Cocktail> nonAloholic = [];
  List<Cocktail> popularDrinks = [];
  List<List<Cocktail>> randomDrink = List.filled(5, []);

  List<Cocktail> drink = [];
  String searchBy = 'name';
  bool isLoading = true;
  bool isSearching = false;
  bool gotResponses = true;

  void initState() {
    super.initState();
    getNonAlcoholic_List();
    getAlcoholic_List();
    getPopular_List();
    getRandom_List(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffbfefe),
      appBar: AppBar(
        leading: const Icon(Icons.search),
        title: const Text(
          "Dashboard",
          style: TextStyle(
            color: Color(0xFFD8F2F0),
          ),
        ),
        backgroundColor: const Color(0xFF3E8C84),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            color: const Color(0xFFD8F2F0),
            onPressed: () {
              Navigator.pushNamed(context, UserProfile.routeName);
            },
          )
        ],
      ),
      body: ListView(
        children: [
          searchField(),
          const SizedBox(height: 40),
          popular_Section(),
          const SizedBox(height: 40),
          discovery_Section(),
          const SizedBox(height: 40),
          alcoholic_Section(),
          const SizedBox(height: 40),
          nonAlcoholic_Section(),
        ],
      ),
    );
  }

  Column popular_Section() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Popular Cocktails',
            style: TextStyle(
                color: Color(0xFF0F2D40),
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 240,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                  width: 230,
                  height: 230,
                  decoration: BoxDecoration(
                    color: index % 2 == 0
                        ? const Color(0xFFD8F2F0) // Every 1st box color
                        : const Color(0xFFB8ECD7), // Every 2nd box color
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(),
                      Image.network(
                        popularDrinks[index].drinkPic,
                        width: 200,
                        height: 100,
                      ),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            popularDrinks[index].drinkName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0F2D40),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => drinkDetails(
                                    id: popularDrinks[index].drinkID,
                                    drinkName: popularDrinks[index].drinkName),
                              ));
                        },
                        child: Container(
                          height: 45,
                          width: 130,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment
                                    .topLeft, // Start from the top-left corner
                                end: Alignment
                                    .bottomRight, // End at the bottom-right corner,
                                colors: [
                                  Color(0xFF97d3da),
                                  Color(0xFFb1dee3),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(50)),
                          child: const Center(
                            child: Text(
                              'View',
                              style: TextStyle(
                                color: Color(0xFF194759),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ));
            },
            separatorBuilder: (context, index) => const SizedBox(
              width: 25,
            ),
            itemCount: popularDrinks.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 20),
          ),
        )
      ],
    );
  }

  Column discovery_Section() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Discover',
                style: TextStyle(
                    color: Color(0xFF0F2D40),
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            GestureDetector(
              onTap: () {
                getRandom_List(0);
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
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 240,
          child: ListView.separated(
            itemBuilder: (context, index) {
              if (index < randomDrink.length && randomDrink[index].isNotEmpty) {
                return Container(
                    width: 230,
                    height: 230,
                    decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? const Color(0xFFD8F2F0) // Every 1st box color
                          : const Color(0xFFB8ECD7), // Every 2nd box color
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network(
                          randomDrink[index][0].drinkPic,
                          width: 200,
                          height: 100,
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              randomDrink[index][0].drinkName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF0F2D40),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => drinkDetails(
                                      id: randomDrink[index][0].drinkID,
                                      drinkName:
                                          randomDrink[index][0].drinkName),
                                ));
                          },
                          child: Container(
                            height: 45,
                            width: 130,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment
                                      .topLeft, // Start from the top-left corner
                                  end: Alignment
                                      .bottomRight, // End at the bottom-right corner,
                                  colors: [
                                    Color(0xFF97d3da),
                                    Color(0xFFb1dee3),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(50)),
                            child: const Center(
                              child: Text(
                                'View',
                                style: TextStyle(
                                  color: Color(0xFF194759),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ));
              }
              return null;
            },
            separatorBuilder: (context, index) => const SizedBox(
              width: 25,
            ),
            itemCount: randomDrink.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 20),
          ),
        )
      ],
    );
  }

  Column alcoholic_Section() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Alcoholic',
            style: TextStyle(
              color: Color(0xFF0F2D40),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 300,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 25,
            ),
            itemCount: Alcoholic.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => drinkDetails(
                          id: Alcoholic[index].drinkID,
                          drinkName: Alcoholic[index].drinkName,
                        ),
                      ));
                },
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: const Color(0xFFD8F2F0),
                      // gradient: LinearGradient(
                      //   colors: [Color(0xFF296B73), Color(0xFFB8ECD7)],
                      // ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff101617).withOpacity(0.07),
                          offset: const Offset(0, 10),
                          blurRadius: 40,
                          spreadRadius: 0,
                        )
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Image.network(
                        Alcoholic[index].drinkPic,
                        width: 120,
                        height: 150,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Alcoholic[index].drinkName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF0F2D40),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Color(0xFF0F2D40),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Column nonAlcoholic_Section() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Non-Alcoholic',
            style: TextStyle(
              color: Color(0xFF0F2D40),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 300,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 25,
            ),
            itemCount: nonAloholic.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => drinkDetails(
                            id: nonAloholic[index].drinkID,
                            drinkName: nonAloholic[index].drinkName),
                      ));
                },
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: const Color(0xFFD8F2F0),
                      // gradient: LinearGradient(

                      //   colors: [Color(0xFF296B73), Color(0xFFB8ECD7)],
                      // ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff101617).withOpacity(0.07),
                          offset: const Offset(0, 10),
                          blurRadius: 40,
                          spreadRadius: 0,
                        )
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Image.network(
                        nonAloholic[index].drinkPic,
                        width: 120,
                        height: 150,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nonAloholic[index].drinkName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF0F2D40),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Color(0xFF0F2D40),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Container searchField() {
    TextEditingController textEditingController = TextEditingController();

    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0)
      ]),
      child: TextField(
        controller: textEditingController,
        onSubmitted: (value) async {
          if (value.isNotEmpty) {
            drink.clear;
            await updateList(value);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchResults(
                  results: drink,
                  searchValue: value,
                  gotResponses: gotResponses,
                ),
              ),
            );
          } else {
            revertToOrig();
          }
        },
        decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFD8F2F0),
            contentPadding: const EdgeInsets.all(15),
            hintText: 'Search by $searchBy',
            hintStyle: const TextStyle(
              color: Color(0xFF0F2D40),
              fontSize: 14,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: Color(0xFF0F2D40),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                filterSearchby(context);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                width: 100,
                child: const IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      VerticalDivider(
                          color: Color(0xFF194759),
                          thickness: 0.1,
                          indent: 10,
                          endIndent: 10),
                      Icon(
                        Icons.tune,
                        color: Color(0xFF0F2D40),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none)),
      ),
    );
  }

  void _handleOptionChange(String value) {
    setState(() {
      searchBy = value;
    });
  }

  void filterSearchby(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a choice'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (var option in [
                'Name',
                'Ingredient',
              ])
                FilterSearchModel(
                  text: option,
                  isSelected: option == searchBy,
                  onChanged: _handleOptionChange,
                ),
            ],
          ),
        );
      },
    );
  }

  void revertToOrig() {
    setState(() {
      isSearching = false;
    });
  }

  Future<void> updateList(String searchValue) async {
    String baseUrl = 'https://www.thecocktaildb.com/api/json/v1/1/';
    String endpoint = '';
    // Determine the endpoint based on the value of searchBy
    switch (searchBy) {
      case 'Name':
        endpoint = 'search.php?s=$searchValue';
        break;
      case 'Ingredient':
        endpoint = 'filter.php?i=$searchValue';
        break;
    }

    Response response = await http.get(Uri.parse('$baseUrl$endpoint'));
    if (response.statusCode == 200) {
      try {
        if (response.body.isNotEmpty) {
          Map<String, dynamic> responseMap = jsonDecode(response.body);
          if (responseMap['drinks'] != null) {
            List<dynamic> jsonList = responseMap['drinks'];
            List<Cocktail> parsedResults =
                jsonList.map((e) => Cocktail.fromJson(e)).toList();
            setState(() {
              drink = parsedResults;
              isLoading = false;
              isSearching = true;
              gotResponses = true;
            });
          } else {
            handleNoResults();
          }
        } else {
          handleNoResults();
        }
      } catch (e) {
        // Handle JSON decoding error
        print('Error decoding JSON: $e');
        handleNoResults();
      }
    } else {
      handleNoResults();
    }
  }

  void handleNoResults() {
    setState(() {
      drink = [];
      gotResponses = false;
    });
  }

  Future<void> getAlcoholic_List() async {
    Response response = await http.get(
      Uri.parse(
          'https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic'),
    );

    Map<String, dynamic> responseMap = jsonDecode(response.body);
    List<dynamic> jsonList = responseMap['drinks'];
    List<Cocktail> parsedAlcohol =
        jsonList.map((e) => Cocktail.fromJson(e)).toList();

    setState(() {
      Alcoholic = parsedAlcohol;
      isLoading = false;
    });
  }

  Future<void> getNonAlcoholic_List() async {
    Response response = await http.get(
      Uri.parse(
          'https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic'),
    );

    Map<String, dynamic> responseMap = jsonDecode(response.body);
    List<dynamic> jsonList = responseMap['drinks'];
    List<Cocktail> parsedNonAlcohol =
        jsonList.map((e) => Cocktail.fromJson(e)).toList();

    setState(() {
      nonAloholic = parsedNonAlcohol;
      isLoading = false;
    });
  }

  Future<void> getRandom_List(int x) async {
    if (!mounted) return;

    Response response = await http.get(
      Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/random.php'),
    );

    Map<String, dynamic> responseMap = jsonDecode(response.body);
    List<dynamic> jsonList = responseMap['drinks'];
    List<Cocktail> parsedRandom =
        jsonList.map((e) => Cocktail.fromJson(e)).toList();

    if (x < 5) {
      if (!mounted) return;
      setState(() {
        if (randomDrink.length > x && parsedRandom.isNotEmpty) {
          randomDrink[x] = parsedRandom;
          isLoading = false;
        }
      });

      await getRandom_List(x + 1);
    }
  }

  Future<void> getPopular_List() async {
    try {
      // Load the JSON file from the assets directory
      String jsonString =
          await rootBundle.loadString('assets/recommended.json');

      // Parse the JSON data
      Map<String, dynamic> parsedJson = jsonDecode(jsonString);

      // Extract the drinks list
      List<dynamic> jsonList = parsedJson['drinks'];

      // Convert the JSON list to Cocktail objects
      List<Cocktail> parsedPopularDrinks =
          jsonList.map((e) => Cocktail.fromJson(e)).toList();

      setState(() {
        popularDrinks = parsedPopularDrinks;
        isLoading = false;
      });
    } catch (error) {
      // Handle errors gracefully
      print("Error loading JSON data: $error");
      // Display an error message to the user, or implement other error handling strategies
    }
  }
}
