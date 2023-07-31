import 'dart:convert';
import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_menu/models/base/api_response.dart';
import 'package:flutter_menu/models/login/login_request.dart';
import 'package:flutter_menu/pages/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/login/access_token.dart';
import '../../services/login_service.dart';
import '../home.dart';

class LoginFormState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool isLoading = false;

  final userController = TextEditingController();
  final passwordController = TextEditingController();

  void showSnackBarMessage(message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  void changeLoadingState() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.all(8.0),
                  child: const Icon(Icons.grid_on_outlined)),
              Container(
                margin: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: userController,
                  obscureText: false,
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Campo obrigatório';
                    }

                    if (!EmailValidator.validate(email)) {
                      return 'E-mail inválido';
                    }

                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: !showPassword,
                  validator: (password) {
                    if (password == null || password.isEmpty) {
                      return 'Campo obrigatório';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: Icon(showPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: AlignmentDirectional.center,
                margin: const EdgeInsets.all(8.0),
                width: double.maxFinite,
                height: 44,
                child: TextButton(
                  onPressed: () {
                    print('Esqueci a senha');
                  },
                  child: const Text('Esqueci a minha senha'),
                ),
              ),
              isLoading
                  ? const CircularProgressIndicator()
                  : Container(
                      margin: const EdgeInsets.all(8.0),
                      width: double.maxFinite,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () async {
                          changeLoadingState();

                          if (!_formKey.currentState!.validate()) {
                            changeLoadingState();
                            return;
                          }

                          _formKey.currentState!.save();

                          try {
                            var result = await login(LoginRequest(
                                userController.text, passwordController.text));

                            loginUser(result);
                          } catch (ex) {
                            changeLoadingState();
                            log('Error while login user.', error: ex);
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(8.0),
                width: double.maxFinite,
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Não possui uma conta?'),
                    TextButton(
                        onPressed: () {
                          print('Criar conta');
                        },
                        child: const Text('Criar'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void loginUser(ApiResponse<AccessToken> apiResponse) {
    if (apiResponse.apiError != null) {
      log(jsonEncode(apiResponse.apiError));
      changeLoadingState();
      showSnackBarMessage(apiResponse.apiError);
    }
    if (apiResponse.data != null) {
      var accessToken = apiResponse.data as AccessToken;

      var prefs = SharedPreferences.getInstance();
      prefs.then((pref) => pref.setString('x-token', accessToken.token));
      prefs.then((pref) =>
          pref.setString('x-expiresIn', accessToken.expiresIn.toString()));

      changeLoadingState();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    }
  }
}
