import 'package:examapp/configs/theme/appColors.dart';
import 'package:examapp/configs/theme/ui_parameters.dart';
import 'package:flutter/material.dart';

class ContentArea extends StatelessWidget {
  const ContentArea({super.key, this.addPadding = true, required this.child});
  final bool addPadding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20), bottom: Radius.zero),
      clipBehavior: Clip.hardEdge,
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          color: CustomScaffoldColor(context),
        ),
        padding: addPadding
            ? EdgeInsets.only(
                top: mobileScreenPadding,
                left: mobileScreenPadding,
                right: mobileScreenPadding)
            : EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
