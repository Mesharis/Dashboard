import 'package:flutter/material.dart';
import 'package:hello_doctor_admin_dashboard/app/models/transaction_model.dart';
import 'package:hello_doctor_admin_dashboard/app/utils/timeformat.dart';
import 'package:hello_doctor_admin_dashboard/constants.dart';

class TransactionTableSource extends DataTableSource {
  late final List<TransactionModel> listTransaction;
  TransactionTableSource(this.listTransaction);

  @override
  DataRow? getRow(int index) {
    double Teacher = 0.0;
    double Operating = 0.0;
    double Owners = 0.0;
    Teacher += listTransaction[index].amount!;
    Teacher -= ((double.parse('80')) / 100) * listTransaction[index].amount!;
    Operating += listTransaction[index].amount!;
    Operating -= ((double.parse('60')) / 100) * listTransaction[index].amount!;
    Owners += listTransaction[index].amount!;
    Owners -= ((double.parse('60')) / 100) * listTransaction[index].amount!;
    return DataRow(
      cells: [
        DataCell(Text(TimeFormat().formatDate(listTransaction[index].createdAt))),
        DataCell(Text(listTransaction[index].userId!)),
        DataCell(Text(listTransaction[index].doctorId!)),
        DataCell(Text(currencySign + Teacher.toString())),
        DataCell(Text(currencySign + Operating.toString())),
        DataCell(Text(currencySign + Owners.toString())),
      ],
    );
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => listTransaction.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
