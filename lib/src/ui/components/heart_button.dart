import 'package:cat_test_application/src/models/cat_model.dart';
import 'package:flutter/material.dart';

class HeartButton extends StatefulWidget {
  final CatModel item;
  final liked;

  HeartButton(this.item, {this.liked = false});
  HeartButtonState createState() => HeartButtonState();
}

class HeartButtonState extends State<HeartButton> {
  bool liked;

  @override
  void initState() {
    liked = widget.liked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(liked ? Icons.favorite : Icons.favorite_border),
      onPressed: () {
        setState(() {
          liked = !liked;
          //TODO: call firestore
        });
      },
    );
  }
}
