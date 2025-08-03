import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/util/style/colors.dart';
import '../../../../core/util/style/typography.dart';
import '../../../../core/widgets/common/custom_text_field.dart';
import '../../../../core/widgets/common/custom_bottom_navigation.dart';
import '../viewmodels/investigation_viewmodel.dart';

/// 정보 수집 조사 페이지
class InvestigationView extends StatelessWidget {
  const InvestigationView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.find<InvestigationViewModel>();
    
    return Scaffold(
      backgroundColor: AppColors.white,
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
                // LUKE 로고 (Figma: x=20, y=66에서 상단바 46px 제외하면 20px)
                SvgPicture.asset(
                  'lib/assets/icons/logo_blue.svg',
                  width: 123,
                  height: 40,
                ),
                // 알림 아이콘 (Figma: x=338, y=70)
                GestureDetector(
                  onTap: () {
                    Get.snackbar('알림', '알림 기능은 준비 중입니다.');
                  },
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
          
          // 메인 컨텐츠
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 컨텐츠를 위로 올리기 위해 간격 줄임
                  const SizedBox(height: 120),
                    
                    // 제목
                    _buildTitle(),
                    
                    // Figma: 제목 y=272+height=56=328, 입력박스 y=363, 따라서 35px 간격
                    const SizedBox(height: 35),
                    
                    // 이름 입력
                    _buildNameInput(viewModel),
                    
                    const SizedBox(height: 20),
                    
                    // 이메일 입력
                    _buildEmailInput(viewModel),
                    
                    const SizedBox(height: 20),
                    
                    // 전화번호 입력
                    _buildPhoneInput(viewModel),
                    
                    // Figma: 전화번호 y=423+height=45=468, 정보추가 y=478, 따라서 10px 간격
                    const SizedBox(height: 10),
                    
                    // 정보 추가하기 버튼
                    _buildAddInfoButton(),
                    
                    // Figma: 정보추가 y=478+height=19=497, 완료버튼 y=527, 따라서 30px 간격
                    const SizedBox(height: 30),
                    
                    // 추가된 정보 목록
                    _buildAdditionalInfoList(viewModel),
                    
                    // 정보 수정 완료 버튼
                    _buildSubmitButton(viewModel),
                    const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(
        selectedIndex: 2, // 검색 탭 활성화
        onItemTap: (index) {
          switch (index) {
            case 0:
              Get.toNamed('/case-box');
              break;
            case 1:
              Get.toNamed('/home');
              break;
            case 2:
              // 현재 페이지
              break;
            case 3:
              Get.toNamed('/profile');
              break;
          }
        },
      ),
    );
  }



  /// 제목 위젯
  Widget _buildTitle() {
    return Text(
      '조사하고 싶은 정보를\n입력해주세요!',
      style: AppTypography.heading2.copyWith(
        color: AppColors.textDark,
        fontWeight: FontWeight.w600,
        height: 1.4,
      ),
      textAlign: TextAlign.center,
    );
  }

  /// 이름 입력 필드
  Widget _buildNameInput(InvestigationViewModel viewModel) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFFD1D1D7),
          width: 1.5,
        ),
      ),
      child: TextFormField(
        onChanged: viewModel.updateName,
        keyboardType: TextInputType.name,
        style: AppTypography.body1.copyWith(
          color: const Color(0xFF49484A),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: '이름을 입력해주세요',
          hintStyle: AppTypography.body1.copyWith(
            color: const Color(0xFF49484A).withOpacity(0.6),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        ),
      ),
    );
  }



  /// 이메일 입력 필드
  Widget _buildEmailInput(InvestigationViewModel viewModel) {
    // TextEditingController를 여기서 생성하면 빌드할 때마다 새로 생성됨
    // 대신 ViewModel에서 관리하거나 StatefulWidget을 사용해야 함
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFFD1D1D7),
          width: 1.5,
        ),
      ),
      child: TextFormField(
        onChanged: viewModel.updateEmail,
        keyboardType: TextInputType.emailAddress,
        style: AppTypography.body1.copyWith(
          color: const Color(0xFF49484A),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'D2308@e-mirim.hs.kr',
          hintStyle: AppTypography.body1.copyWith(
            color: const Color(0xFF49484A).withOpacity(0.6), // 흐리게 표시
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        ),
      ),
    );
  }



  /// 전화번호 입력 필드
  Widget _buildPhoneInput(InvestigationViewModel viewModel) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFFD1D1D7),
          width: 1.5,
        ),
      ),
      child: TextFormField(
        onChanged: viewModel.updatePhoneNumber,
        keyboardType: TextInputType.phone,
        style: AppTypography.body1.copyWith(
          color: const Color(0xFF49484A),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: '010-1234-1234',
          hintStyle: AppTypography.body1.copyWith(
            color: const Color(0xFF49484A).withOpacity(0.6), // 흐리게 표시
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        ),
      ),
    );
  }

  /// 정보 추가하기 버튼 (Figma: x=150, y=478)
  Widget _buildAddInfoButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 130), // Figma x=150에서 좌측 패딩 20px 제외하면 130px
        child: GestureDetector(
          onTap: () => _showAddInfoDialog(),
          child: Text(
            '정보 추가하기 +',
            style: AppTypography.body1.copyWith(
              color: const Color(0xFF8E8E93),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  /// 추가된 정보 목록
  Widget _buildAdditionalInfoList(InvestigationViewModel viewModel) {
    return Obx(() {
      if (viewModel.additionalInfoList.isEmpty) {
        return const SizedBox.shrink();
      }
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            '추가 정보',
            style: AppTypography.body1.copyWith(
              color: AppColors.textDark,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          ...viewModel.additionalInfoList.asMap().entries.map((entry) {
            final index = entry.key;
            final info = entry.value;
            
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.profileBackground,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      info,
                      style: AppTypography.body2.copyWith(
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => viewModel.removeAdditionalInfo(index),
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: AppColors.iconInactive,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          const SizedBox(height: 20),
        ],
      );
    });
  }

  /// 정보 수정 완료 버튼 (Figma 디자인)
  Widget _buildSubmitButton(InvestigationViewModel viewModel) {
    return Obx(() => Container(
      width: double.infinity,
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      child: ElevatedButton(
        onPressed: viewModel.isLoading.value ? null : viewModel.submitInvestigation,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF223A5E), // Figma 색상
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // 둥근 모서리
            side: const BorderSide(
              color: Color(0xFF16294C),
              width: 1.5,
            ),
          ),
        ),
        child: viewModel.isLoading.value
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                '정보 수정 완료',
                style: AppTypography.body1.copyWith(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    ));
  }



  /// 정보 추가 다이얼로그
  void _showAddInfoDialog() {
    final textController = TextEditingController();
    
    Get.dialog(
      AlertDialog(
        title: Text('정보 추가', style: AppTypography.heading3),
        content: CustomTextField(
          controller: textController,
          hintText: '추가할 정보를 입력하세요',
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('취소'),
          ),
          TextButton(
            onPressed: () {
              final viewModel = Get.find<InvestigationViewModel>();
              viewModel.addAdditionalInfo(textController.text.trim());
              Get.back();
            },
            child: Text('추가'),
          ),
        ],
      ),
    );
  }
}