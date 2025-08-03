import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/util/style/theme.dart';
import 'features/splash/presentation/views/splash_view.dart';
import 'features/splash/presentation/bindings/splash_binding.dart';
import 'features/auth/presentation/views/login_view.dart';
import 'features/auth/presentation/bindings/login_binding.dart';
import 'features/home/presentation/views/home_view.dart';
import 'features/home/presentation/bindings/home_binding.dart';
import 'features/case_box/presentation/views/case_box_view.dart';
import 'features/case_box/presentation/bindings/case_box_binding.dart';
import 'features/investigation/presentation/views/investigation_view.dart';
import 'features/investigation/presentation/bindings/investigation_binding.dart';
import 'features/investigation/presentation/views/investigation_result_view.dart';
import 'features/investigation/presentation/bindings/investigation_result_binding.dart';
import 'features/investigation/presentation/views/investigation_results_view.dart';
import 'features/investigation/presentation/bindings/investigation_results_binding.dart';
import 'features/profile/presentation/views/profile_view.dart';
import 'features/profile/presentation/bindings/profile_binding.dart';
import 'core/di/injection.dart';

void main() {
  // 의존성 주입 초기화
  DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Luke App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      defaultTransition: Transition.noTransition,
      transitionDuration: Duration.zero,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashView(),
          binding: SplashBinding(),
        ),
        GetPage(
          name: '/login',
          page: () => const LoginView(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: '/home',
          page: () => const HomeView(),
          binding: HomeBinding(),
          transition: Transition.noTransition,
          transitionDuration: Duration.zero,
        ),

        GetPage(
          name: '/case-box',
          page: () => const CaseBoxView(),
          binding: CaseBoxBinding(),
          transition: Transition.noTransition,
          transitionDuration: Duration.zero,
        ),

        GetPage(
          name: '/investigation',
          page: () => const InvestigationView(),
          binding: InvestigationBinding(),
          transition: Transition.noTransition,
          transitionDuration: Duration.zero,
        ),

                  GetPage(
            name: '/investigation-result',
            page: () => const InvestigationResultView(),
            binding: InvestigationResultBinding(),
            transition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 300),
          ),
          GetPage(
            name: '/investigation-results',
            page: () => const InvestigationResultsView(),
            binding: InvestigationResultsBinding(),
            transition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 300),
          ),
        
        GetPage(
          name: '/profile',
          page: () => const ProfileView(),
          binding: ProfileBinding(),
          transition: Transition.noTransition,
          transitionDuration: Duration.zero,
        ),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
