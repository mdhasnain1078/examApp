import 'package:examapp/configs/theme/custom_text_style.dart';
import 'package:examapp/controller/question_paper/questions_controller.dart';
import 'package:examapp/screen/question/result_screen.dart';
import 'package:examapp/screen/question/test_overview_screen.dart';
import 'package:examapp/widgets/common/backgroud_decoration.dart';
import 'package:examapp/widgets/common/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../configs/theme/appColors.dart';
import '../../configs/theme/ui_parameters.dart';
import '../../firebase_ref/loading_status.dart';
import '../../widgets/common/main_button.dart';
import '../../widgets/common/question_place_holder.dart';
import '../../widgets/content_area.dart';
import '../../widgets/questions/answer_card.dart';

class AnswerCheckScreen extends GetView<QuestionController> {
  const AnswerCheckScreen({super.key});
  static const String routeName = "/answercheckscreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(
          () => Text(
            'Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, "0")}',
            style: appBarTS,
          ),
        ),
        showActionIcon: true,
        onManuActionTap: () {
          Get.toNamed(ResultScreen.routeName);
        },
      ),
      body: BackgroundDecoration(
        child: Obx(
          () => SafeArea(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (controller.loadingStatus.value == LoadingStatus.loading)
                  const Expanded(
                      child: ContentArea(child: QuestionPlaceHolder())),
                if (controller.loadingStatus.value == LoadingStatus.completed)
                  Expanded(
                    child: ContentArea(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(children: [
                              Text(
                                controller.currentQuestion.value!.question
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              GetBuilder<QuestionController>(
                                  id: "answer_review_list",
                                  builder: (context) {
                                    return ListView.separated(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.only(top: 25),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (cxt, i) {
                                        final answer = controller
                                            .currentQuestion.value!.answers![i];
                                        final selectedAnswer = controller
                                            .currentQuestion
                                            .value!
                                            .selectedAnswer;
                                        final correctAnswer = controller
                                            .currentQuestion
                                            .value!
                                            .correctAnswer;
                                        final String answerText =
                                            '${answer.identifier}. ${answer.answer}';
                                        if (correctAnswer == selectedAnswer &&
                                            answer.identifier ==
                                                selectedAnswer) {
                                          //  correct answer
                                          return CorrectAnswe(
                                              answer: answerText);
                                          ;
                                        } else if (selectedAnswer == null) {
                                          // not selected answer
                                          return notAnswer(answer: answerText);
                                        } else if (correctAnswer !=
                                                selectedAnswer &&
                                            answer.identifier ==
                                                selectedAnswer) {
                                          //  wrong answer

                                          return WrongAnswer(
                                            answer: answerText,
                                          );
                                        } else if (correctAnswer ==
                                            answer.identifier) {
                                          //  correct answer
                                          return CorrectAnswe(
                                              answer: answerText);
                                        }
                                        return AnswerCard(
                                          answer: answerText,
                                          onTap: () {},
                                          iselected: answer.identifier ==
                                              controller.currentQuestion.value!
                                                  .selectedAnswer,
                                        );
                                      },
                                      itemCount: controller.currentQuestion
                                          .value!.answers!.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const SizedBox(
                                        height: 10,
                                      ),
                                    );
                                  }),
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
