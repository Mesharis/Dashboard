import 'package:flutter/material.dart';
import 'package:hello_doctor_admin_dashboard/app/modules/carousel/controllers/carousel_controller.dart';
import 'package:hello_doctor_admin_dashboard/app/utils/timeformat.dart';

class DetailCarouselContent extends StatelessWidget {
  final CarouselController controller;
  const DetailCarouselContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 400,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.0, // Maintain aspect ratio (1.0 means square)
            child: Image.network(
              controller.editedImageCarousel!.imageUrl!,
              fit: BoxFit.scaleDown, // Preserve aspect ratio and fit inside
            ),
          ),
          Text(
              'Created at : ${TimeFormat().formatDate(controller.editedImageCarousel?.createdAt)}')
        ],
      ),
    );
  }
}
