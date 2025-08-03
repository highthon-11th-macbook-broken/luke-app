import 'package:flutter/material.dart';

/// 종이 접힌 모양의 카드를 그리는 CustomPainter
class PaperCardPainter extends CustomPainter {
  final Color backgroundColor;

  const PaperCardPainter({required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final path = Path();

    // Figma SVG path를 Flutter Path로 변환
    // 크기를 165x189로 정규화
    final double scaleX = size.width / 165;
    final double scaleY = size.height / 189;

    // SVG path 데이터를 바탕으로 경로 생성
    path.moveTo(11.3143 * scaleX, 0);
    
    // 왼쪽 상단 모서리 (둥근 모서리)
    path.quadraticBezierTo(0, 0, 0, 12.2835 * scaleY);
    
    // 왼쪽 세로선
    path.lineTo(0, 177.875 * scaleY);
    
    // 왼쪽 하단 모서리
    path.quadraticBezierTo(0, size.height, 11.3143 * scaleX, size.height);
    
    // 하단 가로선
    path.lineTo(153.921 * scaleX, size.height);
    
    // 오른쪽 하단 모서리
    path.quadraticBezierTo(size.width, size.height, size.width, 177.875 * scaleY);
    
    // 오른쪽 세로선 (접힌 부분까지)
    path.lineTo(size.width, 24.8032 * scaleY);
    
    // 접힌 부분 - 오른쪽 상단
    path.lineTo(155.1 * scaleX, 15.5905 * scaleY);
    path.lineTo(111.964 * scaleX, 15.5905 * scaleY);
    path.lineTo(106.779 * scaleX, 12.2835 * scaleY);
    path.lineTo(94.2857 * scaleX, 0);
    
    // 상단 가로선으로 돌아가기
    path.lineTo(11.3143 * scaleX, 0);
    
    path.close();

    canvas.drawPath(path, paint);

    // 접힌 부분의 그림자나 선을 추가할 수 있음
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final shadowPath = Path();
    shadowPath.moveTo(106.779 * scaleX, 12.2835 * scaleY);
    shadowPath.lineTo(155.1 * scaleX, 15.5905 * scaleY);
    shadowPath.lineTo(size.width, 24.8032 * scaleY);

    canvas.drawPath(shadowPath, shadowPaint);
  }

  @override
  bool shouldRepaint(PaperCardPainter oldDelegate) {
    return oldDelegate.backgroundColor != backgroundColor;
  }
}