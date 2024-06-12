import 'package:hello_doctor_admin_dashboard/app/firebase/firebase_collection.dart';
import 'package:hello_doctor_admin_dashboard/app/models/users_model.dart';

class UsersService {
  Future getAllUsers() async {
    try {
      var queryUsers = await FirebaseCollection()
          .usersCol
          .orderBy("createdAt", descending: true)
          .get();
      List<UsersModel> listUsers =
          queryUsers.docs.map((doc) => doc.data()).toList();
      return listUsers;
    } catch (e) {
      return Future.error(e);
    }
  }
}
