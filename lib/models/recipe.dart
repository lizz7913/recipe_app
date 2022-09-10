import 'package:flutter/cupertino.dart';

class Recipe {
  final String name;
  final String id;
  final String ingredients;
  final String image;

  Recipe({@required this.name,@required this.id,@required this.ingredients,@required this.image});


  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    id: json["id"],
    name: json["name"],
    ingredients: json["ingredients"],
    image: json["image"],
  );

  Map<String, dynamic> toJson()=> {
    "id": id,
    "name": name,
    "ingredients": ingredients,
    "image": image
  };

}

