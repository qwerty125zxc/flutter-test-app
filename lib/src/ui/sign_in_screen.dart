import 'package:cat_test_application/src/blocs/auth/auth_event.dart';
import 'package:cat_test_application/src/blocs/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cat_test_application/src/blocs/auth/auth_bloc.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(body: BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is LoadingState)
          return Center(child: CircularProgressIndicator());

        if (state is ErrorState)
          return Center(child: Text('Logged in nothing: ${state.error}'));

        if (state is UninitializedState)
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Sign In With Google'),
                    onPressed: () => authBloc.dispatch(LoadGoogleEvent()),
                  ),
                  RaisedButton(
                    child: Text('Sign In With Facebook'),
                    onPressed: () => authBloc.dispatch(LoadFacebookEvent()),
                  ),
                ],
              ),
            ],
          );
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Signed in successfully!'),
              RaisedButton(
                child: Text('Go'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'main');
                },
              )
            ],
          ),
        );
      },
    ));
  }
}
