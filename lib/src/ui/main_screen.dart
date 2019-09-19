import 'package:cat_test_application/src/blocs/auth/auth_bloc.dart';
import 'package:cat_test_application/src/ui/main_screen/account.dart';
import 'package:flutter/material.dart';

import 'main_screen/index.dart';
import 'main_screen/favourites.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int currentTabIndex = 0;

  AuthBloc authBloc;

  @override
  Widget build(BuildContext context) {

    authBloc = ModalRoute.of(context).settings.arguments;
    

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
      case 2: return buildAccount(authBloc);
      default: return Container(width: 0, height: 0);
    }
  }
}