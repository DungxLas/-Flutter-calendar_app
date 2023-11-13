import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  const TextInput(
      {super.key, required this.obscureText, required this.labelText});
  final bool obscureText;
  final String labelText;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        contentPadding: const EdgeInsets.only(
          left: 5,
        ),
        labelText: widget.labelText,
      ),
    );
  }
}
