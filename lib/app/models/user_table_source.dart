import 'package:flutter/material.dart';
import 'package:hello_doctor_admin_dashboard/app/models/users_model.dart';
import 'package:hello_doctor_admin_dashboard/app/utils/timeformat.dart';

class UsersDataSource extends DataTableSource {
  late final List<UsersModel> listUser;
  UsersDataSource(this.listUser);
  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(listUser[index].displayName ?? '')),
      DataCell(Text(listUser[index].email ?? '')),
      DataCell(
          Text(TimeFormat().formatDate(listUser[index].createdAt).toString())),
      DataCell(Text(listUser[index].role.toString())),
      DataCell(
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {},
        ),
      )
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => listUser.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
