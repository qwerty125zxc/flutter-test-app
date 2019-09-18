import 'package:cat_test_application/src/models/cat_model.dart';
import 'package:cat_test_application/src/repositories/cat_repository.dart';
import 'package:cat_test_application/src/repositories/favourites_repository.dart';
import 'package:cat_test_application/src/ui/components/cat_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';

Widget buildFavourites(context) {
  return PagewiseGridView.count(
    crossAxisCount: 2,
    key: PageStorageKey('2'),
    pageSize: CatRepository.pageItemLimit,
    padding: EdgeInsets.all(8.0),
    itemBuilder: (context, CatItemModel entry, index) => buildCatListItem(context, entry, fit: BoxFit.cover),
    pageFuture: (pageIndex) {
      return favouritesRepository.getFavourites(pageIndex);
    }
  );
}