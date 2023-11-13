import 'package:calendar_app/screens/register_screen.dart';
import 'package:calendar_app/widgets/button_intext.dart';
import 'package:calendar_app/widgets/button_large.dart';
import 'package:calendar_app/widgets/text_input.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          vertical: 60,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                'Welcome!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            const TextInput(obscureText: false, labelText: 'Username'),
            const SizedBox(
              height: 10,
            ),
            const TextInput(obscureText: true, labelText: 'Password'),
            const SizedBox(
              height: 20,
            ),
            ButtonLarge(
              content: 'Login',
              onPressed: () {},
            ),
            SizedBox(
              height: 30,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Forgotten Password?',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: ButtonInText(
                text: 'Or ',
                textTap: 'Create A New Account',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const RegisterScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
