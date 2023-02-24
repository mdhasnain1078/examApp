import 'package:examapp/configs/theme/custom_text_style.dart';
import 'package:examapp/configs/theme/ui_parameters.dart';
import 'package:examapp/controller/question_paper/questions_controller.dart';
import 'package:examapp/screen/question/question_number_card.dart';
import 'package:examapp/widgets/common/backgroud_decoration.dart';
import 'package:examapp/widgets/common/custom_app_bar.dart';
import 'package:examapp/widgets/common/main_button.dart';
import 'package:examapp/widgets/content_area.dart';
import 'package:examapp/widgets/questions/answer_card.dart';
import 'package:examapp/widgets/questions/count_down_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../configs/theme/appColors.dart';

class TestOverviewScreen extends GetView<QuestionController> {
  const TestOverviewScreen({super.key});
  static const routeName = "/testoverview";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: controller.completedTest,
      ),
      body: BackgroundDecoration(
          child: Column(
        children: [
          Expanded(
              child: ContentArea(
            child: Column(
              children: [
                Row(
                  children: [
                    CountDownTimer(
                      timer: '',
                      color: UIParameters.isDarkMode()
                          ? Theme.of(context).textTheme.bodyText1!.color
                          : Theme.of(context).primaryColor,
                    ),
                    Obx(() => Text(
                          "${controller.time} Remaining",
                          style: countDownTimerTS(),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GridView.builder(
                      itemCount: controller.allQuestions.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Get.width ~/ 75,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8),
                      itemBuilder: (ctx, i) {
                        AnswerStatus? _answerStatus;
                        if (controller.allQuestions[i].selectedAnswer != null) {
                          _answerStatus = AnswerStatus.answered;
                        }
                        return QuestionNumberCard(
                            index: i + 1,
                            status: _answerStatus,
                            onTap: () {
                              controller.jumpToQuestion(i);
                            });
                      }),
                ),
                ColoredBox(
                  color: CustomScaffoldColor(context),
                  child: Padding(
                    padding: UIParameters.mobileScreenPadding,
                    child: MainBtton(
                      onTap: () {
                        controller.complete();
                      },
                      title: 'Complete',
                    ),
                  ),
                )
              ],
            ),
          )),
        ],
      )),
    );
  }
}
