import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inom_project/pages/AboutUs.dart';
import 'package:inom_project/pages/Dashboard.dart';
import 'package:inom_project/pages/SavedDrinks.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const String routeName = "Home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;
  final List<Widget> _pages = [
    const Dashboard(),
    const SavedDrinks(),
    const AboutUs()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFF4f000b),
          selectedItemColor: const Color(0xFFff7f51),
          unselectedItemColor: const Color(0xFFff9b54),
          currentIndex: pageIndex,
          selectedFontSize: 13,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/glass.svg',
                // ignore: deprecated_member_use
                color: const Color(0xFFff9b54),
                height: 20,
              ),
              label: "Saved Drinks",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.info),
              label: "About Us",
              activeIcon: SvgPicture.asset(
                'assets/icons/amogus.svg',
                // ignore: deprecated_member_use
                color: const Color(0xFFff9b54),
                height: 24,
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              pageIndex = index;
            });
          }),
    );
  }
}
