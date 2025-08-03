import 'package:get/get.dart';
import '../viewmodels/case_box_viewmodel.dart';

/// 사건박스 화면의 의존성 주입을 담당하는 Binding
class CaseBoxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CaseBoxViewModel>(
      () => CaseBoxViewModel(),
    );
  }
}