import 'package:flutter/material.dart';

class ButtonLarge extends StatelessWidget {
  const ButtonLarge(
      {super.key, required this.content, required this.onPressed});
  final String content;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, // Màu của text
        backgroundColor: Colors.black, // Màu nền của nút
        shape: RoundedRectangleBorder(
          // Bo góc
          borderRadius: BorderRadius.circular(20), // Độ bo góc
        ),
      ),
      onPressed: onPressed,
      child: Container(
        width: double.infinity, // Chiều rộng tối đa
        alignment: Alignment.center, // Căn giữa text
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
