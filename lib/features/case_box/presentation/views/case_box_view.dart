import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/util/style/colors.dart';
import '../../../../core/util/style/typography.dart';
import '../../../../core/widgets/common/custom_bottom_navigation.dart';
import '../../../../core/widgets/common/filter_button.dart';
import '../../../../core/widgets/common/case_card.dart';
import '../viewmodels/case_box_viewmodel.dart';

class CaseBoxView extends GetView<CaseBoxViewModel> {
  const CaseBoxView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // 상단 Safe Area
          SizedBox(height: MediaQuery.of(context).padding.top),
            // 상단 영역 (로고 + 알림)
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // LUKE 로고
                  SvgPicture.asset(
                    'lib/assets/icons/logo_blue.svg',
                    width: 123,
                    height: 40,
                  ),
                  // 알림 아이콘
                  GestureDetector(
                    onTap: controller.onNotificationTap,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: SvgPicture.asset(
                        'lib/assets/icons/alarm.svg',
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(AppColors.logoBlue, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // 제목
            Container(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              alignment: Alignment.centerLeft,
              child: Text(
                '사건 카드 리스트',
                style: AppTypography.heading2.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            
            // 필터 버튼들
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  Obx(() => FilterButton(
                    label: '위험도',
                    width: 92,
                    isSelected: controller.selectedRiskFilter.value == 1,
                    onTap: controller.onRiskFilterTap,
                  )),
                  const SizedBox(width: 10),
                  Obx(() => FilterButton(
                    label: '날짜',
                    width: 80,
                    isSelected: controller.selectedDateFilter.value == 1,
                    onTap: controller.onDateFilterTap,
                  )),
                  const SizedBox(width: 10),
                  Obx(() => FilterButton(
                    label: '유형',
                    width: 80,
                    isSelected: controller.selectedTypeFilter.value == 1,
                    onTap: controller.onTypeFilterTap,
                  )),
                ],
              ),
            ),
            
            // 정렬 정보 텍스트
            Container(
              padding: const EdgeInsets.fromLTRB(30, 10, 20, 0), // 하단 패딩 제거
              alignment: Alignment.centerLeft,
              child: Text(
                '최근날짜 순\n위험도 높은 순',
                style: AppTypography.body2.copyWith(
                  fontSize: 14,
                  color: AppColors.iconInactive,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
              ),
            ),
            
            // 사건 카드 리스트
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  
                  return SingleChildScrollView(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // 카드 개수에 따른 동적 높이 계산
                        final cardCount = controller.filteredCases.length.clamp(0, 6);
                        final rowsNeeded = (cardCount / 2).ceil();
                        final dynamicHeight = rowsNeeded * 209.0 + 150; // 카드 높이 + 여유 공간
                        
                                                return Container(
                          height: dynamicHeight + 200, // 음수 위치를 위한 추가 높이
                          margin: const EdgeInsets.only(top: 60), // 상단 여백 추가
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: List.generate(
                              cardCount,
                              (index) {
                                final caseEntity = controller.filteredCases[index];
                                
                                // 사선 배치를 위한 위치 계산
                                final isLeftColumn = index % 2 == 0;
                                final rowIndex = index ~/ 2;
                                
                                double left, top;
                                if (isLeftColumn) {
                                  // 왼쪽 열 (더 위로 올림)
                                  left = 0;
                                  top = -55 + (rowIndex * 209.0);
                                } else {
                                  // 오른쪽 열 (첫 번째 카드는 텍스트 옆에, 나머지는 아래로)
                                  left = MediaQuery.of(context).size.width - 40 - 165;
                                  if (rowIndex == 0) {
                                    // 첫 번째 카드는 텍스트 옆에 위치
                                    top = -100 + (rowIndex * 209.0);
                                  } else {
                                    // 나머지 카드들은 기존 위치
                                    top = -80 + (rowIndex * 209.0);
                                  }
                                }
                                
                                return Positioned(
                                  left: left,
                                  top: top,
                                  child: CaseCard(
                                    caseEntity: caseEntity,
                                    cardIndex: index,
                                    onDetailTap: () => controller.onCaseDetailTap(caseEntity),
                                    onActionTap: () => controller.onCaseActionTap(caseEntity),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            ),
            
            // 하단 네비게이션 바
            CustomBottomNavigation(
              selectedIndex: 0, // 박스 아이콘이 선택된 상태
              onItemTap: controller.onNavItemTap,
            ),
          ],
      ),
    );
  }
}