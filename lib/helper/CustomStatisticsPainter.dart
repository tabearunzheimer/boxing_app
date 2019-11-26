import 'package:flutter/material.dart';

class CustomStatisticPainter extends CustomPainter {
  final Animation<double> animation;
  final Color backgroundColor, color;
  final double posX;
  final List<int> werteY;
  final List<String> werteX;
  final anzahlWerteX;

  CustomStatisticPainter({
    this.animation,
    this.backgroundColor,
    this.color,
    this.posX,
    this.werteY,
    this.anzahlWerteX,
    this.werteX,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;


    paint.style = PaintingStyle.stroke;
    paint.color = Colors.black;
    paint.strokeWidth = 2;

    ///vertikale Linie
    Offset oS = Offset(30, size.height - 30);
    Offset oE = Offset(30, size.height - 280);
    canvas.drawLine(oS, oE, paint);
    //Pfeil
    oS = Offset(25, size.height - 270);
    oE = Offset(30, size.height - 280);
    canvas.drawLine(oS, oE, paint);
    oS = Offset(30, size.height - 280);
    oE = Offset(35, size.height - 270);
    canvas.drawLine(oS, oE, paint);

    ///horizonzale Linie
    oS = Offset(30, size.height - 30);
    oE = Offset(size.width - 30, size.height - 30);
    canvas.drawLine(oS, oE, paint);
    //Pfeil
    oS = Offset(size.width - 40, size.height - 25);
    oE = Offset(size.width - 30, size.height - 30);
    canvas.drawLine(oS, oE, paint);
    oS = Offset(size.width - 30, size.height - 30);
    oE = Offset(size.width - 40, size.height - 35);
    canvas.drawLine(oS, oE, paint);

    ///Pointer
    paint.color = this.color;
    paint.strokeWidth = 3;
    oS = Offset(posX, size.height - 300);
    oE = Offset(posX, size.height - 270);
    //Pfeil
    canvas.drawLine(oS, oE, paint);
    oS = Offset(posX, size.height - 270);
    oE = Offset(posX - 5, size.height - 280);
    canvas.drawLine(oS, oE, paint);
    oS = Offset(posX, size.height - 270);
    oE = Offset(posX + 5, size.height - 280);
    canvas.drawLine(oS, oE, paint);
    paint.color = Colors.black12;
    for (double i = size.height - 260; i < size.height - 30; i += 20) {
      oS = Offset(posX, i);
      oE = Offset(posX, i + 10);
      canvas.drawLine(oS, oE, paint);
    }

    int hoechsterWert = 0;
    for (int i = 0; i < this.werteY.length; i++) {
      hoechsterWert = (hoechsterWert >= werteY[i]) ? hoechsterWert : werteY[i];
    }

    ///Y-Achse
    int index = 5;
    for (double i = 60; i < size.height; i = i + (size.height - 90) / 5) {
      int text = (hoechsterWert / 5 * index).round();
      TextSpan span = new TextSpan(
          style: new TextStyle(color: Colors.black), text: text.toString());
      TextPainter tp = new TextPainter(
          text: span,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr);
      tp.layout();
      oS = Offset(10, i);
      tp.paint(canvas, oS);
      index--;
    }

    ///X-Achse
    index = 0;
    for (double i = 30; i < size.width - 30 && index < anzahlWerteX; i = i + (size.width - 60) / this.anzahlWerteX) {
      TextSpan span = new TextSpan(style: new TextStyle(color: Colors.black), text: this.werteX[index]);
      TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, new Offset(i, size.height-20));
      index++;
    }

    paint.color = Colors.black;
    index = 0;
    //laenge der y-achse
    double abstand = (size.height-90)/hoechsterWert;

    print(size.height);

    ///Y-Werte
    for (double i = 38; i < size.width - 30 && index < anzahlWerteX; i = i + (size.width - 60) / this.anzahlWerteX) {
      double helperzwei = this.werteY[index] * abstand;
      if (this.werteY[index] == 0){
        oS = Offset(i-5, size.height-30-helperzwei -5);
        oE = Offset(i+5, size.height-30-helperzwei +5);
        canvas.drawLine(oS, oE, paint);
        oS = Offset(i-5, size.height-30-helperzwei +5);
        oE = Offset(i+5, size.height-30-helperzwei -5);
      } else {
        oS = Offset(i-5, size.height-20-helperzwei -5);
        oE = Offset(i+5, size.height-20-helperzwei +5);
        canvas.drawLine(oS, oE, paint);
        oS = Offset(i-5, size.height-20-helperzwei +5);
        oE = Offset(i+5, size.height-20-helperzwei -5);
      }
      print("oS: ${helperzwei*abstand}, Y: ${this.werteY[index]} help: $helperzwei");

      canvas.drawLine(oS, oE, paint);
      index++;
    }


    }

  @override
  bool shouldRepaint(CustomStatisticPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
