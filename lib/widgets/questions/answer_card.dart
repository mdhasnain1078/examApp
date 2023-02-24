import 'package:examapp/configs/theme/appColors.dart';
import 'package:examapp/configs/theme/ui_parameters.dart';
import 'package:flutter/material.dart';

enum AnswerStatus { correct, wrong, answered, notanswered }

class AnswerCard extends StatelessWidget {
  AnswerCard(
      {super.key,
      required this.answer,
      required this.onTap,
      this.iselected = false});
  final String answer;
  final VoidCallback onTap;
  bool iselected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: UIParameters.cardBorderRadius,
            color:
                iselected ? answerSelectedColor() : Theme.of(context).cardColor,
            border: Border.all(
                color: iselected ? answerSelectedColor() : answeBorderColor())),
        child: Text(
          answer,
          style: TextStyle(
            color: iselected ? onSurfaceTextColor : null,
          ),
        ),
      ),
    );
  }
}

class CorrectAnswe extends StatelessWidget {
  const CorrectAnswe({super.key, required this.answer});
  final String answer;
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: correctAnswerColor.withOpacity(0.1)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Text(
          answer,
          style:
              TextStyle(color: correctAnswerColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class WrongAnswer extends StatelessWidget {
  const WrongAnswer({super.key, required this.answer});
  final String answer;
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: wrongAnswerColor.withOpacity(0.1)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Text(
          answer,
          style:
              TextStyle(color: wrongAnswerColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class notAnswer extends StatelessWidget {
  const notAnswer({super.key, required this.answer});
  final String answer;
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: notAnsweredColor.withOpacity(0.1)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Text(
          answer,
          style:
              TextStyle(color: notAnsweredColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
