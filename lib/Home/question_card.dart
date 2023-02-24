import 'package:cached_network_image/cached_network_image.dart';
import 'package:examapp/configs/theme/ui_parameters.dart';
import 'package:examapp/controller/question_paper_controller.dart';
import 'package:examapp/models/question_paper_model.dart';
import 'package:examapp/widgets/app_icon_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../configs/theme/custom_text_style.dart';

class QuestionCard extends GetView<QuestionPaperController> {
  const QuestionCard({super.key, required this.model});
  final QuestionPaperModel model;

  @override
  Widget build(BuildContext context) {
    const double _padding = 10.0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: Theme.of(context).cardColor,
      ),
      child: InkWell(
        onTap: () {
          controller.navigateToQuestion(paper: model);
        },
        child: Padding(
          padding: const EdgeInsets.all(_padding),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ColoredBox(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      child: SizedBox(
                        height: Get.width * 0.15,
                        width: Get.width * 0.15,
                        child: CachedNetworkImage(
                          imageUrl: model.imageUrl!,
                          placeholder: (context, url) => Container(
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/images/app_splash_logo.png"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${model.title}", style: cartTitles(context)),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 15),
                          child: Text("${model.description}"),
                        ),
                        Row(
                          children: [
                            AppIconText(
                                icon: Icon(
                                  Icons.help_outline_sharp,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                ),
                                text: Text("${model.questionCount} questions",
                                    style: detailText.copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Theme.of(context).primaryColor,
                                    ))),
                            const SizedBox(
                              width: 15,
                            ),
                            AppIconText(
                                icon: Icon(
                                  Icons.timer,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                ),
                                text: Text(model.timeInMinutes(),
                                    style: detailText.copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Theme.of(context).primaryColor,
                                    )))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                  bottom: -_padding,
                  right: -_padding,
                  child: GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(cardBorderRadius),
                              bottomRight: Radius.circular(cardBorderRadius))),
                      child: const Icon(
                        Icons.wine_bar_outlined,
                        size: 20,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
