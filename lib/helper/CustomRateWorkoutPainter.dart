import 'package:flutter/material.dart';

class CustomRateWorkoutPainter extends CustomPainter{

  CustomRateWorkoutPainter({
    this.animation,
    this.backgroundColor,
    this.color,
    this.posX,
  }) : super(repaint: animation);


  final Animation<double> animation;
  final Color backgroundColor, color;
  final double posX;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    ///zeichnet den weißen Kasten
    Rect r = Rect.fromLTWH(0, size.height-140, size.width, 140);
    Path path = Path();
    path.addRect(r);
    paint.style = PaintingStyle.fill;
    path.close();
    canvas.drawPath(path, paint);

    ///zeichnet den Fortschritt
    print("Zeichne Kasten");
    paint.color = this.color;
    Rect r2 = Rect.fromLTWH(0, size.height-140, posX, 140);
    Path p2 =Path();
    p2.addRect(r2);
    paint.style = PaintingStyle.fill;
    p2.close();
    canvas.drawPath(p2, paint);


    ///zeichnet die Index-Striche im Kasten
    paint.style = PaintingStyle.stroke;
    paint.color = Colors.black54;
    paint.strokeWidth = 2;
    for(double i = -1; i < size.width; i = i + size.width/10){
      Offset oS = Offset(i, size.height-140);
      Offset oE = Offset(i, size.height-120);
      canvas.drawLine(oS, oE, paint);

      oS = Offset(i, size.height);
      oE = Offset(i, size.height-20);
      canvas.drawLine(oS, oE, paint);
    }

  }

  @override
  bool shouldRepaint(CustomRateWorkoutPainter old) {
    //print("nue zeichnen: ${animation.value}");
    return animation.value != old.animation.value || color != old.color || backgroundColor != old.backgroundColor;
  }

}