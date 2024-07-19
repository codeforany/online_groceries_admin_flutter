class OfferModel {
  int? offerId;
  int? prodId;
  double? price;
  String? startDate;
  String? endDate;
  String? createdDate;
  String? modifyDate;

  OfferModel(
      {this.offerId,
      this.price,
      this.startDate,
      this.endDate,
      this.createdDate,
      this.modifyDate});

  OfferModel.fromJson(Map<String, dynamic> json) {
    offerId = json['offer_id'];
    prodId = json['prod_id'];
    price = double.tryParse(json['price'].toString()) ?? 0.0;
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdDate = json['created_date'];
    modifyDate = json['modify_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['offer_id'] = offerId;
    data['prod_id'] = prodId;
    data['price'] = price;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['created_date'] = createdDate;
    data['modify_date'] = modifyDate;
    return data;
  }
}
