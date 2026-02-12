import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prog_lazy_f/movieCardW/movieCardDetailsModel.dart'
    show MovieCardDetailsModel;
import 'package:prog_lazy_f/universalInherit/universalInheritNotifier.dart'
    show UniversalInheritNitifier;

class CircularProgressCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = UniversalInheritNitifier.watch<MovieCardDetailsModel>(
      context,
    );
    var statistickInPercent = model?.movieDetails?.voteAverage ?? 0;
    statistickInPercent = statistickInPercent * 10;
    return Center(
      child: Container(
        width: 60,
        height: 60,
        child: RadialPersentWidget(
          percentInDouble: statistickInPercent / 100,
          backCircleColor: const Color.fromARGB(221, 37, 34, 34),
          customChild: Text(
            '${statistickInPercent.toStringAsFixed(0)}%',
            style: TextStyle(
              color: const Color.fromARGB(255, 225, 224, 224),
              fontSize: 14,
            ),
          ),

          lineWidth: 6,
          lowerArcColor: Colors.green,
          upperArcColor: Colors.yellow,
        ),
      ),
    );
  }
}

class RadialPersentWidget extends StatelessWidget {
  final Widget customChild;
  final double percentInDouble;
  final Color backCircleColor;
  final Color upperArcColor;
  final Color lowerArcColor;
  final double lineWidth;
  const RadialPersentWidget({
    super.key,
    required this.percentInDouble,
    required this.backCircleColor,
    required this.customChild,
    required this.lineWidth,
    required this.lowerArcColor,
    required this.upperArcColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox.expand(
          child: CustomPaint(
            painter: MyPainter(
              customChild: customChild,
              percentInDouble: percentInDouble,
              backCircleColor: backCircleColor,
              upperArcColor: upperArcColor,
              lowerArcColor: lowerArcColor,
              lineWidth: lineWidth,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(11),
          child: Center(child: customChild),
        ),
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  final Widget customChild;
  final double percentInDouble;
  final Color backCircleColor;
  final Color upperArcColor;
  final Color lowerArcColor;
  final double lineWidth;

  MyPainter({
    required this.customChild,
    required this.backCircleColor,
    required this.percentInDouble,
    required this.upperArcColor,
    required this.lineWidth,
    required this.lowerArcColor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Rect arcRect = calculateArcsRect(size);

    createBackCircle(canvas, size);
    createUpperArc(canvas, arcRect);
    createLowerArc(canvas, arcRect);
  }

  void createLowerArc(Canvas canvas, Rect arcRect) {
    final lowerArc = Paint();
    lowerArc.color = lowerArcColor;
    lowerArc.style = PaintingStyle.stroke;
    lowerArc.strokeWidth = lineWidth;
    lowerArc.strokeCap = StrokeCap.round;
    canvas.drawArc(
      arcRect,
      -pi / 2,
      (pi * 2) * percentInDouble,
      false,
      lowerArc,
    );
  }

  void createUpperArc(Canvas canvas, Rect arcRect) {
    final upperArc = Paint();
    upperArc.color = upperArcColor;
    upperArc.style = PaintingStyle.stroke;
    upperArc.strokeWidth = lineWidth;
    canvas.drawArc(
      arcRect,
      pi * 2 * percentInDouble - (pi / 2),
      (pi * 2) * (1.0 - percentInDouble),
      false,
      upperArc,
    );
  }

  void createBackCircle(Canvas canvas, Size size) {
    final backCircle = Paint();
    backCircle.color = backCircleColor;
    backCircle.style = PaintingStyle.stroke;
    canvas.drawOval(Offset.zero & size, backCircle);
  }

  Rect calculateArcsRect(Size size) {
    final marginLine = 3;
    final offset = lineWidth / 2 + marginLine;
    final arcRect =
        Offset(offset, offset) &
        Size(size.width - offset * 2, size.height - offset * 2);
    return arcRect;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
