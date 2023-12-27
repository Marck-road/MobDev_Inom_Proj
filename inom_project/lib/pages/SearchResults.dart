import 'package:flutter/material.dart';
import 'package:inom_project/models/Cocktail.dart';
import 'package:inom_project/pages/DrinkDetails.dart';

// ignore: must_be_immutable
class SearchResults extends StatelessWidget {
  final List<Cocktail> results;
  String searchValue;

  SearchResults({super.key, required this.results, required this.searchValue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Search Results for "$searchValue"'),
        backgroundColor: const Color(0xFF3E8C84),
      ),
      body: results.isEmpty
          ? const Center(
              child: Text('No results found'),
            )
          : resultsContent(),
    );
  }

  ListView resultsContent() {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => drinkDetails(
                      id: results[index].drinkID,
                      drinkName: results[index].drinkName),
                ));
          },
          child: Container(
            height: 115,
            color: const Color(0xFFD8F2F0),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 10.0,
            ),
            child: Row(
              children: [
                Image.network(
                  results[index].drinkPic,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        results[index].drinkName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
}
