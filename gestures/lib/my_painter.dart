import 'package:flutter/widgets.dart';
import 'package:flutter/semantics.dart';

// https://api.flutter.dev/flutter/rendering/CustomPainter-class.html
class MyPainter extends CustomPainter {
  var scaleFactor;
  var x;
  var y;

  MyPainter(scaleFactor, x, y) : super() {
    this.scaleFactor = scaleFactor;
    this.x = x;
    this.y = y;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var posX = 2 * x / size.width;
    var posY = 2 * y / size.height;
    //debugPrint("posX" + posX.toString());
    var rect = Offset.zero & size;
    var gradient = RadialGradient(
      center: Alignment(posX, posY),
      radius: 0.2 * scaleFactor,
      colors: [const Color(0xFFFFFF00), const Color(0xFF0099FF)],
      stops: [0.4, 1.0],
    );
    canvas.drawRect(
      rect,
      Paint()..shader = gradient.createShader(rect),
    );
  }

  // Since this Sky painter has no fields, it always paints
  // the same thing and semantics information is the same.
  // Therefore we return false here. If we had fields (set
  // from the constructor) then we would return true if any
  // of them differed from the same fields on the oldDelegate.
  @override
  bool shouldRepaint(MyPainter oldDelegate) => true;
  @override
  bool shouldRebuildSemantics(MyPainter oldDelegate) => false;
}