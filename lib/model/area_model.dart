class AreaModel {
  int? areaId;
  String? areaName;
  int? zoneId;
  String? zoneName;

  AreaModel({this.areaId, this.areaName, this.zoneId, this.zoneName});

  AreaModel.fromJson(Map<String, dynamic> json) {
    areaId = json["area_id"];
    areaName = json["name"];

    zoneId = json["zone_id"];
    zoneName = json["zone_name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["area_id"] = zoneId;
    data["name"] = areaName;
    data["zone_id"] = zoneId;
    data["zone_name"] = zoneName;
    return data;
  }
}
