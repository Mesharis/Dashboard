import 'package:get/get.dart';

import '../middlewares/auth_middleware.dart';
import '../modules/carousel/bindings/carousel_binding.dart';
import '../modules/carousel/views/carousel_view.dart';
import '../modules/category/bindings/category_binding.dart';
import '../modules/category/views/category_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/doctors/bindings/doctors_binding.dart';
import '../modules/doctors/views/doctors_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/layout/bindings/layout_binding.dart';
import '../modules/layout/views/layout_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/top_rated_doctor/bindings/top_rated_doctor_binding.dart';
import '../modules/top_rated_doctor/views/top_rated_doctor_view.dart';
import '../modules/transaction/bindings/transaction_binding.dart';
import '../modules/transaction/views/transaction_view.dart';
import '../modules/users/bindings/users_binding.dart';
import '../modules/users/views/users_view.dart';
import '../modules/withdrawal/bindings/withdrawal_binding.dart';
import '../modules/withdrawal/views/withdrawal_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.USERS,
      page: () => UsersView(),
      binding: UsersBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION,
      page: () => const TransactionView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: _Paths.WITHDRAWAL,
      page: () => const WithdrawalView(),
      binding: WithdrawalBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => const CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
        name: _Paths.HOME,
        page: () => LayoutView(),
        binding: LayoutBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
      name: _Paths.DOCTORS,
      page: () => const DoctorsView(),
      binding: DoctorsBinding(),
    ),
    GetPage(
      name: _Paths.TOP_RATED_DOCTOR,
      page: () => const TopRatedDoctorView(),
      binding: TopRatedDoctorBinding(),
    ),
    GetPage(
      name: _Paths.CAROUSEL,
      page: () => const CarouselView(),
      binding: CarouselBinding(),
    ),
  ];
}
