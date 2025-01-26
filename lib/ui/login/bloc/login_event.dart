part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginRequestEvent extends LoginEvent {
  dynamic credential;

  LoginRequestEvent(this.credential);

  @override
  List<Object> get props => [credential];
}

