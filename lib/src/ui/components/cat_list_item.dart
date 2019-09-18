import 'package:cat_test_application/src/models/cat_model.dart';
import 'package:cat_test_application/src/ui/components/heart_button.dart';
import 'package:flutter/material.dart';

Widget buildCatListItem(context, CatItemModel item,
    {BoxFit fit = BoxFit.contain, double height}) {
  return InkWell(
    onTap: () {
      Navigator.of(context).pushNamed('show', arguments: item);
    },
    child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Hero(
            tag: item.imageUrl,
            child: Image.network(item.imageUrl, fit: fit),
          ),
          HeartButton(item),
        ],
      ),
    ),
  );
}
