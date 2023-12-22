import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:inom_project/models/Post.dart';
import 'package:inom_project/pages/countryDetails.dart';

// ignore: must_be_immutable
class SearchResults extends StatelessWidget {
  final List<Post> posts;
  String searchValue;

  SearchResults({super.key, required this.posts, required this.searchValue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Search Results for "$searchValue"'),
        backgroundColor: const Color(0xFF3E8C84),
      ),
      body: posts.isEmpty
          ? const Center(
              child: Text('No results found'),
            )
          : resultsContent(),
    );
  }

  ListView resultsContent() {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      countryDetails(id: posts[index].commonName),
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
                CountryFlag.fromCountryCode(
                  posts[index].cca2,
                  width: 120,
                  height: 150,
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
                        posts[index].commonName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Capital: ${posts[index].capital?.join(", ") ?? "Unknown"}',
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
