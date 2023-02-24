import 'package:flutter/material.dart';
import '../../configs/theme/custom_text_style.dart';

class CountDownTimer extends StatelessWidget {
  const CountDownTimer({super.key, this.color, required this.timer});
  final Color? color;
  final String timer;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(
        Icons.timer,
        color: color ?? Theme.of(context).primaryColor,
      ),
      const SizedBox(
        width: 5,
      ),
      Text(
        timer,
        style: countDownTimerTS().copyWith(color: color),
      )
    ]);
  }
}
