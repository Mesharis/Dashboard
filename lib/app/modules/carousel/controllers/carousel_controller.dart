import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hello_doctor_admin_dashboard/app/models/image_carousel_model.dart';
import 'package:hello_doctor_admin_dashboard/app/services/image_carousel_service.dart';
import 'package:hello_doctor_admin_dashboard/app/services/image_service.dart';

class CarouselController extends GetxController
    with StateMixin<List<ImageCarouselModel>> {
  List<ImageCarouselModel> listImageCarousel = [];
  String? fileName;
  Rx<Image?>? selectedImage = Rx<Image?>(null);
  Uint8List? imageFile;
  ImageCarouselModel? editedImageCarousel;

  @override
  void onInit() {
    super.onInit();
  }

  Future initImageCarousel() async {
    try {
      listImageCarousel = await ImageCarouselService().getImageCarousel();
      change(listImageCarousel, status: RxStatus.success());
    } catch (e) {
      return Future.error(e);
    }
  }

  Future deleteImageCarousel(ImageCarouselModel imageCarousel) async {
    try {
      await ImageCarouselService()
          .removeImageCarousel(imageCarousel.id!, imageCarousel.imageUrl!);
      listImageCarousel
          .removeWhere((element) => element.id == imageCarousel.id);
      change(listImageCarousel, status: RxStatus.success());
    } catch (e) {
      return Future.error(e);
    }
  }

  Future addNewCarouselImage() async {
    try {
      EasyLoading.show();
      if (!validateAddImageForm()) {
        return;
      }
      if (imageFile != null) {
        String imageUrl = await ImageService().uploadImageHtml(imageFile!);
        ImageCarouselModel newImageCarousel = ImageCarouselModel(
            imageUrl: imageUrl, createdAt: DateTime.now(), fileName: fileName);
        ImageCarouselModel newImageCarouselWithId =
            await ImageCarouselService().addImageCarousel(newImageCarousel);
        listImageCarousel.add(newImageCarouselWithId);
        change(listImageCarousel, status: RxStatus.success());
        cancelDialog();
      } else {
        Fluttertoast.showToast(msg: 'Please Add Image Carousel');
      }
    } catch (e) {
      return Future.error(e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future editImageCarousel() async {
    try {
      EasyLoading.show();
      final indexToUpdate = listImageCarousel.indexWhere(
        (imageCarousel) => imageCarousel.id == editedImageCarousel?.id,
      );
      if (selectedImage?.value != null) {
        final previousImageUrl = editedImageCarousel!.imageUrl;
        if (imageFile != null) {
          String imageUrl = await uploadImage();
          editedImageCarousel?.imageUrl = imageUrl;
          editedImageCarousel?.fileName = fileName;
          ImageCarouselService().updateImageCarousel(editedImageCarousel!);
          // Remove the previous image
          if (previousImageUrl != null) {
            await ImageService().removeImage(previousImageUrl);
          }
          listImageCarousel[indexToUpdate] = editedImageCarousel!;
          change(listImageCarousel, status: RxStatus.success());
        } else {
          return Future.error('imageFile is null');
        }
      }
    } catch (e) {
      return Future.error(e);
    } finally {
      EasyLoading.dismiss();
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

  Future<String> uploadImage() async {
    return await ImageService().uploadImageHtml(imageFile!);
  }

  void cancelDialog() {
    updateSelectedImage(makeItNull: true);
    Get.back();
    imageFile = null;
  }

  bool validateAddImageForm() {
    if (imageFile == null) {
      Fluttertoast.showToast(
          msg: 'Please choose the image', timeInSecForIosWeb: 3);
      return false;
    }

    return true;
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
