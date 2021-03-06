import 'dart:math' as math;
import 'package:flutter/material.dart';



class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;


  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;


    ///draws the underlying circle
    Size s = new Size(size.width, size.width);
    Offset o = new Offset(0, size.width/-6.2);
    canvas.drawArc(o & s, math.pi * 1.5, 10, false, paint);
    //canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);

    ///draws the overlying circle with another color
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(o & s, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation.value != old.animation.value || color != old.color || backgroundColor != old.backgroundColor;
  }


}