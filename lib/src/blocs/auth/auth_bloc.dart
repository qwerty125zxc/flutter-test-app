import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cat_test_application/src/user_repository.dart';

enum AuthEvent { appStart, loadFacebook, loadGoogle}
enum AuthState { uninitialized, loading, loggedInFacebook, loggedInGoogle }

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  @override
  AuthState get initialState => AuthState.uninitialized;

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    switch (event) {
      case AuthEvent.loadGoogle:
        yield AuthState.loading;
        await userRepository.signInwithGoogle();
        yield AuthState.loggedInGoogle;
        break;
      case AuthEvent.loadFacebook:
        break;
      case AuthEvent.appStart:
        break;
    }
  }
}