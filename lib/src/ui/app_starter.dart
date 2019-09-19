import 'package:cat_test_application/src/blocs/auth/auth_bloc.dart';
import 'package:cat_test_application/src/blocs/auth/auth_event.dart';
import 'package:cat_test_application/src/blocs/auth/auth_state.dart';
import 'package:cat_test_application/src/ui/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStarter extends StatelessWidget {
  const AppStarter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final _authBloc = BlocProvider.of<AuthBloc>(context);
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var prefs = snapshot.data;
          var authBloc = BlocProvider.of<AuthBloc>(context);
          if (prefs.getBool('signedIn') ?? false) {
            switch (prefs.getString('signedInWith')) {
              case 'google':
                authBloc.dispatch(LoadGoogleEvent());
                break;
              case 'facebook':
                authBloc.dispatch(LoadFacebookEvent());
            }
            return BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is LoggedInFacebookState || state is LoggedInGoogleState) {
                  Navigator.of(context).pushReplacementNamed('main', arguments: authBloc);
                }
              },
              child: Scaffold(body: Container(width: 0, height: 0)),
            );
          }
          return SignInScreen();
        }
        return Scaffold(
          body: Center(
            child: Text('Please wait...', style: TextStyle(fontSize: 24)),
          ),
        );
      },
    );
  }
}