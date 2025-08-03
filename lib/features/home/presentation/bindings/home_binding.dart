import 'package:get/get.dart';
import '../viewmodels/home_viewmodel.dart';

/// 홈 화면의 의존성 주입을 담당하는 Binding
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeViewModel>(
      () => HomeViewModel(),
    );
  }
}