import 'package:cat_test_application/src/models/cat_model.dart';
import 'package:cat_test_application/src/repositories/favourites_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HeartButton extends StatelessWidget {

  final CatItemModel item;

  HeartButton(this.item);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: favouritesRepository.isLikedStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool liked = favouritesRepository.isLiked(snapshot.data, item.imageUrl);
            return IconButton(
              icon: liked
                ? Icon(Icons.favorite, color: Colors.red)
                : Icon(Icons.favorite_border)
                ,
              onPressed: () {
                if (!liked) {
                  favouritesRepository.addFavourite(item);
                } else {
                  favouritesRepository.removeFavourite(item);
                }
              },
            );
          } else
            return Icon(Icons.favorite_border);
        });
  }
}
