import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hello_doctor_admin_dashboard/app/models/user_table_source.dart';
import 'package:hello_doctor_admin_dashboard/app/models/users_model.dart';
import 'package:hello_doctor_admin_dashboard/app/services/users_service.dart';

class UsersController extends GetxController with StateMixin<List<UsersModel>> {
  //TODO: Implement UsersController

  final count = 0.obs;
  List<UsersModel>? listUsers;
  late UsersDataSource usersData;
  @override
  void onInit() async {
    super.onInit();
  }

  Future<void> initUsersTab() async {
    try {
      if (listUsers == null) {
        listUsers = await UsersService().getAllUsers();
        usersData = UsersDataSource(listUsers!);
        change(listUsers, status: RxStatus.success());
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
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

  void increment() => count.value++;
}
