import 'package:get/get.dart';
import '../../domain/usecases/get_user_profile_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../viewmodels/profile_viewmodel.dart';

/// 프로필 페이지의 의존성 주입을 관리하는 바인딩
class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // UseCases 등록
    Get.lazyPut<GetUserProfileUseCase>(
      () => GetUserProfileUseCase(),
    );
    
    Get.lazyPut<LogoutUseCase>(
      () => LogoutUseCase(),
    );
    
    // ViewModel 등록
    Get.lazyPut<ProfileViewModel>(
      () => ProfileViewModel(
        Get.find<GetUserProfileUseCase>(),
        Get.find<LogoutUseCase>(),
      ),
    );
  }
}