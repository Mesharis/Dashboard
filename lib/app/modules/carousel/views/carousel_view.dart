import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hello_doctor_admin_dashboard/app/modules/carousel/views/add_carousel_content.dart';
import 'package:hello_doctor_admin_dashboard/app/modules/carousel/views/detail_carousel_content.dart';
import 'package:hello_doctor_admin_dashboard/constants.dart';
import 'package:hello_doctor_admin_dashboard/responsive.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../controllers/carousel_controller.dart';

class CarouselView extends GetView<CarouselController> {
  const CarouselView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Image Carousel",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ElevatedButton.icon(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () {
                  Get.defaultDialog(
                      title: 'Add new Category',
                      content: AddCarouselContent(controller: controller),
                      onConfirm: () {
                        controller.addNewCarouselImage();
                      },
                      onCancel: controller.cancelDialog);
                },
                icon: Icon(Icons.add),
                label: Text("Add New"),
              ),
            ],
          ),
          const SizedBox(height: defaultPadding),
          controller.obx(
            (listCarousel) {
              return SizedBox(
                height: 500,
                child: DataTable2(
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    minWidth: 600,
                    columns: const [
                      DataColumn2(
                        label: Text('Image'),
                        size: ColumnSize.L,
                      ),
                      DataColumn2(
                        label: Text('File Name'),
                        size: ColumnSize.L,
                      ),
                      DataColumn(
                        label: Text('Action'),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                        listCarousel!.length,
                        (index) => DataRow(cells: [
                              DataCell(InkWell(
                                onTap: () {
                                  controller.editedImageCarousel =
                                      listCarousel[index];
                                  Get.defaultDialog(
                                      title: 'Detail Image Carousel',
                                      content: DetailCarouselContent(
                                          controller: controller),
                                      onConfirm: () {
                                        Get.back();
                                      },
                                      textConfirm: 'Ok');
                                },
                                child: Image.network(
                                    listCarousel[index].imageUrl ?? ''),
                              )),
                              DataCell(Text(listCarousel[index].fileName!)),
                              DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        Get.defaultDialog(
                                            title: 'Delete Image Carousel',
                                            content: Text(
                                                'Are you sure you wanto delete ${listCarousel[index].fileName!} Image Carousel?'),
                                            onConfirm: () {
                                              controller.deleteImageCarousel(
                                                  listCarousel[index]);
                                              Get.back();
                                            },
                                            onCancel: () {});
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                          Icons.image_search_outlined),
                                      onPressed: () {
                                        controller.editedImageCarousel =
                                            listCarousel[index];
                                        Get.defaultDialog(
                                            title: 'Detail Image Carousel',
                                            content: DetailCarouselContent(
                                                controller: controller),
                                            onConfirm: () {
                                              Get.back();
                                            },
                                            textConfirm: 'Ok');
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ]))),
              );
            },
            onLoading: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
