import 'package:flutter/material.dart';
import 'package:inom_project/pages/UserProfile.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffbfefe),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3E8C84),
        leading: Icon(
          Icons.info,
          color: Color(0xFFD8F2F0),
        ),
        title: const Text(
          "About Us",
          style: TextStyle(
            color: Color(0xFFD8F2F0),
          ),
        ),
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
      body: ListView(
        children: [
          ClipRRect(
            child: Align(
              alignment: Alignment.topCenter,
              heightFactor: 0.74,
              child: Image.asset(
                'assets/pictures/mountain.jpg',
                // height: 300,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'About GeoExplorer',
                  style: TextStyle(
                    fontFamily: 'Pulchella',
                    fontSize: 38,
                    color: Color(0xFF194759),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  "Welcome to GeoExplorer, your gateway to the world's geography! We're not your typical tech 'company'; we're a of a delulu crew who believes they can even go to some of these countries in the near future. Until that day comes, we can learn and discover about these countries by admiring them from our screens! Here, we present to you a country's basic information that you could've just Googled!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF0F2D40),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                ClipOval(
                  child: Image.asset(
                    'assets/pictures/moi.jpg',
                    height: 150,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'About the Developer',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Pulchella',
                    fontSize: 28,
                    color: Color(0xFF194759),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  "Mark David M. Calzada is a '3rd-year' BS Information Technology Student enrolled in University of San Carlos. Born on November 21, 2002, he has achieved multiple great things such as finding the will to get out of bed and be able to continue existing. His life goals are to be able to explore more about the world and visit other countries, especially Japan (please lng) and just enjoy life to live without regrets. And yes, he is still single since birth so kuhaa nani siya pls.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF0F2D40),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                const Text(
                  'Mission',
                  style: TextStyle(
                    fontFamily: 'Pulchella',
                    fontSize: 28,
                    color: Color(0xFF194759),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  "Here at GeoExplorer, we bring you actual legit factual facts that came from an API so you can learn more about the country's flags, capital, and other basic information that you could've definetely just Googled! Our dedicated team of delulu geographers who wishes to explore the world works tirelessly to provide you with an app experience unlike any other.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF0F2D40),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                const Text(
                  'Vision',
                  style: TextStyle(
                    fontFamily: 'Pulchella',
                    fontSize: 28,
                    color: Color(0xFF194759),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  "Conscious of present day realities, GeoExplorer strives to provide quality and relevant information, in partnership with the world's most prestigious orgs, to produce lifelong learners, people with new wisdom, and make people find their life's purpose.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF0F2D40),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
