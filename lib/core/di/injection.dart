import 'package:get/get.dart';
import '../../features/auth/domain/usecases/google_sign_in_usecase.dart';
import '../../features/auth/data/services/auth_api_service.dart';
import '../../features/profile/domain/usecases/get_user_profile_usecase.dart';
import '../../features/profile/domain/usecases/logout_usecase.dart';
import '../../features/investigation/domain/usecases/submit_investigation_usecase.dart';
import '../../features/investigation/domain/usecases/get_categories_usecase.dart';
import '../../features/investigation/domain/usecases/get_detection_status_usecase.dart';
import '../../features/investigation/data/services/detection_api_service.dart';

/// 의존성 주입 설정
class DependencyInjection {
  
  static void init() {
    // Auth services and use cases
    Get.lazyPut<AuthApiService>(() => AuthApiService());
    Get.lazyPut<GoogleSignInUseCase>(() => GoogleSignInUseCase(Get.find()));
    
    // Profile use cases
    Get.lazyPut<GetUserProfileUseCase>(() => GetUserProfileUseCase());
    Get.lazyPut<LogoutUseCase>(() => LogoutUseCase());
    
    // Investigation services and use cases
    Get.lazyPut<DetectionApiService>(() => DetectionApiService());
    Get.lazyPut<SubmitInvestigationUseCase>(() => SubmitInvestigationUseCase(Get.find()));
    Get.lazyPut<GetCategoriesUseCase>(() => GetCategoriesUseCase());
    Get.lazyPut<GetDetectionStatusUseCase>(() => GetDetectionStatusUseCase(Get.find()));
  }
}