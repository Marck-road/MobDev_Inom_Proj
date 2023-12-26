import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:inom_project/models/glassDetailsModel.dart';

class countryDetails extends StatelessWidget {
  final String id;
  const countryDetails({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFEFE),
      appBar: AppBar(
        title: const Text("Details"),
        backgroundColor: const Color(0xFF3E8C84),
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
              print(data.commonName);
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
              height: 50, // Adjust the height to your preference
            ),
            CountryFlag.fromCountryCode(
              data.cca2,
              width: 250,
              height: 200,
            ),
            Text(
              data.commonName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F2D40),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Official Name:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Expanded(
                                child: Text(
                              data.officialName,
                              textAlign: TextAlign.left,
                            )),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Country Code:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            Expanded(
                                child: Text(
                              data.cca2,
                              textAlign: TextAlign.left,
                            )),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Capital:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(
                              width: 69,
                            ),
                            Expanded(
                              child: Text(
                                data.capital?.join(", ") ?? "Unknown",
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Region:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(
                              width: 73,
                            ),
                            Text(
                              data.region,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Subregion:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(
                              width: 48,
                            ),
                            Expanded(
                                child: Text(
                              data.subregion ?? "N/A",
                              textAlign: TextAlign.left,
                            )),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Population:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(
                              width: 44,
                            ),
                            Expanded(
                                child: Text(
                              '${data.population ?? "Unknown"}',
                              textAlign: TextAlign.left,
                            )),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Area:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(
                              width: 87,
                            ),
                            Expanded(
                                child: Text(
                              '${data.area ?? "Unknown"}',
                              textAlign: TextAlign.left,
                            )),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Languages:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(
                              width: 43,
                            ),
                            Expanded(
                                child: Text(
                              data.languages ?? "Unknown",
                              textAlign: TextAlign.left,
                            )),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Currencies:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(
                              width: 43,
                            ),
                            Expanded(
                                child: Text(
                              data.currencies ?? "Unknown",
                              textAlign: TextAlign.left,
                            )),
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

  Future callApi() async {
    Response response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/name/$id'));

    if (response.statusCode == 200) {
      glassModel newPost = glassModel.fromJson(response.body);

      return newPost;
    } else {
      throw Exception("Failed to Load Data");
    }
  }
}
