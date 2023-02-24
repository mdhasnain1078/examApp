import 'package:examapp/Home/question_card.dart';
import 'package:examapp/configs/theme/custom_text_style.dart';
import 'package:examapp/configs/theme/ui_parameters.dart';
import 'package:examapp/controller/question_paper_controller.dart';
import 'package:examapp/widgets/app_circle_button.dart';
import 'package:examapp/widgets/content_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../configs/theme/appColors.dart';
import '../controller/zoom_drawer_controller.dart';
import 'manu_screen.dart';

class HomePage extends GetView<MyZoomDrawerController> {
  const HomePage({super.key});
  static const String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    QuestionPaperController questionPaperController = Get.find();
    return Scaffold(
        body: GetBuilder<MyZoomDrawerController>(builder: (controller) {
      return ZoomDrawer(
        borderRadius: 50,
        controller: controller.zoomDreaweController,
        showShadow: true,
        backgroundColor: Colors.white.withOpacity(0.5),
        angle: 0.0,
        style: DrawerStyle.DefaultStyle,
        slideWidth: MediaQuery.of(context).size.width * 0.4,
        menuScreen: const ManuScreen(),
        mainScreen: Container(
          decoration: BoxDecoration(gradient: mainGradient()),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(mobileScreenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppCircleButton(
                        onTap: controller.toogleDrawer,
                        child: const Icon(
                          // AppIcons.menuleft,
                          Icons.menu_open,
                          size: 30,
                          color: onSurfaceTextColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.back_hand,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Hello Freinds',
                              style: detailText.copyWith(
                                  color: onSurfaceTextColor),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        "What do you want to learn today",
                        style: headerText,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: ContentArea(
                      addPadding: false,
                      child: Obx(
                        () => ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            padding: UIParameters.mobileScreenPadding,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return QuestionCard(
                                  model:
                                      questionPaperController.allPapers[index]);
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                            itemCount:
                                questionPaperController.allPaperImages.length),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }));
  }
}
