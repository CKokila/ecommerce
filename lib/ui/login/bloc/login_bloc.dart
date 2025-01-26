import 'dart:async';

import 'package:ecommerce/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/login_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
   LoginRepo loginRepo = LoginRepo();

  LoginBloc() : super(LoginInitial()) {
    on<LoginRequestEvent>(_login);
  }

  Future<void> _login(LoginRequestEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      bool isLoggedIn = await loginRepo.login(data: event.credential);
      Log.d("State $isLoggedIn");
      emit(CustomerLoginSuccess());
    } catch (e) {
      Log.d("State error $e");
      emit(DataError(error: e.toString()));
    }
  }
}
