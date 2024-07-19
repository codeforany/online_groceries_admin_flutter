import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/globs.dart';
import 'package:online_groceries_admin/common/service_call.dart';
import 'package:online_groceries_admin/model/type_model.dart';
import 'package:online_groceries_admin/view/type_tab/type_add_screen.dart';

class TypeViewModel extends GetxController {
  final listArr = <TypeModel>[].obs;

  final catObj = TypeModel().obs;

  final txtName = TextEditingController().obs;
  final txtColor = TextEditingController().obs;
  final image = Rx<File?>(null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    txtColor.value.text = "BBBBBB";
    apiList();
  }

  //TODO: Action

  void clear() {
    txtName.value.text = "";
    txtColor.value.text = "";
    image.value = null;
  }

  void actionAdd(VoidCallback didDone) {
    if (txtName.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter type name");
      return;
    }

    if (txtColor.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter type bg color");
      return;
    }

    if (image.value == null) {
      Get.snackbar(Globs.appName, "Please select type image");
      return;
    }

    apiAdd({
      "type_name": txtName.value.text,
      "color": txtColor.value.text,
    }, {
      "image": image.value!
    }, didDone);
  }

  void actionEdit(TypeModel obj) {
    txtName.value.text = obj.typeName ?? "";
    txtColor.value.text = obj.colorString ?? "BBBBBB";

    catObj.value = obj;

    Get.to(() => const TypeAddScreen(
          isEdit: true,
        ));
    // Get.bottomSheet(
    //   AreaAddView(
    //     obj: zoneObj.value,
    //     isEdit: true,
    //   ),
    //   backgroundColor: Colors.transparent,
    //   isScrollControlled: true,
    // );
  }

  void actionUpdate(VoidCallback didDone) {
    if (txtName.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter type name");
      return;
    }

    if (txtColor.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter type bg color");
      return;
    }

    apiUpdate({
      "type_id": catObj.value.typeId?.toString() ?? "",
      "color": txtColor.value.text,
      "type_name": txtName.value.text,
    }, image.value != null ? {"image": image.value!} : null, didDone);
  }

  void actionDelete(TypeModel obj) {
    apiDelete({
      "type_id": obj.typeId?.toString() ?? "",
    });
  }

  //TODO: ApiCalling
  void apiList() {
    Globs.showHUD();
    ServiceCall.post({}, SVKey.svTypeList, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        listArr.value = (responseObj[KKey.payload] as List? ?? [])
            .map((e) => TypeModel.fromJson(e))
            .toList();
      } else {
        listArr.value = [];
      }
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(Globs.appName, err.toString());
    });
  }

  void apiAdd(Map<String, String> parameter, Map<String, File> imgObj,
      VoidCallback didDone) {
    Globs.showHUD();
    ServiceCall.multipart(parameter, SVKey.svTypeAdd,
        imgObj: imgObj, isToken: true, withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        txtName.value.text = "";
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

  void apiUpdate(Map<String, String> parameter, Map<String, File>? imgObj,
      VoidCallback didDone) {
    Globs.showHUD();
    ServiceCall.multipart(parameter, SVKey.svTypeUpdate,
        imgObj: imgObj, isToken: true, withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        txtName.value.text = "";
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
    ServiceCall.post(parameter, SVKey.svTypeDelete, isToken: true,
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
