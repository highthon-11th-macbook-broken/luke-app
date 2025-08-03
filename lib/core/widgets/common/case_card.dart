import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../features/case_box/domain/entities/case_entity.dart';

/// 사건 카드 컴포넌트
class CaseCard extends StatelessWidget {
  final CaseEntity caseEntity;
  final int cardIndex;
  final VoidCallback? onDetailTap;
  final VoidCallback? onActionTap;

  const CaseCard({
    super.key,
    required this.caseEntity,
    required this.cardIndex,
    this.onDetailTap,
    this.onActionTap,
  });

  // Figma 디자인에 따른 카드 색상 정의
  Color _getCardColor() {
    switch (cardIndex % 6) {
      case 0: return const Color(0xFFF1F0E4); // 베이지
      case 1: return const Color(0xFFBCA88D); // 갈색
      case 2: return const Color(0xFF223A5E); // 남색
      case 3: return const Color(0xFFBCA88D); // 갈색
      case 4: return const Color(0xFF16294C); // 진한 남색
      case 5: return const Color(0xFF223A5E); // 남색
      default: return const Color(0xFFF1F0E4);
    }
  }

  Color _getTextColor() {
    final cardColor = _getCardColor();
    // 어두운 카드는 흰색 텍스트, 밝은 카드는 어두운 텍스트
    return (cardColor.computeLuminance() < 0.5) 
        ? Colors.white 
        : const Color(0xFF16294C);
  }

  String _getFirstLineText() {
    switch (cardIndex % 6) {
      case 0: return '042-518-2153';
      case 1: return '박하은';
      case 2: return '박하은';
      case 3: return '박하은';
      case 4: return '042-518-2153';
      case 5: return '042-518-2153';
      default: return '박하은';
    }
  }

  String _getSecondLineText() {
    switch (cardIndex % 6) {
      case 0: return '';  // 첫 번째 카드는 한 줄만
      case 1: return '';  // 두 번째 카드도 한 줄만
      case 2: return '제주도 제주시 진군남....';
      case 3: return '042-518-2153';
      case 4: return '042-518-2153';
      case 5: return '';  // 마지막 카드는 한 줄만
      default: return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = _getCardColor();
    final textColor = _getTextColor();
    
    return SizedBox(
      width: 165,
      height: 189,
      child: Stack(
        children: [
          // 카드 배경 (file.svg)
          SvgPicture.asset(
            'lib/assets/icons/file.svg',
            width: 165,
            height: 189,
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              cardColor,
              BlendMode.srcIn,
            ),
          ),
          // 카드 내용
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 위험도 표시
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFFDE0707),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '위험도 ${caseEntity.riskLevel.toStringAsFixed(1)}%',
                      style: const TextStyle(
                        fontFamily: 'Freesentation',
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF16294C),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 25),
                
                // 첫 번째 줄 텍스트 (카드별로 다름)
                Text(
                  _getFirstLineText(),
                  style: TextStyle(
                    fontFamily: 'Freesentation',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                
                const SizedBox(height: 4),
                
                // 두 번째 줄 텍스트 (카드별로 다름) 
                if (_getSecondLineText().isNotEmpty) ...[
                  Text(
                    _getSecondLineText(),
                    style: TextStyle(
                      fontFamily: 'Freesentation',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
                
                // 날짜
                Text(
                  caseEntity.date,
                  style: TextStyle(
                    fontFamily: 'Freesentation',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                  ),
                ),
                
                const Spacer(),
                
                // 하단 버튼 영역
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (cardIndex == 4) // 특정 카드에만 "자세히 보기"
                      GestureDetector(
                        onTap: onDetailTap,
                        child: Text(
                          '자세히 보기',
                          style: TextStyle(
                            fontFamily: 'Freesentation',
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            color: textColor,
                          ),
                        ),
                      )
                    else
                      // 조치하기 + 화살표를 붙여서 배치
                      GestureDetector(
                        onTap: onActionTap,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '조치하기',
                              style: TextStyle(
                                fontFamily: 'Freesentation',
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.keyboard_arrow_right,
                              size: 10,
                              color: textColor,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}