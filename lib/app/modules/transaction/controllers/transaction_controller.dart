import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hello_doctor_admin_dashboard/app/models/transaction_model.dart';
import 'package:hello_doctor_admin_dashboard/app/models/transaction_table_source.dart';
import 'package:hello_doctor_admin_dashboard/app/services/transaction_service.dart';

class TransactionController extends GetxController
    with StateMixin<List<TransactionModel>> {
  List<TransactionModel>? listTransaction;
  late TransactionTableSource transactionTableSource;
  double balanceOwners = 0;
  double balanceOperating = 0;
  double balanceTeacher = 0;
  @override
  void onInit() {
    initializeTransactionTab();
    super.onInit();
  }

  void initializeTransactionTab() async {
    try {
      listTransaction = await TransactionService().getAllTransaction();
      transactionTableSource = TransactionTableSource(listTransaction!);
      buildTotalMoney(listTransaction!);
      buildTotalMoney(listTransaction!);
      buildTotalMoney(listTransaction!);
      change(listTransaction, status: RxStatus.success());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void buildTotalMoney(List<TransactionModel> total) {
    double Teacher = 0.0;
    double Operating = 0.0;
    double Owners = 0.0;

    for (var i = 0; i < total.length; ++i) {
      Teacher += total[i].amount!;
      Teacher -= ((double.parse('80')) / 100) * total[i].amount!;
      Operating += total[i].amount!;
      Operating -= ((double.parse('60')) / 100) * total[i].amount!;
      Owners += total[i].amount!;
      Owners -= ((double.parse('60')) / 100) * total[i].amount!;
    }
    balanceTeacher = Teacher;
    balanceOperating = Operating;
    balanceOwners = Owners;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
