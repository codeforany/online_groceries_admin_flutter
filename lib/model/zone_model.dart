class ZoneModel {
  int? zoneId;
  String? zoneName;

  ZoneModel({this.zoneId, this.zoneName});

  ZoneModel.fromJson(Map<String, dynamic> json) {
    zoneId = json["zone_id"];
    zoneName = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["zone_id"] = zoneId;
    data["name"] = zoneName;
    return data;
  }
}
