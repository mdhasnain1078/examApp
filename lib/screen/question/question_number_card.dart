import 'package:examapp/configs/theme/ui_parameters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../configs/theme/appColors.dart';
import '../../widgets/questions/answer_card.dart';

class QuestionNumberCard extends StatelessWidget {
  const QuestionNumberCard(
      {super.key, required this.index, this.status, required this.onTap});
  final int index;
  final AnswerStatus? status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).primaryColor;
    switch (status) {
      case AnswerStatus.answered:
        backgroundColor = Get.isDarkMode
            ? Theme.of(context).cardColor
            : Theme.of(context).primaryColor;
        break;
      case AnswerStatus.correct:
        backgroundColor = correctAnswerColor;
        break;
      case AnswerStatus.wrong:
        backgroundColor = wrongAnswerColor;
        break;
      case AnswerStatus.notanswered:
        backgroundColor = backgroundColor = Get.isDarkMode
            ? Colors.red.withOpacity(0.5)
            : Theme.of(context).primaryColor.withOpacity(0.1);
        break;

      default:
        backgroundColor = Theme.of(context).primaryColor.withOpacity(0.1);
    }
    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: backgroundColor,
        ),
        child: Center(
          child: Text(
            "$index",
            style: TextStyle(
                color: status == AnswerStatus.notanswered
                    ? Theme.of(context).primaryColor
                    : null),
          ),
        ),
      ),
    );
  }
}
