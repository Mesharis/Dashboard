import 'package:flutter/material.dart';

import '../controllers/category_controller.dart';

class InfoCategoryContent extends StatelessWidget {
  final CategoryController controller;
  const InfoCategoryContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 300,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.0, // Maintain aspect ratio (1.0 means square)
            child: Image.network(
              controller.editedCategory!.iconUrl!,
              fit: BoxFit.scaleDown, // Preserve aspect ratio and fit inside
            ),
          ),
          Text('Category Name : ${controller.editedCategory?.categoryName}')
        ],
      ),
    );
  }
}
