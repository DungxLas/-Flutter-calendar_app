import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    super.key,
    required this.obscureText,
    required this.labelText,
    required this.validator,
    required this.onSaved,
  });
  final bool obscureText;
  final String labelText;
  final String? Function(String?) validator;
  final Function(String?) onSaved;

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
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      validator: (value) {
        return widget.validator(value);
      },
      onSaved: (value) {
        widget.onSaved(value);
      },
    );
  }
}
