import 'package:cat_test_application/src/models/cat_model.dart';
import 'package:cat_test_application/src/repositories/cat_repository.dart';
import 'package:cat_test_application/src/ui/components/cat_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';

Widget buildHome(context) {
  return PagewiseListView(
    key: PageStorageKey('1'),
    pageSize: CatRepository.pageItemLimit,
    padding: EdgeInsets.all(8.0),
    itemBuilder: (context, CatItemModel entry, index) => buildCatListItem(context, entry),
    pageFuture: (pageIndex) => catRepository.cats(pageIndex),
  );
}