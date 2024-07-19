import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/globs.dart';
import 'package:online_groceries_admin/common/service_call.dart';
import 'package:online_groceries_admin/model/zone_model.dart';
import 'package:online_groceries_admin/view/account_tab/zone/zone_add_view.dart';

class ZoneViewModel extends GetxController {
  final listArr = <ZoneModel>[].obs;
  final zoneObj = ZoneModel().obs;

  final txtZoneName = TextEditingController().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    apiList();
  }

  //TODO: Action
  void actionAdd(VoidCallback didDone) {
    if (txtZoneName.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter zone name");
      return;
    }
    apiAdd({"zone_name": txtZoneName.value.text}, didDone);
  }

  void actionEdit(ZoneModel obj) {
    txtZoneName.value.text = obj.zoneName ?? "";
    zoneObj.value = obj;
    Get.bottomSheet(
      const ZoneAddView(
        isEdit: true,
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  void actionUpdate(VoidCallback didDone) {
    if (txtZoneName.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter zone name");
      return;
    }
    apiUpdate({
      "zone_id": zoneObj.value.zoneId?.toString() ?? "",
      "zone_name": txtZoneName.value.text,
    }, didDone);
  }

  void actionDelete(ZoneModel obj) {
    apiDelete({
      "zone_id": obj.zoneId?.toString() ?? "",
    });
  }

  //TODO: ApiCalling
  void apiList() {
    Globs.showHUD();
    ServiceCall.post({}, SVKey.svZoneList, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        listArr.value = (responseObj[KKey.payload] as List? ?? [])
            .map((e) => ZoneModel.fromJson(e))
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
    ServiceCall.post(parameter, SVKey.svZoneAdd, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        txtZoneName.value.text = "";
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
    ServiceCall.post(parameter, SVKey.svZoneUpdate, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        txtZoneName.value.text = "";
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
    ServiceCall.post(parameter, SVKey.svZoneDelete, isToken: true,
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
