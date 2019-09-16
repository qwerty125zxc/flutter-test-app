import 'package:cat_test_application/src/blocs/auth/auth_bloc.dart';
import 'package:cat_test_application/src/blocs/auth/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Test Application'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Sign Out'),
          onPressed: () => BlocProvider.of<AuthBloc>(context).dispatch(SignOutEvent()),
        ),
      ),
    );
  }
}