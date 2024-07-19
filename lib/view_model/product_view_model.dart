import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_admin/common/globs.dart';
import 'package:online_groceries_admin/common/service_call.dart';
import 'package:online_groceries_admin/model/image_model.dart';
import 'package:online_groceries_admin/model/nutrition_model.dart';
import 'package:online_groceries_admin/model/product_detail_model.dart';
import 'package:online_groceries_admin/view/product_tab/product_information_update_screen.dart';

class ProductViewModel extends GetxController {
  final listArr = <ProductDetailModel>[].obs;

  final pObj = ProductDetailModel().obs;

  final txtName = TextEditingController().obs;
  final txtDetail = TextEditingController().obs;
  final txtUnitName = TextEditingController().obs;
  final txtUnitValue = TextEditingController().obs;
  final txtNutritionWeight = TextEditingController().obs;
  final txtPrice = TextEditingController().obs;

  final selectCategory = Rx<Map?>(null);
  final selectType = Rx<Map?>(null);
  final selectBrand = Rx<Map?>(null);
  final nutritionList = <NutritionModel>[].obs;
  final imageList = <File>[].obs;

  final productDetailObj = Rx<ProductDetailModel?>(null);
  final productNutritionList = <NutritionModel>[].obs;
  final productImages = <ImageModel>[].obs;

  final categoryList = [].obs;
  final brandList = [].obs;
  final typeList = [].obs;

  final selectImage = Rx<File?>(null);

  final selectNutritionObj = Rx<NutritionModel?>(null);
  final txtNutritionName = TextEditingController().obs;
  final txtNutritionValue = TextEditingController().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    apiList();
    apiCategoryTypeBrand();
  }

  //TODO: Action

  void clear() {
    txtName.value.text = "";
    txtDetail.value.text = "";
    txtUnitName.value.text = "";
    txtUnitValue.value.text = "";
    txtPrice.value.text = "";
    txtNutritionWeight.value.text = "";
    selectBrand.value = null;
    selectType.value = null;
    selectCategory.value = null;

    nutritionList.clear();
    imageList.clear();
  }

  void actionAdd(VoidCallback didDone) {
    if (txtName.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter product name");
      return;
    }

    if (txtDetail.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter product details");
      return;
    }

    if (selectCategory.value == null) {
      Get.snackbar(Globs.appName, "Please select category");
      return;
    }

    if (selectBrand.value == null) {
      Get.snackbar(Globs.appName, "Please select brand");
      return;
    }

    if (selectType.value == null) {
      Get.snackbar(Globs.appName, "Please select product type");
      return;
    }

    if (txtUnitName.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter product unit name");
      return;
    }

    if (txtUnitValue.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter product unit value");
      return;
    }

    if (txtNutritionWeight.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter product nutrition weight");
      return;
    }

    if (txtPrice.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter product price");
      return;
    }

    if (imageList.isEmpty) {
      Get.snackbar(Globs.appName, "Please select product image at list one");
      return;
    }

    Map<File, String> imgObj = {};

    for (var element in imageList) {
      imgObj[element] = "image";
    }

    apiAdd({
      "name": txtName.value.text,
      "detail": txtDetail.value.text,
      "cat_id": selectCategory.value?["cat_id"]?.toString() ?? "",
      "brand_id": selectBrand.value?["brand_id"]?.toString() ?? "",
      "type_id": selectType.value?["type_id"]?.toString() ?? "",
      "unit_name": txtUnitName.value.text,
      "unit_value": txtUnitValue.value.text,
      "nutrition_weight": txtNutritionWeight.value.text,
      "price": txtPrice.value.text,
      "nutrition_data":
          jsonEncode(nutritionList.map((element) => element.toJson()).toList()),
    }, imgObj, didDone);
  }

  void actionEdit(ProductDetailModel obj) {
    txtName.value.text = obj.name ?? "";
    txtDetail.value.text = obj.detail ?? "";
    txtUnitName.value.text = obj.unitName ?? "";
    txtUnitValue.value.text = obj.unitValue ?? "";
    txtPrice.value.text = obj.price?.toString() ?? "";
    txtNutritionWeight.value.text = obj.nutritionWeight ?? "";

    selectBrand.value = brandList.firstWhere(
        (element) => (element["brand_id"] ?? -1) == (obj.brandId ?? 0));
    selectType.value = typeList.firstWhere(
      (element) => (element["type_id"] ?? -1) == (obj.typeId ?? 0),
    );
    selectCategory.value = categoryList
        .firstWhere((element) => (element["cat_id"] ?? -1) == (obj.catId ?? 0));

    pObj.value = obj;

    actionApiCallDetail();

    Get.to(() => const ProductInfoUpdateScreen());
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
      Get.snackbar(Globs.appName, "Please enter product name");
      return;
    }

    if (txtDetail.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter product details");
      return;
    }

    if (selectCategory.value == null) {
      Get.snackbar(Globs.appName, "Please select category");
      return;
    }

    if (selectBrand.value == null) {
      Get.snackbar(Globs.appName, "Please select brand");
      return;
    }

    if (selectType.value == null) {
      Get.snackbar(Globs.appName, "Please select product type");
      return;
    }

    if (txtUnitName.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter product unit name");
      return;
    }

    if (txtUnitValue.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter product unit value");
      return;
    }

    if (txtNutritionWeight.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter product nutrition weight");
      return;
    }

    if (txtPrice.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please enter product price");
      return;
    }

    apiUpdate({
      "prod_id": pObj.value.prodId?.toString() ?? "",
      "name": txtName.value.text,
      "detail": txtDetail.value.text,
      "cat_id": selectCategory.value?["cat_id"]?.toString() ?? "",
      "brand_id": selectBrand.value?["brand_id"]?.toString() ?? "",
      "type_id": selectType.value?["type_id"]?.toString() ?? "",
      "unit_name": txtUnitName.value.text,
      "unit_value": txtUnitValue.value.text,
      "nutrition_weight": txtNutritionWeight.value.text,
      "price": txtPrice.value.text,
    }, didDone);
  }

  void actionDelete(ProductDetailModel obj) {
    apiDelete({
      "prod_id": obj.prodId?.toString() ?? "",
    });
  }

  void actionOpenDetail(ProductDetailModel obj) {
    productDetailObj.value = null;
    productNutritionList.value = [];
    productImages.value = [];
    pObj.value = obj;

    actionApiCallDetail();
  }

  void actionApiCallDetail() {
    apiProductDetail({"prod_id": pObj.value.prodId?.toString() ?? ""});
  }

  void actionNewNutritionAdd() {
    if (txtNutritionName.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please Enter Product Nutrition Name");
      return;
    }

    if (txtNutritionValue.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please Enter Product Nutrition Value");
      return;
    }

    nutritionList.add(NutritionModel(
        nutritionName: txtNutritionName.value.text,
        nutritionValue: txtNutritionValue.value.text));

    txtNutritionName.value.text = "";
    txtNutritionValue.value.text = "";
  }

  void actionNewNutritionDelete(NutritionModel obj) {
    nutritionList.remove(obj);
  }

  void actionNutritionAdd(VoidCallback didDone) {
    if (productDetailObj.value == null) {
      Get.snackbar(Globs.appName, "Product Id is Missing");
      return;
    }

    if (txtNutritionName.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Please Enter Product Nutrition Name");
      return;
    }

    if (txtNutritionValue.value.text.isEmpty) {
      Get.snackbar(Globs.appName, " Please Enter Product Nutrition Value");
      return;
    }

    apiNutritionAdd({
      "prod_id": productDetailObj.value?.prodId?.toString() ?? "",
      "nutrition_name": txtNutritionName.value.text,
      "nutrition_value": txtNutritionValue.value.text,
    }, didDone);
  }

  void actionNutritionEdit(NutritionModel obj) {
    txtNutritionName.value.text = obj.nutritionName ?? "";
    txtNutritionValue.value.text = obj.nutritionValue ?? "";
    selectNutritionObj.value = obj;

    // Get.bottomSheet(
    //   AreaAddView(
    //     obj: zoneObj.value,
    //     isEdit: true,
    //   ),
    //   backgroundColor: Colors.transparent,
    //   isScrollControlled: true,
    // );
  }

  void actionNutritionUpdate(VoidCallback didDone) {
    if (selectNutritionObj.value == null) {
      Get.snackbar(Globs.appName, "Nutrition Id is Missing");
      return;
    }

    if (txtNutritionName.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Product Nutrition Name");
      return;
    }

    if (txtNutritionValue.value.text.isEmpty) {
      Get.snackbar(Globs.appName, "Product Nutrition Value");
      return;
    }

    apiNutritionUpdate({
      "nutrition_id": selectNutritionObj.value?.nutritionId?.toString() ?? "",
      "prod_id": selectNutritionObj.value?.prodId?.toString() ?? "",
      "nutrition_name": txtNutritionName.value.text,
      "nutrition_value": txtNutritionValue.value.text,
    }, didDone);
  }

  void actionNutritionDelete(NutritionModel obj) {
    apiNutritionDelete({
      "prod_id": obj.prodId?.toString() ?? "",
      "nutrition_id": obj.nutritionId?.toString() ?? "",
    });
  }

  void actionImageAdd(VoidCallback didDone) {
    if (productDetailObj.value == null) {
      Get.snackbar(Globs.appName, "Product Id is Missing");
      return;
    }

    if (selectImage.value == null) {
      Get.snackbar(Globs.appName, "Please select Product Image");
      return;
    }

    apiImageAdd({
      "prod_id": productDetailObj.value?.prodId?.toString() ?? "",
    }, {
      "image": selectImage.value!
    }, didDone);
  }

  void actionImageDelete(ImageModel obj) {
    apiImageDelete({
      "prod_id": obj.prodId?.toString() ?? "",
      "img_id": obj.imgId?.toString() ?? "",
    });
  }

  //TODO: ApiCalling
  void apiList() {
    Globs.showHUD();
    ServiceCall.post({}, SVKey.svProductList, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        listArr.value = (responseObj[KKey.payload] as List? ?? [])
            .map((e) => ProductDetailModel.fromJson(e))
            .toList();
      } else {
        listArr.value = [];
      }
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(Globs.appName, err.toString());
    });
  }

  void apiAdd(Map<String, String> parameter, Map<File, String> imgObj,
      VoidCallback didDone) {
    Globs.showHUD();
    ServiceCall.multipartNew(parameter, SVKey.svProductAdd,
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

  void apiUpdate(Map<String, String> parameter, VoidCallback didDone) {
    Globs.showHUD();
    ServiceCall.post(parameter, SVKey.svProductUpdate, isToken: true,
        withSuccess: (responseObj) async {
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
    ServiceCall.post(parameter, SVKey.svProductDelete, isToken: true,
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

  void apiImageAdd(Map<String, String> parameter, Map<String, File> imgObj,
      VoidCallback didDone) {
    Globs.showHUD();
    ServiceCall.multipart(parameter, SVKey.svProductImageAdd,
        imgObj: imgObj, isToken: true, withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        Get.snackbar(
            Globs.appName, responseObj[KKey.message] as String? ?? MSG.success);
        selectImage.value = null;
        didDone();
        actionApiCallDetail();
      } else {
        Get.snackbar(
            Globs.appName, responseObj[KKey.message] as String? ?? MSG.fail);
      }
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(Globs.appName, err.toString());
    });
  }

  void apiImageDelete(Map<String, String> parameter) {
    Globs.showHUD();
    ServiceCall.post(parameter, SVKey.svProductImageDelete, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        Get.snackbar(
            Globs.appName, responseObj[KKey.message] as String? ?? MSG.success);
        actionApiCallDetail();
      } else {
        Get.snackbar(
            Globs.appName, responseObj[KKey.message] as String? ?? MSG.fail);
      }
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(Globs.appName, err.toString());
    });
  }

  void apiNutritionAdd(Map<String, String> parameter, VoidCallback didDone) {
    Globs.showHUD();
    ServiceCall.post(parameter, SVKey.svProductNutritionAdd, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        Get.snackbar(
            Globs.appName, responseObj[KKey.message] as String? ?? MSG.success);
        didDone();
        actionApiCallDetail();
      } else {
        Get.snackbar(
            Globs.appName, responseObj[KKey.message] as String? ?? MSG.fail);
      }
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(Globs.appName, err.toString());
    });
  }

  void apiNutritionUpdate(Map<String, String> parameter, VoidCallback didDone) {
    Globs.showHUD();
    ServiceCall.post(parameter, SVKey.svProductNutritionUpdate, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        Get.snackbar(
            Globs.appName, responseObj[KKey.message] as String? ?? MSG.success);
        didDone();
        actionApiCallDetail();
      } else {
        Get.snackbar(
            Globs.appName, responseObj[KKey.message] as String? ?? MSG.fail);
      }
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(Globs.appName, err.toString());
    });
  }

  void apiNutritionDelete(Map<String, String> parameter) {
    Globs.showHUD();
    ServiceCall.post(parameter, SVKey.svProductNutritionDelete, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        Get.snackbar(
            Globs.appName, responseObj[KKey.message] as String? ?? MSG.success);
        actionApiCallDetail();
      } else {
        Get.snackbar(
            Globs.appName, responseObj[KKey.message] as String? ?? MSG.fail);
      }
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(Globs.appName, err.toString());
    });
  }

  void apiProductDetail(Map<String, String> parameter) {
    Globs.showHUD();
    ServiceCall.post(parameter, SVKey.svProductDetail, isToken: true,
        withSuccess: (responseObj) async {
      Globs.hideHUD();

      if (responseObj[KKey.status] == "1") {
        var payload = responseObj[KKey.payload] as Map? ?? {};

        productDetailObj.value = ProductDetailModel.fromJson(payload);
        productNutritionList.value = (payload["nutrition_list"] as List? ?? [])
            .map((e) => NutritionModel.fromJson(e))
            .toList();
        productImages.value = (payload["images"] as List? ?? [])
            .map((e) => ImageModel.fromJson(e))
            .toList();
      } else {
        Get.snackbar(
            Globs.appName, responseObj[KKey.message] as String? ?? MSG.fail);
      }
    }, failure: (err) async {
      Globs.hideHUD();
      Get.snackbar(Globs.appName, err.toString());
    });
  }

  void apiCategoryTypeBrand() {
    ServiceCall.post({}, SVKey.svProductCategoryBrandType, isToken: true,
        withSuccess: (responseObj) async {
      if (responseObj[KKey.status] == "1") {
        var payload = responseObj[KKey.payload] as Map? ?? {};

        categoryList.value = payload["category_list"] as List? ?? [];
        brandList.value = payload["brand_list"] as List? ?? [];
        typeList.value = payload["type_list"] as List? ?? [];
      } else {
        Get.snackbar(
            Globs.appName, responseObj[KKey.message] as String? ?? MSG.fail);
      }
    }, failure: (err) async {
      Get.snackbar(Globs.appName, err.toString());
    });
  }
}
