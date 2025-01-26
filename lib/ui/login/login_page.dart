import 'package:auto_route/auto_route.dart';
import 'package:ecommerce/routing/app_router.dart';
import 'package:ecommerce/ui/login/components/banner.dart';
import 'package:ecommerce/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../const/color.dart';
import '../../data/prefs/current_user.dart';
import '../../utils/dimens.dart';
import '../widget/actionbar.dart';
import '../widget/common.dart';
import '../widget/textfield.dart';
import 'bloc/login_bloc.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  FocusNode passwordFocus = FocusNode();
  bool _isObscure = true;
  final bool _isLoading = false;
  LoginBloc loginBloc = LoginBloc();
  final CurrentUser user = CurrentUser();

  _loginBloc() {
    var data = {
      "username": username.text,
      "password": password.text,
    };
    loginBloc.add(LoginRequestEvent(data));
  }

  @override
  void initState() {
    username.text = "mor_2314";
    password.text = "83r5^_";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        bloc: loginBloc,
        listener: (context, state) {
          Log.d("State $state");
          if (state is DataError) {
            // errorSnackbar(context, state.error.toString());
          }

          if (state is CustomerLoginSuccess) {
            Log.d("Login success");
            context.router.push(const HomeRoute());
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          bloc: loginBloc,
          builder: (context, state) {
            return SafeArea(
              bottom: false,
              top: false,
              child: Row(
                children: [
                  loginBanner(context),
                  Expanded(
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.04,
                              vertical: height * 0.04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Welcome Back",
                                            style: textTheme.headlineLarge?.apply(
                                                fontWeightDelta: 12,
                                                color: kPrimaryLight),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Please login to your account",
                                            style: textTheme.bodySmall?.apply(
                                                fontWeightDelta: 12,
                                                color: kGrey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    LoginTextField(
                                      textController: username,
                                      hintText: "Enter your phone number",
                                      length: 15,
                                      inputType: TextInputType.number,
                                      inputFormat: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      validator: (v) {
                                        if (v?.isEmpty ?? false) {
                                          return "Phone number is required";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 18.0),
                                      child: PasswordField(
                                        textController: password,
                                        hintText: "Enter password",
                                        obscureText: _isObscure,
                                        onFieldSubmitted: (v) {
                                          if (state is! LoginLoading &&
                                              _formKey.currentState
                                                      ?.validate() ==
                                                  true) {
                                            _loginBloc();
                                          }
                                        },
                                        validator: (v) {
                                          if (v?.isEmpty ?? false) {
                                            return "Password is required";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onEnter: () {
                                          setState(() {
                                            _isObscure = !_isObscure;
                                          });
                                        },
                                        passwordFocus: passwordFocus,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                  width: width - 40,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  borderRadiusAll_10)),
                                      onPressed: () async {
                                        if (state is! LoginLoading &&
                                            _formKey.currentState?.validate() ==
                                                true) {
                                          _loginBloc();
                                        }
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        child: Text("Login"),
                                      ))),
                            ],
                          ),
                        ),
                        if (_isLoading || state is LoginLoading)
                          circularProgress(true, context),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
