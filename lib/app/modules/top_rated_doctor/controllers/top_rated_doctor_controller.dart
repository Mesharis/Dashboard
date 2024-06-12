import 'package:get/get.dart';
import 'package:hello_doctor_admin_dashboard/app/models/doctor_model.dart';
import 'package:hello_doctor_admin_dashboard/app/services/doctor_service.dart';

class TopRatedDoctorController extends GetxController
    with StateMixin<List<Doctor>> {
  List<Doctor>? listDoctor = [];

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
  }

  Future initTopRatedDoctorTab() async {
    try {
      if (listDoctor == null || listDoctor!.isEmpty) {
        listDoctor = await DoctorService().getTopRatedDoctors();
        change(listDoctor, status: RxStatus.success());
      }
    } catch (e) {
      return Future.error(e);
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

  Future addToTopRatedDoctor(String doctorId) async {
    try {
      await DoctorService().addTopRatedDoctor(doctorId);
      Doctor doctorTopRated =
          listDoctor!.firstWhere((element) => element.id == doctorId);
      doctorTopRated.topRated = true;
      change(listDoctor, status: RxStatus.success());
    } catch (e) {
      return Future.error(e);
    }
  }

  Future removeDoctorFromTopRated(String doctorId) async {
    try {
      await DoctorService().removeTopRatedDoctor(doctorId);
      Doctor doctorTopRated =
          listDoctor!.firstWhere((element) => element.id == doctorId);
      doctorTopRated.topRated = false;
      change(listDoctor, status: RxStatus.success());
    } catch (e) {
      return Future.error(e);
    }
  }
}
