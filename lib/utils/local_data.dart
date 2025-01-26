import 'package:ecommerce/const/string.dart';

final List<Category> categoriesList = [
  Category(name: "Electronics", image: Images.device),
  Category(name: "Jewelery", image: Images.jewel),
  Category(name: "Men's clothing", image: Images.menCloth),
  Category(name: "Women's clothing", image: Images.women),
];

class Category {
  String name;
  String image;

  Category({required this.name, required this.image});
}
