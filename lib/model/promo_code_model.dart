class PromoCodeModel {
  int? promoCodeId;
  String? code;
  String? title;
  String? description;
  int? type;
  int? minOrderAmount;
  int? maxDiscountAmount;
  int? offerPrice;
  String? startDate;
  String? endDate;
  String? createdDate;
  String? modifyDate;

  PromoCodeModel(
      {this.promoCodeId,
      this.code,
      this.title,
      this.description,
      this.type,
      this.minOrderAmount,
      this.maxDiscountAmount,
      this.offerPrice,
      this.startDate,
      this.endDate,
      this.createdDate,
      this.modifyDate});

  PromoCodeModel.fromJson(Map<String, dynamic> json) {
    promoCodeId = json['promo_code_id'];
    code = json['code'];
    title = json['title'];
    description = json['description'];
    type = json['type'];
    minOrderAmount = json['min_order_amount'];
    maxDiscountAmount = json['max_discount_amount'];
    offerPrice = json['offer_price'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdDate = json['created_date'];
    modifyDate = json['modify_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['promo_code_id'] = promoCodeId;
    data['code'] = code;
    data['title'] = title;
    data['description'] = description;
    data['type'] = type;
    data['min_order_amount'] = minOrderAmount;
    data['max_discount_amount'] = maxDiscountAmount;
    data['offer_price'] = offerPrice;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['created_date'] = createdDate;
    data['modify_date'] = modifyDate;
    return data;
  }
}
