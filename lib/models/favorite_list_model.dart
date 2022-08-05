class FavoriteListModel {
  static List<String> itemNames = [
    'فندق المتحف',
    'فندق اليازجي',
    'فندق الدهشان',
    'فندق القلعة',
    'فندق الشنطي',
    'فندق الخولي',
    'مخبز العجور'
  ];
  static List<String> itemSubtitle = [
    'www.families.bakeries.com',
    'www.families.bakeries.com',
    'www.families.bakeries.com',
    'www.families.bakeries.com',
    'www.families.bakeries.com',
    'www.families.bakeries.com',
    'www.families.bakeries.com'
  ];
  static List<String> itemImge = [
    'assets/images/aila.png',
    'assets/images/yaz.png',
    'assets/images/dhshan.png',
    'assets/images/qalaa.png',
    'assets/images/shnty.png',
    'assets/images/koli.png',
    'assets/images/ajor.png',
  ];

  Item getById(int id) => Item(
        id,
        itemNames[id % itemNames.length],
        itemSubtitle[id % itemSubtitle.length],
        itemImge[id % itemImge.length],
      );

  Item getByPosition(int position) {
    return getById(position);
  }
}

class Item {
  final int id;
  final String name;
  final String subtitle;
  final String imge;

  const Item(
    this.id,
    this.name,
    this.subtitle,
    this.imge,
  );

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}
