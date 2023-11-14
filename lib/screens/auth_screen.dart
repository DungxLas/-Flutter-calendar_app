import 'package:calendar_app/widgets/button_intext.dart';
import 'package:calendar_app/widgets/button_large.dart';
import 'package:calendar_app/widgets/text_input.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();

  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredRePassword = '';

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.red, Colors.yellow],
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          //vertical: 60,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    _isLogin ? 'Welcome!' : 'Create New Account!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Form(
                  key: _form,
                  child: Column(
                    children: [
                      TextInput(
                        obscureText: false,
                        labelText: 'Email',
                        validator: (String? value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !value.contains('@')) {
                            return 'Please enter a valid email address.';
                          }
                        },
                        onSaved: (String? value) {
                          _enteredEmail = value!;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextInput(
                        obscureText: true,
                        labelText: 'Password',
                        validator: (String? value) {
                          if (value == null || value.trim().length < 6) {
                            return 'Password must be at least 6 characters long.';
                          }
                        },
                        onSaved: (String? value) {
                          _enteredPassword = value!;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _isLogin
                          ? Container()
                          : TextInput(
                              obscureText: true,
                              labelText: 'Re-write Password',
                              validator: (String? value) {
                                if (value == null || value.trim().length < 6) {
                                  return 'Password must be at least 6 characters long.';
                                }
                              },
                              onSaved: (String? value) {
                                _enteredRePassword = value!;
                              },
                            ),
                      SizedBox(
                        height: _isLogin ? 10 : 20,
                      ),
                    ],
                  ),
                ),
                ButtonLarge(
                  content: _isLogin ? 'Login' : 'Sign Up',
                  onPressed: _submit,
                ),
                _isLogin
                    ? SizedBox(
                        height: 30,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgotten Password?',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      )
                    : Container(),
                _isLogin
                    ? SizedBox(
                        height: 40,
                        child: ButtonInText(
                          text: 'Or ',
                          textTap: 'Create A New Account',
                          onTap: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                        ),
                      )
                    : SizedBox(
                        height: 40,
                        child: ButtonInText(
                          text: 'Already have an account? ',
                          textTap: 'Login',
                          onTap: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}