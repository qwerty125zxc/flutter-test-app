import 'package:flutter/material.dart';

class ShowScreen extends StatelessWidget {
  const ShowScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Hero(
              tag: args['url'],
              child: Image.network(args['url'], fit: BoxFit.cover),
            ),
            Text(args['fact']),
          ],
        )
      )
    );
  }
}
