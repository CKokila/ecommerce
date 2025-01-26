part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class CustomerLoginSuccess extends LoginState {}

class DataError extends LoginState {
  final String error;

  DataError({required this.error});
}


