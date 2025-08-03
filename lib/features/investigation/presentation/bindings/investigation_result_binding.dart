import 'package:get/get.dart';
import '../viewmodels/investigation_result_viewmodel.dart';

/// Investigation Result 페이지의 의존성 주입을 관리하는 Binding
class InvestigationResultBinding extends Bindings {
  @override
  void dependencies() {
    // ViewModel 등록
    Get.lazyPut<InvestigationResultViewModel>(
      () => InvestigationResultViewModel(Get.find()),
    );
  }
}