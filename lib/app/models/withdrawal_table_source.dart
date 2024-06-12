import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_doctor_admin_dashboard/app/models/withdraw_request_model.dart';
import 'package:hello_doctor_admin_dashboard/app/modules/withdrawal/controllers/withdrawal_controller.dart';
import 'package:hello_doctor_admin_dashboard/app/utils/timeformat.dart';
import 'package:hello_doctor_admin_dashboard/constants.dart';

class WithdrawalTableSource extends DataTableSource {
  late final List<WithdrawRequestModel> listWithdrawalRequest;
  late WithdrawalController withdrawalController;
  WithdrawalTableSource(this.listWithdrawalRequest, this.withdrawalController);
  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(
          TimeFormat().formatDate(listWithdrawalRequest[index].createdAt))),
      DataCell(
          Text(currencySign + listWithdrawalRequest[index].amount!.toString())),
      DataCell(Text(
          currencySign + listWithdrawalRequest[index].adminFee.toString())),
      DataCell(
          Text(currencySign + listWithdrawalRequest[index].tax.toString())),
      DataCell(Text(currencySign +
          listWithdrawalRequest[index].totalWithdraw.toString())),
      DataCell(
          Text(listWithdrawalRequest[index].withdrawMethod!.email.toString())),
      DataCell(
          Text(listWithdrawalRequest[index].withdrawMethod!.method.toString())),
      DataCell(
          Text(listWithdrawalRequest[index].withdrawMethod!.name.toString())),
      DataCell(
          Text(listWithdrawalRequest[index].withdrawMethod!.userId.toString())),
      DataCell(Text(listWithdrawalRequest[index].status ?? '')),
      DataCell(
        listWithdrawalRequest[index].status == 'completed'
            ? SizedBox()
            : IconButton(
                icon: const Icon(Icons.done),
                onPressed: () {
                  Get.defaultDialog(
                      title: 'Mark Withdraw Complete',
                      content: const Text(
                          'Are you sure you want to mark this withdrawal as completed? Please ensure that you have sent the doctor the money.'),
                      onConfirm: () {
                        withdrawalController.markWithdrawlCompleted(
                            listWithdrawalRequest[index].id!);
                      },
                      textConfirm: 'Mark as Complete',
                      textCancel: 'Cancel');
                },
              ),
      )
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => listWithdrawalRequest.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
