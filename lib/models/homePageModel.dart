class TypeEvent {
  bool? success;
  String? message;
  List<HomeData>? data;
  Null? erros;
  int? status;

  TypeEvent({this.success, this.message, this.data, this.erros, this.status});

  TypeEvent.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <HomeData>[];
      json['data'].forEach((v) {
        data!.add(new HomeData.fromJson(v));
      });
    }
    erros = json['erros'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['erros'] = this.erros;
    data['status'] = this.status;
    return data;
  }
}

class HomeData {
  int? id;
  String? typeEvent;
  String? createdAt;
  String? updatedAt;

  HomeData({this.id, this.typeEvent, this.createdAt, this.updatedAt});

  HomeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeEvent = json['type_event'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type_event'] = this.typeEvent;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
