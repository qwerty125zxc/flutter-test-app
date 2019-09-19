import 'package:cat_test_application/src/ui/main_screen.dart';
import 'package:cat_test_application/src/ui/show_screen.dart';
import 'package:cat_test_application/src/ui/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/auth/auth_bloc.dart';
import 'ui/app_starter.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(builder: (BuildContext context) => AuthBloc()),
      ],
      child: MaterialApp(
        title: 'Cat Test Application',
        theme: ThemeData(primarySwatch: Colors.blue),
        routes: {
          '/': (context) => AppStarter(),
          'main': (context) => MainScreen(),
          'show': (context) => ShowScreen(),
          'sign_in': (context) => SignInScreen(),
        },
      ),
    );
  }
}
