import 'package:cat_test_application/src/user_repository.dart';
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
    return Center(
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Column(
            children: <Widget>[
              if (state == AuthState.uninitialized)
              RaisedButton(
                child: Text('Sign In With Google'),
                onPressed: () => authBloc.dispatch(AuthEvent.loadGoogle),
              ),
              if (state == AuthState.loading)
              CircularProgressIndicator(),
              if (state == AuthState.loggedInGoogle)
              Text('Logged in Google: ${userRepository.userAccount.email}'),
            ],
          );
        },
      )
    );
  }
}