class AreaResponse {
  bool? success;
  String? message;
  List<AreaData>? data;
  Null erros;
  int? status;

  AreaResponse(
      {this.success, this.message, this.data, this.erros, this.status});

  AreaResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AreaData>[];
      json['data'].forEach((v) {
        data!.add(AreaData.fromJson(v));
      });
    }
    erros = json['erros'];
    status = json['status'];
  }
}

class AreaData {
  int? id;
  String? name;
  int? townId;
  String? createdAt;
  String? updatedAt;

  AreaData({this.id, this.name, this.townId, this.createdAt, this.updatedAt});

  AreaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    townId = json['town_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
