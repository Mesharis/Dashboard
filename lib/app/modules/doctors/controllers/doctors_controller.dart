import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hello_doctor_admin_dashboard/app/models/doctor_model.dart';
import 'package:hello_doctor_admin_dashboard/app/models/doctor_table_source.dart';
import 'package:hello_doctor_admin_dashboard/app/services/doctor_service.dart';

class DoctorsController extends GetxController with StateMixin<List<Doctor>> {
  List<Doctor>? listDoctor;
  late DoctorTableSource doctorTableSource;
  String searchQuery = '';
  late List<Doctor> filteredList = [];
  TextEditingController searchController = TextEditingController();
  Doctor? selectedDoctor;
  @override
  void onInit() {
    super.onInit();
  }

  Future initDoctorsTab() async {
    try {
      if (listDoctor == null) {
        listDoctor = await DoctorService().getDoctors();
        doctorTableSource = DoctorTableSource(listDoctor!);
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

  void activateDoctor(String doctorId) async {
    EasyLoading.show();
    try {
      await DoctorService().activateDoctor(doctorId);
      Doctor doctorActivated =
          listDoctor!.firstWhere((element) => element.id == doctorId);
      doctorActivated.accountStatus = 'active';
      doctorTableSource = DoctorTableSource(listDoctor!);
      change(listDoctor, status: RxStatus.success());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  void disabledDoctor(String doctorId) async {
    EasyLoading.show();
    try {
      await DoctorService().bannedDoctor(doctorId);
      Doctor doctorActivated =
          listDoctor!.firstWhere((element) => element.id == doctorId);
      doctorActivated.accountStatus = 'nonactive';
      doctorTableSource = DoctorTableSource(listDoctor!);
      change(listDoctor, status: RxStatus.success());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future addToTopRatedDoctor(String doctorId) async {
    try {
      await DoctorService().addTopRatedDoctor(doctorId);
      Doctor doctorTopRated =
          listDoctor!.firstWhere((element) => element.id == doctorId);
      doctorTopRated.topRated = true;
      doctorTableSource = DoctorTableSource(listDoctor!);
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
      doctorTableSource = DoctorTableSource(listDoctor!);
      change(listDoctor, status: RxStatus.success());
    } catch (e) {
      return Future.error(e);
    }
  }

  void searchDoctors(String query) {
    filteredList = listDoctor!.where((doctor) {
      final name = doctor.doctorName?.toLowerCase();
      if (name != null) {
        return name.contains(query.toLowerCase());
      } else {
        return false;
      }
    }).toList();
    change(listDoctor, status: RxStatus.success());
    doctorTableSource =
        DoctorTableSource(filteredList); // Update doctorTableSource
    update(); // Notify listeners that the filtered list has changed
  }
}
