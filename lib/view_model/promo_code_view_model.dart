import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/extension.dart';
import 'package:online_groceries_admin/common/globs.dart';
import 'package:online_groceries_admin/common/service_call.dart';
import 'package:online_groceries_admin/model/promo_code_model.dart';
import 'package:online_groceries_admin/view/account_tab/promo_code/promo_code_add_view.dart';

class PromoCodeViewModel extends GetxController {
  final listArr = <PromoCodeModel>[].obs;
  final promoObj = PromoCodeModel().obs;

  final txtCode = TextEditingController().obs;
  final txtTitle = TextEditingController().obs;
  final txtDescription = TextEditingController().obs;
  final txtMinOrderAmount = TextEditingController().obs;
  final txtMaxDiscountAmount = TextEditingController().obs;
  final txtOfferPrice = TextEditingController().obs;

  final selectType = 1.obs;
  final selectStartDate = DateTime.now().obs;
  final selectEndDate = DateTime.now().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  //TODO: Action

  void actionOpenAddNew(){
     txtCode.value.text = "";
     txtTitle.value.text = "";
     txtDescription.value.text = "";
     txtMinOrderAmount.value.text = "";
     txtMaxDiscountAmount.value.text = "";
     txtOfferPrice.value.text = "";

     selectType.value = 1;
     selectStartDate.value = DateTime.now();
     selectEndDate.value = DateTime.now();
     Get.to(() => const PromoCodeAddScreen());
  }

  void actionAdd(VoidCallback didDone) {
    if (txtCode.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter promo code");
      return;
    }

    if (txtTitle.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter promo code title");
      return;
    }

    if (txtDescription.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter promo code description");
      return;
    }

    if (txtMinOrderAmount.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter min order amount");
      return;
    }

    if (txtMaxDiscountAmount.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter max discount amount");
      return;
    }

    if (txtOfferPrice.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter offer amount");
      return;
    }

    apiAdd({
      "code": txtCode.value.text,
      "title": txtTitle.value.text,
      "description": txtDescription.value.text,
      "start_date": selectStartDate.value.stringFormat(),
      "end_date": selectEndDate.value.stringFormat(),
      "type": selectType.value.toString(),
      "min_order_amount": txtMinOrderAmount.value.text,
      "max_discount_amount": txtMaxDiscountAmount.value.text,
      "offer_price": txtOfferPrice.value.text,
    }, didDone);
  }

  void actionEdit(PromoCodeModel obj) {
    txtCode.value.text = obj.code ?? "";
    txtTitle.value.text = obj.title ?? "";
    txtDescription.value.text = obj.description ?? "";
    txtMinOrderAmount.value.text = (obj.minOrderAmount ?? 0).toString();
    txtMaxDiscountAmount.value.text = (obj.maxDiscountAmount ?? 0).toString();
    txtOfferPrice.value.text = (obj.offerPrice ?? 0).toString();

    selectType.value = obj.type ?? 1;
    selectStartDate.value = obj.startDate?.dataFormat() ?? DateTime.now();
    selectEndDate.value = obj.endDate?.dataFormat() ?? DateTime.now();

    promoObj.value = obj;

    Get.to(() => const PromoCodeAddScreen(
          isEdit: true,
        ));
  }

  void actionUpdate(VoidCallback didDone) {
    if (txtTitle.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter promo code title");
      return;
    }

    if (txtDescription.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter promo code description");
      return;
    }

    if (txtMinOrderAmount.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter min order amount");
      return;
    }

    if (txtMaxDiscountAmount.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter max discount amount");
      return;
    }

    if (txtOfferPrice.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter offer amount");
      return;
    }

    apiUpdate({
      "promo_code_id": promoObj.value.promoCodeId?.toString() ?? "",
      "title": txtTitle.value.text,
      "description": txtDescription.value.text,
      "start_date": selectStartDate.value.stringFormat(),
      "end_date": selectEndDate.value.stringFormat(),
      "type": selectType.value.toString(),
      "min_order_amount": txtMinOrderAmount.value.text,
      "max_discount_amount": txtMaxDiscountAmount.value.text,
      "offer_price": txtOfferPrice.value.text,
    }, didDone);
  }

  void actionDelete(PromoCodeModel obj) {
    apiDelete({
      "promo_code_id": obj.promoCodeId?.toString() ?? "",
    });
  }

  //TODO: ApiCalling
  void apiList() {
    Globs.showHUD();
    ServiceCall.post({}, SVKey.svPromoCodeList, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        listArr.value = (responseObj[KKey.payload] as List? ?? [])
            .map((e) => PromoCodeModel.fromJson(e))
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
    ServiceCall.post(parameter, SVKey.svPromoCodeAdd, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        txtCode.value.text = "";
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
    ServiceCall.post(parameter, SVKey.svPromoCodeUpdate, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        txtCode.value.text = "";
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
    ServiceCall.post(parameter, SVKey.svPromoCodeDelete, isToken: true,
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
