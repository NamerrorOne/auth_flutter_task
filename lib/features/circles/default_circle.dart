import 'package:flutter/material.dart';

class DefaultCircle extends StatelessWidget {
  final int number;
  final bool active;

  DefaultCircle({required this.number, required this.active, super.key});

  final activeColor = Colors.orange[300];
  final inactiveColor = const Color.fromARGB(122, 214, 210, 210);

  @override
  Widget build(BuildContext context) {
    Color circleColor = active ? activeColor! : inactiveColor;

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: circleColor,
      ),
      child: Center(
        child: Text('$number',
            style: const TextStyle(color: Colors.black87, fontSize: 20)),
      ),
    );
  }
}
