import 'package:get/get.dart';
import '../../domain/entities/investigation_entity.dart';
import '../../domain/entities/investigation_result_entity.dart';
import '../../domain/usecases/submit_investigation_usecase.dart';
import '../../domain/usecases/get_categories_usecase.dart';

/// 정보 수집 조사 페이지의 상태를 관리하는 ViewModel
class InvestigationViewModel extends GetxController {
  final SubmitInvestigationUseCase _submitInvestigationUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;

  InvestigationViewModel(
    this._submitInvestigationUseCase,
    this._getCategoriesUseCase,
  );

  // 반응형 상태 변수들
  final selectedCategory = 'email'.obs; // 이메일로 고정
  final name = ''.obs; // 이름 필드 추가
  final email = ''.obs;
  final phoneNumber = ''.obs;
  final additionalInfoList = <String>[].obs;
  final isLoading = false.obs;
  final categories = <CategoryOption>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadCategories();
    // 초기값은 빈 값으로 설정 (placeholder만 표시)
    name.value = '';
    email.value = '';
    phoneNumber.value = '';
  }

  /// 카테고리 목록을 로드합니다
  Future<void> _loadCategories() async {
    try {
      final categoryList = await _getCategoriesUseCase();
      categories.value = categoryList;
    } catch (e) {
      Get.snackbar('오류', '카테고리를 불러오는데 실패했습니다.');
    }
  }

  /// 카테고리를 선택합니다
  void selectCategory(String categoryId) {
    selectedCategory.value = categoryId;
  }

  /// 이름을 업데이트합니다
  void updateName(String newName) {
    name.value = newName;
  }

  /// 이메일을 업데이트합니다
  void updateEmail(String newEmail) {
    email.value = newEmail;
  }

  /// 전화번호를 업데이트합니다
  void updatePhoneNumber(String newPhoneNumber) {
    phoneNumber.value = newPhoneNumber;
  }

  /// 추가 정보를 추가합니다
  void addAdditionalInfo(String info) {
    if (info.isNotEmpty && !additionalInfoList.contains(info)) {
      additionalInfoList.add(info);
    }
  }

  /// 추가 정보를 제거합니다
  void removeAdditionalInfo(int index) {
    if (index >= 0 && index < additionalInfoList.length) {
      additionalInfoList.removeAt(index);
    }
  }

  /// 선택된 카테고리의 표시명을 반환합니다
  String get selectedCategoryDisplayName {
    final category = categories.firstWhereOrNull(
      (cat) => cat.id == selectedCategory.value,
    );
    return category?.displayName ?? '카테고리';
  }

  /// 폼 유효성을 검사합니다
  bool get isFormValid {
    return name.value.isNotEmpty &&
           email.value.isNotEmpty && 
           phoneNumber.value.isNotEmpty;
  }

  /// 정보 수집을 완료합니다
  Future<void> submitInvestigation() async {
    if (!isFormValid) {
      Get.snackbar('알림', '모든 필수 정보를 입력해주세요.');
      return;
    }

    isLoading.value = true;

    try {
      final investigationInfo = InvestigationInfo(
        category: selectedCategory.value,
        name: name.value,
        email: email.value,
        phoneNumber: phoneNumber.value,
        additionalInfo: additionalInfoList.toList(),
      );

      final requestId = await _submitInvestigationUseCase(investigationInfo);

      // 결과 페이지로 이동
      final result = InvestigationResult(
        resultId: DateTime.now().millisecondsSinceEpoch.toString(),
        category: selectedCategoryDisplayName,
        name: name.value, // 이름 필드 추가
        email: email.value,
        phoneNumber: phoneNumber.value,
        additionalInfo: additionalInfoList.toList(),
        submittedAt: DateTime.now(),
        status: 'submitted',
        requestId: requestId, // API 요청 ID 추가
      );
      
      Get.toNamed('/investigation-result', arguments: result);
      _resetForm();
    } catch (e) {
      print('조사 정보 제출 실패: $e');
      Get.snackbar('오류', '서버 연결에 실패했습니다. 인터넷 연결을 확인하고 다시 시도해주세요.');
    } finally {
      isLoading.value = false;
    }
  }

  /// 폼을 초기화합니다
  void _resetForm() {
    selectedCategory.value = 'email';
    name.value = '';
    email.value = '';
    phoneNumber.value = '';
    additionalInfoList.clear();
  }
}