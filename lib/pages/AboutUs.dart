import 'package:flutter/material.dart';
import 'package:inom_project/pages/UserProfile.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffbfefe),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 205, 100, 9),
        leading: Icon(
          Icons.info,
          color: Color(0xfffbfefe),
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
            color: Color.fromARGB(255, 205, 100, 9),
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
              heightFactor: 0.85,
              child: Image.asset(
                'assets/pictures/drinks.png',
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
                  'About Kanpai',
                  style: TextStyle(
                    fontFamily: 'Pulchella',
                    fontSize: 38,
                    color: Color.fromARGB(255, 205, 100, 9),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  "Welcome to Kanpai, your ultimate gateway to the world of online liquor shopping. At Kanpai, we are passionate about connecting enthusiasts with the finest spirits from across the globe. With a curated selection and seamless shopping experience, we aim to elevate your libation journey. Explore our diverse range, raise your glass, and toast to memorable moments with Kanpai. Cheers!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF0F2D40),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                const Text(
                  'About the Developers',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Pulchella',
                    fontSize: 28,
                    color: Color.fromARGB(255, 205, 100, 9),
                  ),
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
                ClipOval(
                  child: Image.asset(
                    'assets/pictures/profile.jpg',
                    height: 150,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  "Victor Aguhob",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 205, 100, 9),
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
                    color: Color(0xFFCD6409),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  "At Kanpai, our mission is to be the premier destination for online liquor shopping, offering connoisseurs access to a curated selection of premium beverages, seamless shopping experiences, and expert guidance, fostering a community that celebrates craftsmanship, diversity, and the joy of shared moments.",
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
                    color: Color(0xFFCD6409),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  "Empowering enthusiasts worldwide, Kanpai envisions a world where every sip tells a story, every bottle ignites curiosity, and every celebration is elevated by exceptional spirits.",
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
