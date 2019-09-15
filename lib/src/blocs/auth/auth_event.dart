import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthState {}

class Uninitialized implements AuthState {}

class LoadingGoogle implements AuthState {}