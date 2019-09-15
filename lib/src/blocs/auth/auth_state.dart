import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class AuthState {}

class UninitializedState implements AuthState {}

class LoadingState implements AuthState {}

class SignOutLoadingState implements AuthState {}

class LoggedInGoogleState implements AuthState {
  final FirebaseUser user;
  LoggedInGoogleState({@required this.user});
}

class LoggedInFacebookState implements AuthState {
  final FirebaseUser user;
  LoggedInFacebookState({@required this.user});
}

class ErrorState implements AuthState {
  final String error;
  ErrorState(this.error);
}
