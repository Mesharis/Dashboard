import 'package:get/get.dart';
import 'package:hello_doctor_admin_dashboard/app/modules/carousel/controllers/carousel_controller.dart';
import 'package:hello_doctor_admin_dashboard/app/modules/category/controllers/category_controller.dart';
import 'package:hello_doctor_admin_dashboard/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:hello_doctor_admin_dashboard/app/modules/doctors/controllers/doctors_controller.dart';
import 'package:hello_doctor_admin_dashboard/app/modules/settings/controllers/settings_controller.dart';
import 'package:hello_doctor_admin_dashboard/app/modules/top_rated_doctor/controllers/top_rated_doctor_controller.dart';
import 'package:hello_doctor_admin_dashboard/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:hello_doctor_admin_dashboard/app/modules/users/controllers/users_controller.dart';
import 'package:hello_doctor_admin_dashboard/app/modules/withdrawal/controllers/withdrawal_controller.dart';

import '../controllers/layout_controller.dart';

class LayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LayoutController>(
      () => LayoutController(),
    );
    Get.put(DashboardController());
    Get.lazyPut<UsersController>(
      () => UsersController(),
    );
    Get.lazyPut<DoctorsController>(
      () => DoctorsController(),
    );
    Get.lazyPut<CategoryController>(
      () => CategoryController(),
    );
    Get.lazyPut<SettingsController>(
      () => SettingsController(),
    );
    Get.lazyPut<WithdrawalController>(
      () => WithdrawalController(),
    );
    Get.lazyPut<TransactionController>(
      () => TransactionController(),
    );
    Get.lazyPut<TopRatedDoctorController>(
      () => TopRatedDoctorController(),
    );
    Get.lazyPut<CarouselController>(
      () => CarouselController(),
    );
  }
}
