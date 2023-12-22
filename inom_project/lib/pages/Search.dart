import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:inom_project/models/PopSection.dart';
import 'package:inom_project/models/Post.dart';
import 'package:inom_project/models/Recommendation.dart';
import 'package:inom_project/models/filterSearchModel.dart';
import 'package:inom_project/pages/SearchResults.dart';
import 'package:inom_project/pages/Settings.dart';
import 'package:inom_project/pages/countryDetails.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<ReccomendsModel> reccomendations = [];
  List<PopModel> popVisits = [];

  List<Post> posts = [];
  String searchBy = 'name';
  bool isLoading = true;
  bool isSearching = false;
  bool gotResponses = true;

  void getInitialInfo() {
    reccomendations = ReccomendsModel.getDiets();
    popVisits = PopModel.getPopularVisits();
  }

  @override
  Widget build(BuildContext context) {
    getInitialInfo();
    return Scaffold(
      backgroundColor: const Color(0xfffbfefe),
      appBar: AppBar(
        leading: const Icon(Icons.search),
        title: const Text(
          "Search",
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
              Navigator.pushNamed(context, Settings.routeName);
            },
          )
        ],
      ),
      body: ListView(
        children: [
          searchField(),
          const SizedBox(height: 40),
          recommendedSection(),
          const SizedBox(height: 40),
          popularSection(),
        ],
      ),
    );
  }

  Column popularSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Popular',
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
            itemCount: popVisits.length,
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
                        builder: (context) =>
                            countryDetails(id: popVisits[index].name),
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
                      Image.asset(
                        popVisits[index].iconPath,
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
                              popVisits[index].name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF0F2D40),
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${popVisits[index].popularPlace} | ${popVisits[index].act1} | ${popVisits[index].act2}',
                              style: const TextStyle(
                                color: Color(0xFF296B73),
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
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

  Column recommendedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Recommended Places\nto Visit',
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
                    color: reccomendations[index].boxColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        reccomendations[index].iconPath,
                        width: 200,
                        height: 100,
                      ),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reccomendations[index].name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0F2D40),
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${reccomendations[index].popularPlace} | ${reccomendations[index].act1} | ${reccomendations[index].act2}',
                            style: const TextStyle(
                                color: Color(0xFF296B73),
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => countryDetails(
                                    id: reccomendations[index].name),
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
            itemCount: reccomendations.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 20),
          ),
        )
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
            posts.clear;
            await updateList(value);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchResults(
                  posts: posts,
                  searchValue: value,
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
                'name',
                'currency',
                'language',
                'capital',
                'region',
                'subregion'
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
    String baseUrl = 'https://restcountries.com/v3.1/';
    String endpoint = '';
    // Determine the endpoint based on the value of searchBy
    switch (searchBy) {
      case 'name':
        endpoint = 'name/$searchValue';
        break;
      case 'currency':
        endpoint = 'currency/$searchValue';
        break;
      case 'language':
        endpoint = 'lang/$searchValue';
        break;
      case 'capital':
        endpoint = 'capital/$searchValue';
        break;
      case 'region':
        endpoint = 'region/$searchValue';
        break;
      case 'subregion':
        endpoint = 'subregion/$searchValue';
        break;
    }

    Response response = await http.get(Uri.parse('$baseUrl$endpoint'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<Post> parsedPosts =
          jsonList.map((e) => Post.fromJsonList(e)).toList();
      setState(() {
        posts = parsedPosts;
        isLoading = false;
        isSearching = true;
        gotResponses = true;
      });
    } else {
      setState(() {
        posts = [];
        gotResponses = false;
      });
    }
  }
}
