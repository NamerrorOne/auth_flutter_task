import 'package:flutter/material.dart';

class CircleDone extends StatelessWidget {
  const CircleDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: Colors.green,
            width: 2,
          ),
        ),
        child: const Center(child: Icon(Icons.check, color: Colors.green)));
  }
}
