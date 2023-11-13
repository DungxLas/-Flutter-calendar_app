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
          children: [
            Expanded(
              flex: 3,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome!',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'Enter Your Username & Password',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      contentPadding: EdgeInsets.only(
                        left: 5,
                      ),
                      labelText: 'Username',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      contentPadding: EdgeInsets.only(
                        left: 5,
                      ),
                      labelText: 'Password',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 4,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, // Màu của text
                        backgroundColor: Colors.black, // Màu nền của nút
                        shape: RoundedRectangleBorder(
                          // Bo góc
                          borderRadius: BorderRadius.circular(20), // Độ bo góc
                        ),
                      ),
                      onPressed: () {},
                      child: Container(
                        width: double.infinity, // Chiều rộng tối đa
                        alignment: Alignment.center, // Căn giữa text
                        child: const Text('Login'),
                      ),
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
                      child: TextButton(
                        onPressed: () {},
                        child: RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.titleMedium,
                              children: const [
                                TextSpan(text: 'Or '),
                                TextSpan(
                                  text: 'Create A New Account',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
