import 'dart:ui';

import '../common/color_extension.dart';

class TypeModel {
  int? typeId;
  String? typeName;
  String? image;
  Color? color;
  String? colorString;

  TypeModel({this.typeId, this.typeName, this.image, this.color});

  TypeModel.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    typeName = json['type_name'];
    image = json['image'];
    colorString = json['color'];
    color = HexColor.fromHex(json['color'].toString())  ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['type_id'] = typeId;
    data['type_name'] = typeName;
    data['image'] = image;
    data['color'] = color?.toHex();
    return data;
  }
}
