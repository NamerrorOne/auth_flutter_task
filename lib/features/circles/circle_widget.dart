import 'package:auth_task/features/circles/default_circle.dart';
import 'package:auth_task/features/circles/done_circle.dart';
import 'package:flutter/material.dart';

class StepCircle extends StatelessWidget {
  final int number;
  final bool active;
  final bool done;

  StepCircle(
      {required this.number,
      required this.active,
      required this.done,
      super.key});

  final activeColor = Colors.orange[300];
  final inactiveColor = Color.fromARGB(122, 214, 210, 210);

  @override
  Widget build(BuildContext context) {
    return !done
        ? DefaultCircle(
            number: number,
            active: active,
          )
        : const CircleDone();
  }
}
