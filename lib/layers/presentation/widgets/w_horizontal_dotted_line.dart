import 'package:flutter/material.dart';

class HorizontalDottedLine extends StatelessWidget {
  const HorizontalDottedLine({super.key, required this.mWidth});
  final double mWidth;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size:  Size(mWidth, 1), // 가로줄의 너비와 높이를 설정
      painter: DottedLinePainter(), // 점선 가로줄을 그리는 커스텀 페인터
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey // 점선의 색상을 설정
      ..strokeWidth = 1; // 점선의 두께를 설정
    const dashWidth = 5;
    const dashSpace = 5;
    double currentX = 0;
    while (currentX < size.width) {
      canvas.drawLine(
        Offset(currentX, 0),
        Offset(currentX + dashWidth, 0),
        paint,
      );
      currentX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}