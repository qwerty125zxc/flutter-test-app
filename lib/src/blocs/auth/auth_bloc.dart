import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cat_test_application/src/repositories/auth_repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  @override
  AuthState get initialState => UninitializedState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoadFacebookEvent) {
      //do stuff
    }
    else if (event is LoadGoogleEvent) {
      yield LoadingState();
      yield LoggedInGoogleState(
        user: await authRepository.signInWithGoogle()
        .catchError((error) => dispatch(ErrorEvent('$error')))
      );
    }
    else if (event is ErrorEvent) {
      yield ErrorState(event.error);
    }
  }
}