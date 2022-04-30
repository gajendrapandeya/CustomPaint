import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    );
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 200.0,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: CustomPaint(
                  painter: Ring(
                      progress: _controller.value,
                      defaultColor: Colors.grey,
                      fillColor: Colors.red),
                ),
              ),
            ),
            Positioned.fill(
              child: Icon(
                Icons.check,
                color: _controller.value < 1.0 ? Colors.black : Colors.green,
                size: 48.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Ring extends CustomPainter {
  final double progress;
  final Color defaultColor;
  final Color fillColor;

  Ring({
    required this.progress,
    required this.defaultColor,
    required this.fillColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width / 15;
    final center = size.width / 2;
    final radius = (size.width - strokeWidth) / 2;
    final innerPaint = Paint()
      ..color = defaultColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(Offset(center, center), radius, innerPaint);

    final outerPaint = Paint()
      ..color = fillColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
        Rect.fromCircle(center: Offset(center, center), radius: radius),
        -pi / 2,
        progress * pi * 2,
        false,
        outerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
