import 'dart:convert';

import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:inom_project/models/Post.dart';
import 'package:inom_project/pages/Settings.dart';
import 'package:inom_project/pages/countryDetails.dart';

class Dashboard extends StatefulWidget {
  static const String routeName = "dashboard";

  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Post> posts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getList();
  }

  Future<void> fetchListData() async {
    await getList(); // This will wait for the HTTP request to complete.
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
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            color: Color(0xFFD8F2F0),
            onPressed: settings,
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
              const Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'List of All Countries:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF296B73),
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
              height: 620,
              child: dashboardContent(),
            ),
          ]),
        ),
      ],
    );
  }

  ListView dashboardContent() {
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
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
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
                      Text(posts[index].commonName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0F2D40),
                          )),
                      Text(
                        'Capital: ${posts[index].capital?.join(", ") ?? "Unknown"}',
                        style: const TextStyle(
                          color: Color(0xFF0F2D40),
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
    Navigator.pushNamed(context, Settings.routeName);
  }

  Future<void> getList() async {
    Response response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

    List<dynamic> jsonList = jsonDecode(response.body);
    List<Post> parsedPosts = jsonList.map((e) => Post.fromJsonList(e)).toList();

    setState(() {
      posts = parsedPosts;
      isLoading = false;
    });
  }
}