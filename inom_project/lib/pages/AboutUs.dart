import 'package:flutter/material.dart';
import 'package:inom_project/pages/UserProfile.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF450920),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4f000b),
        leading: const Icon(
          Icons.info,
          color: Color(0xFFff9b54),
        ),
        title: const Text(
          "About Us",
          style: TextStyle(
            color: Color(0xFFff9b54),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            color: const Color(0xFFff9b54),
            onPressed: () {
              Navigator.pushNamed(context, UserProfile.routeName);
            },
          )
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          ClipRRect(
            child: Align(
              alignment: Alignment.topCenter,
              heightFactor: 0.85,
              child: Image.asset(
                'assets/pictures/kanpaiLogo.png',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
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
                    color: Color(0xFFff9b54),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  "Welcome to Kanpai, your ultimate gateway to the world of liquor. At Kanpai, we are passionate about connecting enthusiasts with the finest spirits from across the globe. Everything you need to become a liquor connisuer are all here! With a curated selection and seamless browsing  experience, we aim to elevate your libation journey. Explore our diverse range, create new drinks, raise your glass, and toast to memorable moments with Kanpai. Cheers!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFf9dbbd),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'About the Developers',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Pulchella',
                    fontSize: 28,
                    color: Color(0xFFff9b54),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
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
                  "Mark Calzada",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFff9b54),
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  "Mark Calzada is a 3rd-year BS Information Technology Student enrolled in University of San Carlos. Born on November 21, 2002, he is capable of multiple things such as getting out of bed, web development, system designing, and exploring the unknown. Mark will complete any task given to him to the best of his capabilities, and is not afraid to try and handle something new. His main motto is to live life without regrets and enjoy everything to the fullest, as you only live once. And yes, he is still single.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFf9dbbd),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
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
                const Text(
                  "Victor Aguhob",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFff9b54),
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  "Victor Aguhob, a fourth-year student, passionately showcases his talent in promoting online liquor sales. With a keen eye for market trends and a flair for digital marketing, Victor navigates the dynamic landscape of e-commerce with finesse. Through strategic campaigns and innovative approaches, he champions the art of online liquor retailing, fostering connections and driving sales in the ever-evolving digital marketplace.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFf9dbbd),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Mission',
                  style: TextStyle(
                    fontFamily: 'Pulchella',
                    fontSize: 28,
                    color: Color(0xFFff9b54),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  "At Kanpai, our mission is to be the premier destination for liquor information, offering connoisseurs access to a curated selection of premium beverages, seamless browsing experiences, and expert guidance, fostering a community that celebrates craftsmanship, diversity, and the joy of shared moments.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFf9dbbd),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Vision',
                  style: TextStyle(
                    fontFamily: 'Pulchella',
                    fontSize: 28,
                    color: Color(0xFFff9b54),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  "Empowering enthusiasts worldwide, Kanpai envisions a world where every sip tells a story, every bottle ignites curiosity, and every celebration is elevated by exceptional spirits.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFf9dbbd),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Support the Creators',
                  style: TextStyle(
                    fontFamily: 'Pulchella',
                    fontSize: 28,
                    color: Color(0xFFff9b54),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/pictures/GcashLogo.jpg',
                  height: 50,
                ),
                Image.asset(
                  'assets/pictures/Gcash.jpg',
                  height: 200,
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
