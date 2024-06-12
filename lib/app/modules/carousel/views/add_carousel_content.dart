import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_doctor_admin_dashboard/app/modules/carousel/controllers/carousel_controller.dart';
import 'package:hello_doctor_admin_dashboard/app/modules/widgets/ChooseImage.dart';
import 'package:image_picker_web/image_picker_web.dart';

class AddCarouselContent extends StatelessWidget {
  final CarouselController controller;
  const AddCarouselContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 300,
      child: Obx(() => Column(
            children: [
              ChooseImage(
                onImageGetChoose: (imageData) {
                  controller.fileName = imageData.fileName;
                  controller.imageFile = imageData.data;
                  controller.updateSelectedImage();
                },
                selectedImage: controller.selectedImage?.value,
              ),
              TextButton(
                onPressed: () async {
                  final imageData = await ImagePickerWeb.getImageInfo;
                  controller.fileName = imageData?.fileName;
                  controller.imageFile = imageData?.data;
                  controller.updateSelectedImage();
                },
                child: const Text('Choose Carousel Image'),
              ),
            ],
          )),
    );
    ;
  }
}
