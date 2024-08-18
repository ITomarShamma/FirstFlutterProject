class Date {
  bool? success;
  String? message;
  List<DateData>? data;
  Null? erros;
  int? status;

  Date({this.success, this.message, this.data, this.erros, this.status});

  Date.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DateData>[];
      json['data'].forEach((v) {
        data!.add(new DateData.fromJson(v));
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

class DateData {
  int? id;
  int? placeId;
  String? month;
  String? day;
  String? date;
  String? dateStart;
  String? dateFinish;
  String? status;
  Null? createdAt;
  String? updatedAt;

  DateData(
      {this.id,
      this.placeId,
      this.month,
      this.day,
      this.date,
      this.dateStart,
      this.dateFinish,
      this.status,
      this.createdAt,
      this.updatedAt});

  DateData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    placeId = json['place_id'];
    month = json['month'];
    day = json['day'];
    date = json['date'];
    dateStart = json['date_start'];
    dateFinish = json['date_finish'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['place_id'] = this.placeId;
    data['month'] = this.month;
    data['day'] = this.day;
    data['date'] = this.date;
    data['date_start'] = this.dateStart;
    data['date_finish'] = this.dateFinish;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
