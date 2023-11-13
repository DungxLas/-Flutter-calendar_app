import 'package:calendar_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/button_intext.dart';
import '../widgets/button_large.dart';
import '../widgets/text_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                'Create New Account!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const TextInput(obscureText: false, labelText: 'Email Address'),
            const SizedBox(
              height: 10,
            ),
            const TextInput(obscureText: false, labelText: 'Username'),
            const SizedBox(
              height: 10,
            ),
            const TextInput(obscureText: true, labelText: 'Password'),
            const SizedBox(
              height: 10,
            ),
            const TextInput(obscureText: true, labelText: 'Re-write Password'),
            const SizedBox(
              height: 20,
            ),
            ButtonLarge(
              content: 'Sign Up',
              onPressed: () {},
            ),
            SizedBox(
              height: 40,
              child: ButtonInText(
                text: 'Already have an account? ',
                textTap: 'Login',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const LoginScreen(),
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
