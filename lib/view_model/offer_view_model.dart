import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/extension.dart';
import 'package:online_groceries_admin/common/globs.dart';
import 'package:online_groceries_admin/common/service_call.dart';
import 'package:online_groceries_admin/model/offer_product_model.dart';
import 'package:online_groceries_admin/model/product_detail_model.dart';

class OfferViewModel extends GetxController {
  final listArr = <OfferProductModel>[].obs;
  final offerObj = OfferProductModel().obs;
  final txtPrice = TextEditingController().obs;
  final selectStartDate = DateTime.now().obs;
  final selectEndDate = DateTime.now().obs;
  final selectProductObj = Rx<ProductDetailModel?>(null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  //TODO: Action


  void actionAdd( ProductDetailModel obj , VoidCallback didDone) {
    if (txtPrice.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter offer amount");
      return;
    }

    apiAdd({
      "prod_id": (obj.prodId)?.toString() ?? "",
      "start_date": selectStartDate.value.stringFormat(),
      "end_date": selectEndDate.value.stringFormat(),
      "price": txtPrice.value.text,
    }, didDone);
  }

  void actionDelete(OfferProductModel obj) {
    apiDelete({
      "offer_id": obj.offerId?.toString() ?? "",
    });
  }

  //TODO: ApiCalling
  void apiList() {
    Globs.showHUD();
    ServiceCall.post({}, SVKey.svOfferProductList, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        listArr.value = (responseObj[KKey.payload] as List? ?? [])
            .map((e) => OfferProductModel.fromJson(e))
            .toList();
      } else {
        listArr.value = [];
      }
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(Globs.appName, err.toString());
    });
  }

  void apiAdd(Map<String, String> parameter, VoidCallback didDone) {
    Globs.showHUD();
    ServiceCall.post(parameter, SVKey.svOfferAdd, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        txtPrice.value.text = "";
        Get.snackbar(
            Globs.appName, responseObj[KKey.message] as String? ?? MSG.success);
        didDone();
        apiList();
      } else {
        Get.snackbar(
            Globs.appName, responseObj[KKey.message] as String? ?? MSG.fail);
      }
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(Globs.appName, err.toString());
    });
  }

  void apiDelete(Map<String, String> parameter) {
    Globs.showHUD();
    ServiceCall.post(parameter, SVKey.svOfferDelete, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        Get.snackbar(
            Globs.appName, responseObj[KKey.message] as String? ?? MSG.success);
        apiList();
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
