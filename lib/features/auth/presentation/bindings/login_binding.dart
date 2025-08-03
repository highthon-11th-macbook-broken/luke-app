import 'package:get/get.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginViewModel>(() => LoginViewModel());
  }
} 