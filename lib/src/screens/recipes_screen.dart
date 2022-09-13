import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/models/recipe.dart';

import '../../models/comments.dart';
import 'ingredient_screen.dart';

class RecipesScreen extends StatelessWidget {
  final String userName;

  const RecipesScreen({Key key,@required this.userName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Recipe').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data.docs.map((document) {
              var food=Recipe.fromJson(document.data());
              var comment=Comments.fromJson(document.data());
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => IngredientScreen(id: food.id, user: this.userName, recipe: comment.recipe,)));
                    },
                      child:Text(food.name)),

                ],
              );
            }).toList(),
          );
        },
      ),
    );


  }
}
