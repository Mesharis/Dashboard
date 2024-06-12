import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_doctor_admin_dashboard/constants.dart';
import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          children: [
            TableRow(children: [
              const SizedBox(
                  height: 50, child: Text('Teacher Total')),
              SizedBox(
                  height: 50,
                  child: Text(currencySign + controller.balanceTeacher.toString())),
            ]),
            TableRow(children: [
              SizedBox(height: 50, child: Text('Operating total')),
              SizedBox(
                  height: 50,
                  child: Text(currencySign + controller.balanceOperating.toString())),
            ]),
            TableRow(
              children: [
                SizedBox(
                  height: 50,
                  child: Text('Owners total'),
                ),
                SizedBox(
                  height: 50,
                child: Text(currencySign + controller.balanceOwners.toString())),
              ],
            ),
          ],
        ),

        Container(
          padding: const EdgeInsets.all(defaultPadding),
          decoration: const BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: controller.obx(
            (listTransaction) {
              return SizedBox(
                height: 600,
                child: PaginatedDataTable2(
                  availableRowsPerPage: const <int>[
                    defaultRowsPerPage,
                    defaultRowsPerPage * 2,
                    defaultRowsPerPage * 6,
                    defaultRowsPerPage * 10
                  ],
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 600,
                  columns: const [
                    DataColumn2(
                      label: Text('Created At'),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(
                      label: Text('UserId'),
                      size: ColumnSize.L,
                    ),
                    DataColumn(
                      label: Text('TeacherId'),
                    ),
                    DataColumn(
                      label: Text('Teacher ratio'),
                    ),
                    DataColumn(
                      label: Text('Operating ratio'),
                    ),
                    DataColumn(
                      label: Text('Owners percentage'),
                    ),
                  ],
                  source: controller.transactionTableSource,
                ),
              );
            },
            onLoading: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        )
      ],
    );
  }
}
