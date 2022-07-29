import 'package:flutter/material.dart';

class DismissTextButton extends StatelessWidget {
  const DismissTextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('OK',
        style: TextStyle(
            color: Color(0xFF2c3e50),
            fontWeight: FontWeight.bold,
            fontSize: 16.0
        ),
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
