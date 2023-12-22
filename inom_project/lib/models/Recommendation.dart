import 'package:flutter/material.dart';

class ReccomendsModel {
  String name, iconPath, popularPlace, act1, act2;
  Color boxColor;
  bool viewIsSelected;

  ReccomendsModel(
      {required this.name,
      required this.iconPath,
      required this.popularPlace,
      required this.act1,
      required this.act2,
      required this.boxColor,
      required this.viewIsSelected});

  static List<ReccomendsModel> getDiets() {
    List<ReccomendsModel> reccomendList = [];

    reccomendList.add(
      ReccomendsModel(
        name: 'Japan',
        iconPath: 'assets/pictures/japan.jpg',
        popularPlace: 'Tokyo',
        act1: 'Culture',
        act2: 'Food',
        boxColor: const Color(0xFFD8F2F0),
        viewIsSelected: true,
      ),
    );

    reccomendList.add(
      ReccomendsModel(
        name: 'Iceland',
        iconPath: 'assets/pictures/iceland.jpg',
        popularPlace: 'Reykjavík',
        act1: 'Nature',
        act2: 'Serenity',
        boxColor: const Color(0xFFB8ECD7),
        viewIsSelected: true,
      ),
    );

    reccomendList.add(
      ReccomendsModel(
        name: 'Maldives',
        iconPath: 'assets/pictures/maldives.jpg',
        popularPlace: 'Baa Atoll',
        act1: 'Nature',
        act2: 'Serenity',
        boxColor: const Color(0xFFD8F2F0),
        viewIsSelected: true,
      ),
    );

    reccomendList.add(
      ReccomendsModel(
        name: 'New Zealand',
        iconPath: 'assets/pictures/newzealand.jpg',
        popularPlace: 'Queenstown',
        act1: 'Adventure',
        act2: 'Hiking',
        boxColor: const Color(0xFFB8ECD7),
        viewIsSelected: true,
      ),
    );

    reccomendList.add(
      ReccomendsModel(
        name: 'Sweden',
        iconPath: 'assets/pictures/sweden.jpg',
        popularPlace: 'Stockholm',
        act1: 'Culture',
        act2: 'Nature',
        boxColor: const Color(0xFFD8F2F0),
        viewIsSelected: true,
      ),
    );

    return reccomendList;
  }
}
