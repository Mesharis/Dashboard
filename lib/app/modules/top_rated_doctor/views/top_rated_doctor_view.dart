import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hello_doctor_admin_dashboard/constants.dart';
import 'package:hello_doctor_admin_dashboard/responsive.dart';

import '../controllers/top_rated_doctor_controller.dart';

class TopRatedDoctorView extends GetView<TopRatedDoctorController> {
  const TopRatedDoctorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Top Rated Doctor",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Container(
          padding: const EdgeInsets.all(defaultPadding),
          decoration: const BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: controller.obx(
            (listDoctor) {
              return SizedBox(
                height: 720,
                child: DataTable2(
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    minWidth: 600,
                    columns: const [
                      DataColumn2(
                        label: Text('Name'),
                        size: ColumnSize.M,
                      ),
                      DataColumn2(
                          label: Text('Created At'), size: ColumnSize.L),
                      DataColumn2(
                          label: Text('Last Updated'), size: ColumnSize.L),
                      DataColumn(
                        label: Text('Category'),
                      ),
                      DataColumn2(label: Text('Balance'), size: ColumnSize.S),
                      DataColumn(
                        label: Text('Base Price'),
                      ),
                      DataColumn(
                        label: Text('Biography'),
                      ),
                      DataColumn(
                        label: Text('Education'),
                      ),
                      DataColumn(
                        label: Text('Status'),
                      ),
                      DataColumn(
                        label: Text('Action'),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                        listDoctor!.length,
                        (index) => DataRow(cells: [
                              // DataCell(Image.network(
                              //   listDoctor[index].doctorPicture!,
                              //   height: 20,
                              // )),
                              DataCell(
                                  Text(listDoctor[index].doctorName ?? '')),
                              DataCell(
                                  Text(listDoctor[index].createdAt.toString())),
                              DataCell(
                                  Text(listDoctor[index].updatedAt.toString())),
                              DataCell(Text(listDoctor[index]
                                      .doctorCategory
                                      ?.categoryName ??
                                  '')),
                              DataCell(Text(
                                  listDoctor[index].doctorBalance.toString())),
                              DataCell(Text(
                                  listDoctor[index].doctorPrice.toString())),
                              DataCell(Text(listDoctor[index]
                                  .doctorShortBiography
                                  .toString())),
                              DataCell(Text(
                                  listDoctor[index].doctorHospital.toString())),
                              DataCell(Text(
                                  listDoctor[index].accountStatus.toString())),
                              DataCell(
                                Row(
                                  children: [
                                    (listDoctor[index].topRated == null ||
                                            listDoctor[index].topRated == false)
                                        ? IconButton(
                                            icon: const Icon(Icons
                                                .star_border_purple500_outlined),
                                            onPressed: () {
                                              Get.defaultDialog(
                                                  title: "Set Top Rated Doctor",
                                                  content: const Text(
                                                    'Set this doctor as a top rated doctor, this doctor will be promoted on the client\'s home page',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  textCancel: 'Cancel',
                                                  textConfirm: 'Set Top Rated',
                                                  onConfirm: () {
                                                    Get.back();
                                                    controller
                                                        .addToTopRatedDoctor(
                                                            listDoctor[index]
                                                                .id!);
                                                  });
                                            },
                                          )
                                        : IconButton(
                                            icon: const Icon(Icons.star),
                                            onPressed: () {
                                              Get.defaultDialog(
                                                  title:
                                                      "Remove Top Rated Doctor",
                                                  content: const Text(
                                                    'Remove Top Rated Doctor',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  textCancel: 'Cancel',
                                                  textConfirm:
                                                      'Remove Top Rated Doctor',
                                                  onConfirm: () {
                                                    Get.back();
                                                    controller
                                                        .removeDoctorFromTopRated(
                                                            listDoctor[index]
                                                                .id!);
                                                  });
                                            },
                                          )
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
        ),
      ],
    );
  }
}
