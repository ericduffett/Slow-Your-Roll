import 'package:flutter/material.dart';


class CheckEmpty extends StatelessWidget {
  const CheckEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 8.0),
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 2, color: Colors.white70)
          ),
        ),
      ),
    );
  }
}

class CheckFilled extends StatelessWidget {
  const CheckFilled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 8.0),
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: const Color(0xFF4DBD98),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(width: 2, color: Colors.white70)
          ),
          child: const Icon(Icons.check,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}