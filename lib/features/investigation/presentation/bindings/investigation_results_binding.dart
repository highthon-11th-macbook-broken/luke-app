import 'package:get/get.dart';
import '../viewmodels/investigation_results_viewmodel.dart';

/// 조사 결과 목록 페이지의 의존성 주입을 관리하는 바인딩
class InvestigationResultsBinding extends Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut<InvestigationResultsViewModel>(
      () => InvestigationResultsViewModel(),
    );
  }
}