import 'package:cat_test_application/src/blocs/auth/auth_event.dart';
import 'package:cat_test_application/src/blocs/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cat_test_application/src/blocs/auth/auth_bloc.dart';

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Cat Test Application')),
      body: _buildBody(context)
    );
  }

  Widget _buildBody(context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (state is UninitializedState)
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

            if (state is LoadingState)
            Center(child: CircularProgressIndicator()),

            if (state is LoggedInGoogleState)
            Center(child: Text('Logged in Google: ${state.user.displayName}')),

            if (state is LoggedInFacebookState)
            Center(child: Text('Logged in Facebook: ${state.user.email}')),

            if (state is ErrorState)
            Center(child: Text('Logged in nothing: ${state.error}')),

            if (state is LoggedInGoogleState || state is LoggedInFacebookState)
            Center(child: RaisedButton(
              child: Text('Sign Out'),
              onPressed: () => authBloc.dispatch(SignOutEvent()),
            ))
          ],
        );
      },
    );
  }
}