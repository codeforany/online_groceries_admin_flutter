import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/globs.dart';
import 'package:online_groceries_admin/common/service_call.dart';
import 'package:online_groceries_admin/model/my_order_model.dart';
import 'package:online_groceries_admin/model/product_detail_model.dart';

class OrderViewModel extends GetxController {
  final newOrderArr = <MyOrderModel>[].obs;
  final completeOrderArr = <MyOrderModel>[].obs;
  final cancelOrderArr = <MyOrderModel>[].obs;

  final cartList = <ProductDetailModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    apiNewOrderList();
    apiCompleteOrderList();
    apiCancelDeclineOrderList();
  }

  //TODO: Actoion

  void actionOpenOrderDetail(MyOrderModel obj) {
    apiOrderDetail(obj.orderId ?? 0, obj.userId ?? 0);
  }

  //TODO: ApiCalling

  void apiNewOrderList() {
    Globs.showHUD();
    ServiceCall.post({}, SVKey.svNewOrderList, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        newOrderArr.value = (responseObj[KKey.payload] as List? ?? [])
            .map((e) => MyOrderModel.fromJson(e))
            .toList();
      } else {
        newOrderArr.value = [];
      }
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(Globs.appName, err.toString());
    });
  }

  void apiCompleteOrderList() {
    Globs.showHUD();

    ServiceCall.post({}, SVKey.svCompleteOrderList, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        completeOrderArr.value = (responseObj[KKey.payload] as List? ?? [])
            .map((e) => MyOrderModel.fromJson(e))
            .toList();
      } else {
        completeOrderArr.value = [];
      }
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(Globs.appName, err.toString());
    });
  }

  void apiCancelDeclineOrderList() {
    Globs.showHUD();

    ServiceCall.post({}, SVKey.svCancelDeclineOrderList, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        cancelOrderArr.value = (responseObj[KKey.payload] as List? ?? [])
            .map((e) => MyOrderModel.fromJson(e))
            .toList();
      } else {
        cancelOrderArr.value = [];
      }
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(Globs.appName, err.toString());
    });
  }

  void apiOrderDetail(int orderId, int userId) {
    Globs.showHUD();

    ServiceCall.post({
      "order_id": orderId.toString(),
      "user_id": userId.toString()
    }, SVKey.svOrderDetail, isToken: true, withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        var payload = responseObj[KKey.payload] as Map? ?? {};

        cartList.value = (payload["cart_list"] as List? ?? [])
            .map((e) => ProductDetailModel.fromJson(e))
            .toList();
      } else {
        cartList.value = [];

        Get.snackbar(
            Globs.appName, responseObj[KKey.message] as String? ?? MSG.fail);
      }
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(Globs.appName, err.toString());
    });
  }

  void apiOrderStatusChange(
      int orderId, int userId, int orderStatus, VoidCallback didDone) {
    Globs.showHUD();
    ServiceCall.post({
      "order_id": orderId.toString(),
      "user_id": userId.toString(),
      "order_status": orderStatus.toString(),
    }, SVKey.svOrderStatusChange, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();
      if (responseObj[KKey.status] == "1") {
        Get.snackbar(
            Globs.appName, responseObj[KKey.message] as String? ?? MSG.success);
        didDone();
      } else {
        Get.snackbar(
            Globs.appName, responseObj[KKey.message] as String? ?? MSG.fail);
      }
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(Globs.appName, err.toString());
    });
  }
}
