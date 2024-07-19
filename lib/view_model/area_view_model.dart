import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/globs.dart';
import 'package:online_groceries_admin/common/service_call.dart';
import 'package:online_groceries_admin/model/area_model.dart';
import 'package:online_groceries_admin/model/zone_model.dart';
import 'package:online_groceries_admin/view/account_tab/zone/area/area_add_view.dart';

class AreaViewModel extends GetxController {
  final listArr = <AreaModel>[].obs;
  final zoneObj = ZoneModel().obs;
  final areaObj = AreaModel().obs;

  final txtAreaName = TextEditingController().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  //TODO: Action
  void actionLoadList(ZoneModel zObj) {
    zoneObj.value = zObj;
    apiList();
  }

  void actionAdd(VoidCallback didDone) {
    if (txtAreaName.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter zone area name");
      return;
    }
    apiAdd({
      "area_name": txtAreaName.value.text,
      "zone_id": zoneObj.value.zoneId?.toString() ?? "0"
    }, didDone);
  }

  void actionEdit(AreaModel obj) {
    txtAreaName.value.text = obj.areaName ?? "";
    areaObj.value = obj;
    Get.bottomSheet(
      AreaAddView(
        obj: zoneObj.value,
        isEdit: true,
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  void actionUpdate(VoidCallback didDone) {
    if (txtAreaName.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter zone area name");
      return;
    }
    apiUpdate({
      "area_id": areaObj.value.areaId?.toString() ?? "",
      "zone_id": areaObj.value.zoneId?.toString() ?? "",
      "area_name": txtAreaName.value.text,
    }, didDone);
  }

  void actionDelete(AreaModel obj) {
    apiDelete({
      "area_id": obj.areaId?.toString() ?? "",
    });
  }

  //TODO: ApiCalling
  void apiList() {
    Globs.showHUD();
    ServiceCall.post(
        {"zone_id": zoneObj.value.zoneId?.toString() ?? ""}, SVKey.svAreaList,
        isToken: true, withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        listArr.value = (responseObj[KKey.payload] as List? ?? [])
            .map((e) => AreaModel.fromJson(e))
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
    ServiceCall.post(parameter, SVKey.svAreaAdd, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        txtAreaName.value.text = "";
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
    ServiceCall.post(parameter, SVKey.svAreaUpdate, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        txtAreaName.value.text = "";
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
    ServiceCall.post(parameter, SVKey.svAreaDelete, isToken: true,
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
