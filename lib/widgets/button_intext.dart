import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ButtonInText extends StatelessWidget {
  const ButtonInText({
    super.key,
    required this.text,
    required this.textTap,
    required this.onTap,
  });
  final String text, textTap;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(style: Theme.of(context).textTheme.titleMedium, children: [
        TextSpan(text: text),
        TextSpan(
          text: textTap,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()..onTap = onTap,
        ),
      ]),
    );
  }
}
