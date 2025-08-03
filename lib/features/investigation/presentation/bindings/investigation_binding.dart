import 'package:get/get.dart';
import '../viewmodels/investigation_viewmodel.dart';
import '../../domain/usecases/submit_investigation_usecase.dart';
import '../../domain/usecases/get_categories_usecase.dart';

/// Investigation 페이지의 의존성 주입을 관리하는 Binding
class InvestigationBinding extends Bindings {
  @override
  void dependencies() {
    // ViewModel 등록 (UseCase들은 전역 DI에서 이미 등록됨)
    Get.lazyPut<InvestigationViewModel>(
      () => InvestigationViewModel(
        Get.find<SubmitInvestigationUseCase>(),
        Get.find<GetCategoriesUseCase>(),
      ),
    );
  }
}