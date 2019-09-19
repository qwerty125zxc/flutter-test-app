import 'package:cat_test_application/src/models/cat_model.dart';
import 'package:cat_test_application/src/repositories/cat_repository.dart';
import 'package:cat_test_application/src/repositories/favourites_repository.dart';
import 'package:cat_test_application/src/ui/components/cat_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';

Widget buildFavourites(context) {
  return FutureBuilder<List<CatItemModel>>(
    future: favouritesRepository.getFavourites(),
    builder: (context, snapshot) {
      return snapshot.hasData ?
      ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return buildCatListItem(context, snapshot.data[index]);
        },
      )
      : CircularProgressIndicator();
    },
  );
}