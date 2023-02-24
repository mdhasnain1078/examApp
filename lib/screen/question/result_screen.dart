import 'package:examapp/configs/theme/custom_text_style.dart';
import 'package:examapp/configs/theme/ui_parameters.dart';
import 'package:examapp/controller/question_paper/question_controller_extension.dart';
import 'package:examapp/controller/question_paper/questions_controller.dart';
import 'package:examapp/screen/question/answer_check_screen.dart';
import 'package:examapp/screen/question/question_number_card.dart';
import 'package:examapp/widgets/common/backgroud_decoration.dart';
import 'package:examapp/widgets/common/custom_app_bar.dart';
import 'package:examapp/widgets/content_area.dart';
import 'package:examapp/widgets/questions/answer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../configs/theme/appColors.dart';
import '../../widgets/common/main_button.dart';

class ResultScreen extends GetView<QuestionController> {
  const ResultScreen({super.key});
  static const String routeName = "/resultscreen";
  @override
  Widget build(BuildContext context) {
    Color _textColor =
        Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor;
    return Scaffold(
        body: BackgroundDecoration(
      child: Column(
        children: [
          CustomAppBar(
            leading: const SizedBox(
              height: 80,
            ),
            title: controller.correctAnsweredQuestions,
          ),
          Expanded(
              child: ContentArea(
            child: Column(children: [
              SvgPicture.asset('assets/images/bulb.svg'),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 5),
                child: Text(
                  "Congratulations",
                  style: headerText.copyWith(color: _textColor),
                ),
              ),
              Text(
                "You have ${controller.points} points",
                style: TextStyle(color: _textColor),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Tap below question numbers to view the answers",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 25,
              ),
              Expanded(
                  child: GridView.builder(
                      itemCount: controller.allQuestions.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Get.width ~/ 75,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8),
                      itemBuilder: (cxt, i) {
                        final _question = controller.allQuestions[i];
                        AnswerStatus _status = AnswerStatus.notanswered;
                        final _selectedAnswer = _question.selectedAnswer;
                        final _correctAnswer = _question.correctAnswer;
                        if (_selectedAnswer == _correctAnswer) {
                          _status = AnswerStatus.correct;
                        } else if (_question.selectedAnswer == null) {
                          _status = AnswerStatus.wrong;
                        } else {
                          _status = AnswerStatus.wrong;
                        }
                        return QuestionNumberCard(
                          index: i + 1,
                          onTap: () {
                            controller.jumpToQuestion(i, isGoBack: false);
                            Get.toNamed(AnswerCheckScreen.routeName);
                          },
                          status: _status,
                        );
                      })),
              ColoredBox(
                color: CustomScaffoldColor(context),
                child: Padding(
                  padding: UIParameters.mobileScreenPadding,
                  child: Row(
                    children: [
                      Expanded(
                          child: MainBtton(
                        onTap: () {
                          controller.tryAgain();
                        },
                        color: Colors.blueGrey,
                        title: 'Try again',
                      )),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: MainBtton(
                        onTap: () {
                          controller.saveTestResult();
                        },
                        title: 'Go home',
                      ))
                    ],
                  ),
                ),
              )
            ]),
          ))
        ],
      ),
    ));
  }
}
