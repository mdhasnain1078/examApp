import 'package:examapp/configs/theme/appColors.dart';
import 'package:examapp/configs/theme/custom_text_style.dart';
import 'package:examapp/configs/theme/ui_parameters.dart';
import 'package:examapp/controller/question_paper/questions_controller.dart';
import 'package:examapp/firebase_ref/loading_status.dart';
import 'package:examapp/screen/question/test_overview_screen.dart';
import 'package:examapp/widgets/common/backgroud_decoration.dart';
import 'package:examapp/widgets/common/custom_app_bar.dart';
import 'package:examapp/widgets/common/main_button.dart';
import 'package:examapp/widgets/content_area.dart';
import 'package:examapp/widgets/questions/answer_card.dart';
import 'package:examapp/widgets/questions/count_down_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/common/question_place_holder.dart';

class QuestionScreen extends GetView<QuestionController> {
  const QuestionScreen({super.key});
  static const routeName = "/question_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(
          () => Text(
            "Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}",
            style: appBarTS,
          ),
        ),
        leading: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: const ShapeDecoration(
              shape: StadiumBorder(
                  side: BorderSide(color: onSurfaceTextColor, width: 2))),
          child: Obx(() => CountDownTimer(
                timer: controller.time.value,
                color: onSurfaceTextColor,
              )),
        ),
        showActionIcon: true,
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
                                id: "answers_list",
                                builder: (context) {
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(top: 25),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (cxt, i) {
                                      final answer = controller
                                          .currentQuestion.value!.answers![i];
                                      return AnswerCard(
                                        answer:
                                            "${answer.identifier}. ${answer.answer}",
                                        onTap: () {
                                          controller.selectedAnswer(
                                              answer.identifier);
                                        },
                                        iselected: answer.identifier ==
                                            controller.currentQuestion.value!
                                                .selectedAnswer,
                                      );
                                    },
                                    itemCount: controller
                                        .currentQuestion.value!.answers!.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const SizedBox(
                                      height: 10,
                                    ),
                                  );
                                }),
                          ]),
                          ColoredBox(
                            color:
                                // Colors.white,
                                CustomScaffoldColor(context),
                            child: Padding(
                              padding: UIParameters.mobileScreenPadding,
                              child: Row(
                                children: [
                                  Visibility(
                                    visible: controller.isFirstQuestion,
                                    child: SizedBox(
                                      height: 55,
                                      width: 55,
                                      child: MainBtton(
                                        onTap: () {
                                          controller.previousQuestion();
                                        },
                                        child: Icon(
                                          Icons.arrow_back_ios_new,
                                          color: Get.isDarkMode
                                              ? onSurfaceTextColor
                                              : Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Visibility(
                                      visible: controller.loadingStatus.value ==
                                          LoadingStatus.completed,
                                      child: MainBtton(
                                        title: controller.isLastQuestion
                                            ? "Completed"
                                            : "Next",
                                        onTap: () {
                                          controller.isLastQuestion
                                              ? Get.toNamed(
                                                  TestOverviewScreen.routeName)
                                              : controller.nextQuestion();
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
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
