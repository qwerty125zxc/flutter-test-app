import 'package:cat_test_application/src/models/cat_model.dart';
import 'package:cat_test_application/src/models/favourites_model.dart';
import 'package:cat_test_application/src/repositories/favourites_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HeartButton extends StatelessWidget {

  final CatModel item;

  HeartButton(this.item);

  @override
  Widget build(BuildContext context) {
    var favourite = Favourite(item.image.url, item.fact.text);
    return StreamBuilder<DocumentSnapshot>(
        stream: favouritesRepository.isLikedStream(favourite.url),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool liked = favouritesRepository.isLiked(snapshot.data, favourite.url);
            return IconButton(
              icon: Icon(
                liked
                ? Icons.favorite
                : Icons.favorite_border
              ),
              onPressed: () {
                if (!liked) {
                  favouritesRepository.addFavourite(favourite);
                } else {
                  favouritesRepository.removeFavourite(favourite);
                }
              },
            );
          } else
            return Icon(Icons.favorite_border);
        });
  }
}
