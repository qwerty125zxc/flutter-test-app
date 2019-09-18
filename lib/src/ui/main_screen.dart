import 'package:flutter/material.dart';

import 'main_screen/index.dart';
import 'main_screen/favourites.dart';

class MainScreen extends StatefulWidget {

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {

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
      body: pageByIndex(context, currentTabIndex),
      bottomNavigationBar: bottomNavBar,
    );
  }
  Widget pageByIndex(context, int index) {
    switch(index) {
      case 0: return buildHome(context);
      case 1: return buildFavourites(context);
      case 2: return Center(child: Text('hello world'));
      default: return Container(width: 0, height: 0);
    }
  }
}