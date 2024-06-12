import 'package:get/get.dart';
import 'package:hello_doctor_admin_dashboard/app/models/dashboard_model.dart';
import 'package:hello_doctor_admin_dashboard/app/modules/home/controllers/home_controller.dart';
import 'package:hello_doctor_admin_dashboard/app/routes/app_pages.dart';
import 'package:hello_doctor_admin_dashboard/app/services/auth_service.dart';
import 'package:hello_doctor_admin_dashboard/app/services/dashboard_service.dart';

class DashboardController extends GetxController
    with StateMixin<DashboardModel> {
  late DashboardModel dashboardModel;

  @override
  void onInit() async {
    super.onInit();
    try {
      var dashboardData = await DashboardService().getDashboardData();
      change(dashboardData, status: RxStatus.success());
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
