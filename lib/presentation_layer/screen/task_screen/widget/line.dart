import 'dart:async';
import 'package:flutter/material.dart';

class TimeLine extends StatefulWidget {
  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start a timer to update the UI every second
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TimeLinePainter(),
      child: Container(),
    );
  }
}

class TimeLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    final time = DateTime.now();
    final minute = time.minute;
    final hour = time.hour;

    final x = size.width * (minute / 60);
    final y = size.height / 2;

    canvas.drawLine(Offset(0, y), Offset(x, y), linePaint);

    final hourText = TextPainter(
      text: TextSpan(
        text: hour.toString(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    hourText.layout();
    hourText.paint(
        canvas, Offset(x - hourText.width / 2, y - hourText.height - 4));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
