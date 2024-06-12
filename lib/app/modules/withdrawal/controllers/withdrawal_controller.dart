import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hello_doctor_admin_dashboard/app/models/withdraw_request_model.dart';
import 'package:hello_doctor_admin_dashboard/app/models/withdrawal_table_source.dart';
import 'package:hello_doctor_admin_dashboard/app/services/transaction_service.dart';
import 'package:hello_doctor_admin_dashboard/app/services/withdraw_service.dart';

class WithdrawalController extends GetxController
    with StateMixin<List<WithdrawRequestModel>> {
  List<WithdrawRequestModel>? listWithdrawRequest;
  late WithdrawalTableSource withdrawalTableSource;
  @override
  void onInit() {
    super.onInit();
  }

  void initWithdrawTab() async {
    try {
      if (listWithdrawRequest == null) {
        listWithdrawRequest = await WithdrawService().getWithdrawRequest();
        withdrawalTableSource =
            WithdrawalTableSource(listWithdrawRequest!, this);
        change(listWithdrawRequest, status: RxStatus.success());
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return Future.error(e.toString());
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void markWithdrawlCompleted(String id) async {
    try {
      EasyLoading.show();
      await WithdrawService().markWithdrawalCompleted(id);
      await TransactionService().setWithdrawTransactionComplete(id);
      WithdrawRequestModel withdrawalRequest =
          listWithdrawRequest!.firstWhere((element) => element.id == id);
      withdrawalRequest.status = 'completed';
      withdrawalTableSource = WithdrawalTableSource(listWithdrawRequest!, this);
      change(listWithdrawRequest, status: RxStatus.success());
      Get.back();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }
}
