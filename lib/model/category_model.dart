import 'package:flutter/material.dart';
import 'package:online_groceries_admin/common/color_extension.dart';

class CategoryModel {
  int? catId;
  String? catName;
  String? image;
  Color? color;
  String? colorString;

  CategoryModel({this.catId, this.catName, this.color, this.image});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    catId = json["cat_id"];
    catName = json["cat_name"];

    color = HexColor.fromHex(json['color'].toString());
    colorString = json['color'].toString();
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["cat_id"] = color;
    data["cat_name"] = catName;
    data['color'] = color?.toHex();
    data["image"] = image;
    return data;
  }
}
