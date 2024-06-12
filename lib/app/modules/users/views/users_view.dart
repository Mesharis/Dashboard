import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hello_doctor_admin_dashboard/constants.dart';

import '../controllers/users_controller.dart';

class Person {
  String name;
  String email;

  Person({required this.name, required this.email});
}

class UsersView extends GetView<UsersController> {
  UsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: controller.obx(
        (listUser) {
          return SizedBox(
            height: 720,
            child: PaginatedDataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 600,
              columns: const [
                DataColumn2(
                  label: Text('Name'),
                  size: ColumnSize.L,
                ),
                DataColumn(
                  label: Text('Email'),
                ),
                DataColumn(
                  label: Text('Created At'),
                ),
                DataColumn(
                  label: Text('Role'),
                ),
                DataColumn(
                  label: Text('Action'),
                ),
              ],
              source: controller.usersData,
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
