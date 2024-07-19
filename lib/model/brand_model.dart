class BrandModel {
  int? brandId;
  String? brandName;

  BrandModel({this.brandId, this.brandName});

  BrandModel.fromJson(Map<String, dynamic> json) {
    brandId = json["brand_id"];
    brandName = json["brand_name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["brand_id"] = brandId;
    data["brand_name"] = brandName;
    return data;
  }
}
