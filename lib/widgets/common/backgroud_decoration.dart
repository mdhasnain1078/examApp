import 'package:examapp/configs/theme/appColors.dart';
import 'package:flutter/material.dart';

class BackgroundDecoration extends StatelessWidget {
  const BackgroundDecoration(
      {super.key, required this.child, this.showGredient = false});
  final bool showGredient;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          decoration: BoxDecoration(
              color: showGredient ? null : Theme.of(context).primaryColor,
              gradient: showGredient ? mainGradient() : null),
          child: CustomPaint(painter: BackGroundPaint()),
        )),
        Positioned.fill(child: SafeArea(child: child))
      ],
    );
  }
}

class BackGroundPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white.withOpacity(0.1);
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.2, 0);
    path.lineTo(0, size.height * 0.4);
    path.close();

    final path1 = Path();
    path1.moveTo(size.width, 0);
    path1.lineTo(size.width * 0.8, 0);
    path1.lineTo(size.width * 0.2, size.height);
    path1.lineTo(size.width, size.height);
    path1.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
