import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/comments.dart';
import 'models/recipe.dart';

class IngredientScreen extends StatefulWidget {
  final String id;
  final String user;
  final String recipe;

  IngredientScreen(
      {@required this.id, @required this.user, @required this.recipe});

  @override
  _IngredientScreenState createState() => _IngredientScreenState();
}

class _IngredientScreenState extends State<IngredientScreen> {
  final comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection('Recipe').doc(widget.id).get(),
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
              Row(
                children: [
                  Text(
                    'Comments:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {
                        addComment();
                      },
                      child: Text('add comment'))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Add comment', border: OutlineInputBorder()),
                  controller: comment,
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('comments')
                    .where('recipeId', isEqualTo: widget.id)
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
                          SizedBox(
                            height: 10,
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

  CollectionReference comments =
      FirebaseFirestore.instance.collection('comments');

  Future<void> addComment() {
    // Call the user's CollectionReference to add a new user
    return comments.add({
      'comments': comment.text,
      'user':  widget.user,
      'recipeId': widget.id,
      'recipe': widget.recipe,
    });
  }
}
