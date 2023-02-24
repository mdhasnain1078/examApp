import 'package:examapp/configs/theme/custom_text_style.dart';
import 'package:examapp/screen/question/test_overview_screen.dart';
import 'package:examapp/widgets/app_circle_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      this.title = '',
      this.titleWidget,
      this.leading,
      this.showActionIcon = false,
      this.onManuActionTap});
  final String title;
  final Widget? titleWidget;
  final Widget? leading;
  final bool showActionIcon;
  final VoidCallback? onManuActionTap;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
              child: titleWidget == null
                  ? Center(
                      child: Text(
                        title,
                        style: appBarTS,
                      ),
                    )
                  : Center(
                      child: titleWidget,
                    )),
          Row(
            children: [
              leading ??
                  Transform.translate(
                    offset: const Offset(-14, 0),
                    child: const BackButton(),
                  ),
              if (showActionIcon)
                Transform.translate(
                  offset: Offset(deviceWidth * 0.63, 0),
                  child: AppCircleButton(
                    onTap: onManuActionTap ??
                        () => Get.toNamed(TestOverviewScreen.routeName),
                    child: const Icon(
                      Icons.blur_on_rounded,
                      size: 25,
                    ),
                  ),
                )
            ],
          )
        ],
      ),
    ));
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 80);
}
