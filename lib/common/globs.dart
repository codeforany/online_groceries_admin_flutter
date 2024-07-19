import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

import '../main.dart';

class Globs {
  static const appName = "Online Groceries";

  static const userPayload = "user_payload";
  static const userLogin = "user_login";

  static void showHUD({String status = "loading ....."}) async {
    await Future.delayed(const Duration(milliseconds: 1));
    EasyLoading.show(status: status);
  }

  static void hideHUD() {
    EasyLoading.dismiss();
  }

  static void udSet(dynamic data, String key) {
    var jsonStr = json.encode(data);
    prefs?.setString(key, jsonStr);
  }

  static void udStringSet(String data, String key) {
    prefs?.setString(key, data);
  }

  static void udBoolSet(bool data, String key) {
    prefs?.setBool(key, data);
  }

  static void udIntSet(int data, String key) {
    prefs?.setInt(key, data);
  }

  static void udDoubleSet(double data, String key) {
    prefs?.setDouble(key, data);
  }

  static dynamic udValue(String key) {
    return json.decode(prefs?.get(key) as String? ?? "{}");
  }

  static String udValueString(String key) {
    return prefs?.get(key) as String? ?? "";
  }

  static bool udValueBool(String key) {
    return prefs?.get(key) as bool? ?? false;
  }

  static bool udValueTrueBool(String key) {
    return prefs?.get(key) as bool? ?? true;
  }

  static int udValueInt(String key) {
    return prefs?.get(key) as int? ?? 0;
  }

  static double udValueDouble(String key) {
    return prefs?.get(key) as double? ?? 0.0;
  }

  static void udRemove(String key) {
    prefs?.remove(key);
  }

  static Future<String> timeZone() async {
    try {
      return await FlutterTimezone.getLocalTimezone();
    } on PlatformException {
      return "";
    }
  }
}

class SVKey {
  static const mainUrl = "http://localhost:3001";
  static const baseUrl = '$mainUrl/api/admin/';
  static const nodeUrl = mainUrl;

  static const svLogin = '${baseUrl}login';

  static const svBrandAdd = '${baseUrl}brand_add';
  static const svBrandUpdate = '${baseUrl}brand_update';
  static const svBrandList = '${baseUrl}brand_list';
  static const svBrandDelete = '${baseUrl}brand_delete';

  static const svZoneAdd = '${baseUrl}zone_add';
  static const svZoneUpdate = '${baseUrl}zone_update';
  static const svZoneList = '${baseUrl}zone_list';
  static const svZoneDelete = '${baseUrl}zone_delete';

  static const svAreaAdd = '${baseUrl}area_add';
  static const svAreaUpdate = '${baseUrl}area_update';
  static const svAreaList = '${baseUrl}area_list';
  static const svAreaDelete = '${baseUrl}area_delete';

  static const svCategoryAdd = '${baseUrl}product_category_add';
  static const svCategoryUpdate = '${baseUrl}product_category_update';
  static const svCategoryList = '${baseUrl}product_category_list';
  static const svCategoryDelete = '${baseUrl}product_category_delete';

  static const svTypeAdd = '${baseUrl}product_type_add';
  static const svTypeUpdate = '${baseUrl}product_type_update';
  static const svTypeList = '${baseUrl}product_type_list';
  static const svTypeDelete = '${baseUrl}product_type_delete';

  static const svPromoCodeAdd = '${baseUrl}promo_code_add';
  static const svPromoCodeUpdate = '${baseUrl}promo_code_update';
  static const svPromoCodeList = '${baseUrl}promo_code_list';
  static const svPromoCodeDelete = '${baseUrl}promo_code_delete';

  static const svProductAdd = '${baseUrl}product_add';
  static const svProductUpdate = '${baseUrl}product_update';
  static const svProductList = '${baseUrl}product_list';
  static const svProductDelete = '${baseUrl}product_delete';

  static const svProductNutritionAdd = '${baseUrl}product_nutrition_add';
  static const svProductNutritionUpdate = '${baseUrl}product_nutrition_update';
  static const svProductNutritionDelete = '${baseUrl}product_nutrition_delete';
  static const svProductImageAdd = '${baseUrl}product_image_add';
  static const svProductImageDelete = '${baseUrl}product_image_delete';
  static const svProductDetail = '${baseUrl}product_detail';

  static const svProductCategoryBrandType =
      '${baseUrl}product_category_type_brand_list';

  static const svOfferAdd = '${baseUrl}offer_add';
  static const svOfferDelete = '${baseUrl}offer_delete';
  static const svOfferProductList = '${baseUrl}offer_product_list';

  static const svNewOrderList = '${baseUrl}new_orders_list';
  static const svCompleteOrderList = '${baseUrl}completed_orders_list';
  static const svCancelDeclineOrderList = '${baseUrl}cancel_decline_orders_list';

  static const svOrderDetail = '${baseUrl}order_detail';
  static const svOrderStatusChange = '${ baseUrl }order_status_change';

}

class KKey {
  static const payload = "payload";
  static const status = "status";
  static const message = "message";
  static const authToken = "auth_token";
  static const name = "name";
  static const email = "email";
  static const mobile = "mobile";
  static const address = "address";
  static const userId = "user_id";
  static const resetCode = "reset_code";
  // static const  = "";
  // static const  = "";
  // static const  = "";
  // static const  = "";
  // static const  = "";
  // static const  = "";
  // static const  = "";
  // static const  = "";
  // static const  = "";
  // static const  = "";
  // static const  = "";
  // static const  = "";
  // static const  = "";
  // static const  = "";
}

class MSG {
  static const enterEmail = "Please enter your valid email address.";
  static const enterName = "Please enter your name.";
  static const enterCode = "Please enter valid reset code.";

  static const enterMobile = "Please enter your valid mobile number.";
  static const enterAddress = "Please enter your address.";
  static const enterPassword =
      "Please enter password minimum 6 characters at least.";
  static const enterPasswordNotMatch = "Please enter password not match.";
  static const success = "success";
  static const fail = "fail";
}
