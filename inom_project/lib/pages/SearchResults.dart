import 'package:flutter/material.dart';
import 'package:inom_project/models/Cocktail.dart';
import 'package:inom_project/pages/DrinkDetails.dart';

// ignore: must_be_immutable
class SearchResults extends StatelessWidget {
  final List<Cocktail> results;
  String searchValue;
  bool gotResponses;

  SearchResults({
    super.key,
    required this.results,
    required this.searchValue,
    required this.gotResponses,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF450920),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFFff9b54), // Set the color for the back button
        ),
        title: Text(
          'Search Results for "$searchValue"',
          style: const TextStyle(
            color: Color(0xFFff9b54),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF4f000b),
      ),
      body: results.isEmpty || !gotResponses
          ? const Center(
              child: Text(
                'No results found',
                style: TextStyle(
                  color: Color(0xFFf9dbbd),
                  fontSize: 16,
                ),
              ),
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
                builder: (context) => DrinkDetails(
                    id: results[index].drinkID,
                    drinkName: results[index].drinkName),
              ),
            );
          },
          child: Container(
            height: 115,
            color: const Color(0xFF720026),
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
                          color: Color(0xFFf9dbbd),
                        ),
                      ),
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
}
