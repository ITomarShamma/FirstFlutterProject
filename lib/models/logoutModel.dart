class LogoutModel {
  bool? success;
  String? message;
  bool? data;
  Null? erros;
  int? status;

  LogoutModel({this.success, this.message, this.data, this.erros, this.status});

  LogoutModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'];
    erros = json['erros'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['data'] = this.data;
    data['erros'] = this.erros;
    data['status'] = this.status;
    return data;
  }
}
