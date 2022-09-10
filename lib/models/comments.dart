import 'package:flutter/cupertino.dart';

class Comments {
  final String user;
  final String recipe;
  final String comment;

  Comments({@required this.user, @required this.recipe, @required this.comment});


  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
    user: json["user"],
    recipe: json["recipeId"],
    comment: json["comment"]

  );

  Map<String, dynamic> toJson()=> {
    "User1": user,
    "recipeId": recipe,
    "comment": comment
  };

}

