import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/globs.dart';
import 'package:online_groceries_admin/common/service_call.dart';
import 'package:online_groceries_admin/model/category_model.dart';
import 'package:online_groceries_admin/view/category_tab/category_add_screen.dart';

class CategoryViewModel extends GetxController {
  final listArr = <CategoryModel>[].obs;

  final catObj = CategoryModel().obs;

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
      Get.snackbar(Globs.appName, "Please enter category name");
      return;
    }

    if (txtColor.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter category bg color");
      return;
    }

    if (image.value == null) {
      Get.snackbar(Globs.appName, "Please select category image");
      return;
    }

    apiAdd({
      "cat_name": txtName.value.text,
      "color": txtColor.value.text,
    }, {
      "image": image.value!
    }, didDone);
  }

  void actionEdit(CategoryModel obj) {
    txtName.value.text = obj.catName ?? "";
    txtColor.value.text = obj.colorString ?? "BBBBBB";

    catObj.value = obj;

    Get.to(() => const CategoryAddScreen(
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
      Get.snackbar(Globs.appName, "Please enter category name");
      return;
    }

    if (txtColor.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter category bg color");
      return;
    }

    apiUpdate({
      "cat_id": catObj.value.catId?.toString() ?? "",
      "color": txtColor.value.text,
      "cat_name": txtName.value.text,
    }, image.value != null ? {"image": image.value!} : null, didDone);
  }

  void actionDelete(CategoryModel obj) {
    apiDelete({
      "cat_id": obj.catId?.toString() ?? "",
    });
  }

  //TODO: ApiCalling
  void apiList() {
    Globs.showHUD();
    ServiceCall.post({}, SVKey.svCategoryList, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        listArr.value = (responseObj[KKey.payload] as List? ?? [])
            .map((e) => CategoryModel.fromJson(e))
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
    ServiceCall.multipart(parameter, SVKey.svCategoryAdd,
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
    ServiceCall.multipart(parameter, SVKey.svCategoryUpdate,
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
    ServiceCall.post(parameter, SVKey.svCategoryDelete, isToken: true,
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
