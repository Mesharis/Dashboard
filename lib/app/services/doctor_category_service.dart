import 'package:hello_doctor_admin_dashboard/app/firebase/firebase_collection.dart';
import 'package:hello_doctor_admin_dashboard/app/models/doctor_category.dart';

class DoctorCategoryService {
  Future getAllCategory() async {
    try {
      var categoryRef = await FirebaseCollection().categoryCol.get();
      List<DoctorCategory> listCategory =
          categoryRef.docs.map((doc) => doc.data()).toList();
      return listCategory;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<DoctorCategory> addNewCategory(DoctorCategory category) async {
    try {
      var newCategoryRef = await FirebaseCollection().categoryCol.add(category);
      var newCategoryWithId = await newCategoryRef.get();
      return newCategoryWithId.data()!;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<DoctorCategory> editCategory(
      String categoryId, DoctorCategory newCategory) async {
    try {
      await FirebaseCollection()
          .categoryCol
          .doc(categoryId)
          .update(newCategory.toJson());
      newCategory.id = categoryId;
      return newCategory;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future deleteCategory(String categoryId) async {
    try {
      await FirebaseCollection().categoryCol.doc(categoryId).delete();
    } catch (e) {
      return Future.error(e);
    }
  }
}
