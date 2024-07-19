import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/globs.dart';
import 'package:online_groceries_admin/common/service_call.dart';
import 'package:online_groceries_admin/model/brand_model.dart';
import 'package:online_groceries_admin/view/account_tab/brand/brand_add_view.dart';

class BrandViewModel extends GetxController {
  final listArr = <BrandModel>[].obs;
  final brandObj = BrandModel().obs;

  final txtBrandName = TextEditingController().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    apiList();
  }

  //TODO: Action
  void actionAdd(VoidCallback didDone) {
    if (txtBrandName.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Brand Name");
      return;
    }
    apiAdd({"brand_name": txtBrandName.value.text}, didDone);
  }

  void actionEdit(BrandModel obj) {
    txtBrandName.value.text = obj.brandName ?? "";
    brandObj.value = obj;
    Get.bottomSheet(
      const BrandAddView(
        isEdit: true,
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  void actionUpdate(VoidCallback didDone) {
    if (txtBrandName.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Brand Name");
      return;
    }
    apiUpdate({
      "brand_id": brandObj.value.brandId?.toString() ?? "",
      "brand_name": txtBrandName.value.text,
    }, didDone);
  }
  void actionDelete(BrandModel obj) {
    apiDelete({
      "brand_id": obj.brandId?.toString() ?? "",
    });
  }

  //TODO: ApiCalling
  void apiList() {
    Globs.showHUD();
    ServiceCall.post({}, SVKey.svBrandList, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        listArr.value = (responseObj[KKey.payload] as List? ?? [])
            .map((e) => BrandModel.fromJson(e))
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
    ServiceCall.post(parameter, SVKey.svBrandAdd, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        txtBrandName.value.text = "";
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

  void apiUpdate(Map<String, String> parameter, VoidCallback didDone) {
    Globs.showHUD();
    ServiceCall.post(parameter, SVKey.svBrandUpdate, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        txtBrandName.value.text = "";
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
    ServiceCall.post(parameter, SVKey.svBrandDelete, isToken: true,
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
