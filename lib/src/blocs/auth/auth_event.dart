abstract class AuthEvent {}

class AppStartedEvent implements AuthEvent {}

class LoadFacebookEvent implements AuthEvent {}

class LoadGoogleEvent implements AuthEvent {}

class ErrorEvent implements AuthEvent {
  final String error;
  ErrorEvent(this.error);
}