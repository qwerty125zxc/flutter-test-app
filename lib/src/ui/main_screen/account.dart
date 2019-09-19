import 'package:cat_test_application/src/blocs/auth/auth_bloc.dart';
import 'package:cat_test_application/src/blocs/auth/auth_event.dart';
import 'package:cat_test_application/src/blocs/auth/auth_state.dart';
import 'package:cat_test_application/src/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildAccount(AuthBloc authBloc) {
  var user = authRepository.currentUser;
  return SingleChildScrollView(
    key: PageStorageKey('3'),
    child: Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
              child: ClipOval(child: Image.network(user.photoUrl))),
          title: Text(user.displayName),
        ),
        ListTile(
          title: Text(user.email),
          subtitle: Text('Email'),
        ),
        RaisedButton(
          child: Text('Sign Out'),
          onPressed: () => authBloc.dispatch(SignOutEvent()),
        ),
        BlocListener<AuthBloc, AuthState>(
          bloc: authBloc,
          listener: (context, state) {
            if (state is UninitializedState)
              Navigator.of(context).pushReplacementNamed('sign_in');
          },
          child: Container(width: 0, height: 0),
        )
      ],
    ),
  );
}
