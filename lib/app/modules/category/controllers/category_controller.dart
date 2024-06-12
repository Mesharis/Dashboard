import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hello_doctor_admin_dashboard/app/models/doctor_category.dart';
import 'package:hello_doctor_admin_dashboard/app/services/doctor_category_service.dart';
import 'package:hello_doctor_admin_dashboard/app/services/image_service.dart';

class CategoryController extends GetxController
    with StateMixin<List<DoctorCategory>> {
  List<DoctorCategory>? listCategory = [];
  Uint8List? imageFile;
  String newCategoryName = '';
  Rx<Image?>? selectedImage = Rx<Image?>(null);
  DoctorCategory? editedCategory;
  TextEditingController textEditingController = TextEditingController();
  String? fileName;
  int? selectedIndex;
  @override
  void onInit() {
    super.onInit();
  }

  Future initCategoryTab() async {
    try {
      if (listCategory == null || listCategory!.isEmpty) {
        listCategory = await DoctorCategoryService().getAllCategory();
        change(listCategory, status: RxStatus.success());
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  void updateSelectedImage({bool makeItNull = false}) {
    if (makeItNull) return selectedImage?.value = null;
    if (imageFile != null) {
      Image imageWidget = Image.memory(imageFile!);
      selectedImage?.value = imageWidget;
    }
    update(); // This triggers a rebuild of the GetBuilder widget
  }

  void addNewCategory() async {
    try {
      EasyLoading.show();
      if (!validateAddImageForm()) {
        return;
      }
      String imageData = await ImageService().uploadImageHtml(imageFile!);
      DoctorCategory newCategory =
          DoctorCategory(categoryName: newCategoryName, iconUrl: imageData);
      DoctorCategory newCategoryWithId =
          await DoctorCategoryService().addNewCategory(newCategory);
      listCategory?.insert(0, newCategoryWithId);
      change(listCategory, status: RxStatus.success());
      Get.back();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  void setSelectedCategory(DoctorCategory category) {
    editedCategory = category;
    textEditingController.text = category.categoryName ?? '';
  }

  Future editCategory() async {
    try {
      EasyLoading.show();
      if (!validateUpdateForm()) {
        return;
      }
      if (selectedImage?.value != null) {
        final previousImageUrl = editedCategory!.iconUrl;
        if (imageFile != null) {
          String imageUrl = await uploadImage();
          editedCategory?.iconUrl = imageUrl;
          editedCategory?.categoryName = textEditingController.text;
          await DoctorCategoryService()
              .editCategory(editedCategory!.id!, editedCategory!);
          // Remove the previous image
          if (previousImageUrl != null) {
            await ImageService().removeImage(previousImageUrl);
          }
          listCategory![selectedIndex!] = editedCategory!;
          change(listCategory, status: RxStatus.success());
        } else {
          return Future.error('imageFile is null');
        }
      } else {
        editedCategory?.categoryName = textEditingController.text;
        await DoctorCategoryService()
            .editCategory(editedCategory!.id!, editedCategory!);
        listCategory![selectedIndex!] = editedCategory!;
        change(listCategory, status: RxStatus.success());
      }
    } catch (e) {
      Get.back();
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<String> uploadImage() async {
    return await ImageService().uploadImageHtml(imageFile!);
  }

  void cancelDialog() {
    updateSelectedImage(makeItNull: true);
    textEditingController.text = '';
    Get.back();
  }

  void deleteCategory(String? id) async {
    try {
      EasyLoading.show();
      if (id == null) {
        return;
      }
      await DoctorCategoryService().deleteCategory(id);
      listCategory?.removeWhere((category) => category.id == id);
      change(listCategory, status: RxStatus.success());
      Get.back();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  bool validateAddImageForm() {
    if (imageFile == null) {
      Fluttertoast.showToast(msg: 'Please Add Image Category');
      return false;
    }

    if (textEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Category Name Cannot be Empty');
      return false;
    }

    return true;
  }

  bool validateUpdateForm() {
    if (textEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Category Name Cannot be Empty');
      return false;
    }

    return true;
  }
}
