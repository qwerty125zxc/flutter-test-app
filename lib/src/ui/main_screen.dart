import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_test_application/src/models/cat_model.dart';
import 'package:cat_test_application/src/repositories/cat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';

class MainScreen extends StatefulWidget {

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {

    final tabPages = <Widget>[
      _buildHome(context),
      _buildFavourites(context),
      _buildAccount(context)
    ];

    final bottmonNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
      BottomNavigationBarItem(icon: Icon(Icons.favorite), title: Text('Favourites')),
      BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('Account')),
    ];
    
    final bottomNavBar = BottomNavigationBar(
      items: bottmonNavBarItems,
      currentIndex: currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          currentTabIndex = index;
        });
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Test Application'),
        centerTitle: true,
      ),
      body: tabPages[currentTabIndex],
      bottomNavigationBar: bottomNavBar,
    );
  }

  Widget _buildHome(context) {
    return PagewiseListView(
      pageSize: CatRepository.pageItemLimit,
      padding: EdgeInsets.all(8.0),
      itemBuilder: (context, CatModel entry, index) => _buildItem(context, entry),
      pageFuture: (pageIndex) => catRepository.cats(pageIndex),
    );
  }

  Widget _buildItem(context, CatModel item) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('show', arguments: {'url': item.image.url, 'fact': item.fact.fact});
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Hero(
              tag: item.image.url,
              child: Image.network(item.image.url, fit: BoxFit.contain),
            ),
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFavourites(context) {
    return Container(width: 0.0, height: 0.0);
  }

  Widget _buildAccount(context) {
    return Container(width: 0.0, height: 0.0);
  }
}