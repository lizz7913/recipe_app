import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/comments.dart';
import 'models/recipe.dart';

class IngredientScreen extends StatelessWidget {
  final String id;
  IngredientScreen({@required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection('Recipe').doc(id).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var food = Recipe.fromJson(snapshot.data.data());
          return ListView(
            children: [
              Container(
                height: 700,
                child: Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Image(image: NetworkImage(food.image)),
                        const SizedBox(
                          height: 14.0,
                        ),
                        Text(
                          food.name,
                          style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Palatino'),
                        ),
                        Text(
                          food.ingredients,
                          style: const TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Palatino'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('comments')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  return ListView(
                      shrinkWrap: true,
                    children: snapshot.data.docs.map((document) {
                      var food = Comments.fromJson(document.data());
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text('Comments:',
                              style: TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(width: 10,),
                              TextButton(onPressed: (){}, child: Text('Add Comment'))
                            ],
                          ),
                          Row(
                            children: [
                              Text(food.user.toString()),
                              Text(':'),
                              Text(food.comment.toString())
                            ],
                          ),

                        ],
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
