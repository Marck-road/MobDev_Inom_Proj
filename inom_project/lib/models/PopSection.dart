class PopModel {
  String name, iconPath, popularPlace, act1, act2;

  PopModel({
    required this.name,
    required this.iconPath,
    required this.popularPlace,
    required this.act1,
    required this.act2,
  });

  static List<PopModel> getPopularVisits() {
    List<PopModel> popVisits = [];

    popVisits.add(PopModel(
      name: 'France',
      iconPath: 'assets/pictures/france.jpg',
      popularPlace: 'Paris',
      act1: 'Culture',
      act2: 'Food',
    ));

    popVisits.add(PopModel(
      name: 'Spain',
      iconPath: 'assets/pictures/spain.jpg',
      popularPlace: 'Barcelona',
      act1: 'Culture',
      act2: 'Food',
    ));

    popVisits.add(PopModel(
      name: 'The United States',
      iconPath: 'assets/pictures/us.jpg',
      popularPlace: 'California',
      act1: 'Urbanlife',
      act2: 'Touring',
    ));

    popVisits.add(PopModel(
      name: 'China',
      iconPath: 'assets/pictures/china.jpg',
      popularPlace: 'Beijing',
      act1: 'Culture',
      act2: 'Nature',
    ));

    popVisits.add(PopModel(
      name: 'Italy',
      iconPath: 'assets/pictures/italy.jpg',
      popularPlace: 'Rome',
      act1: 'Dining',
      act2: 'Adventure',
    ));

    return popVisits;
  }
}
