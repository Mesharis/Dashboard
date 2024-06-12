import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hello_doctor_admin_dashboard/app/modules/widgets/SearchField.dart';
import 'package:hello_doctor_admin_dashboard/constants.dart';

import '../controllers/doctors_controller.dart';

class DoctorsView extends GetView<DoctorsController> {
  const DoctorsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: controller.obx(
        (listDoctor) {
          return SizedBox(
            height: 800,
            width: Get.width,
            child: Column(
              children: [
                SearchField(
                  onQueryChange: (query) {
                    controller.searchQuery = query;
                  },
                  searchQuery: controller.searchQuery,
                  onSearch: () {
                    controller.searchDoctors(controller.searchQuery);
                  },
                  onClear: () {
                    controller.searchDoctors('');
                  },
                  textEditingController: controller.searchController,
                ),
                SizedBox(
                  height: 720,
                  child: PaginatedDataTable2(
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
                      DataColumn(
                        label: Text('Category'),
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
                    source: controller.doctorTableSource,
                  ),
                ),
              ],
            ),
          );
        },
        onLoading: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
