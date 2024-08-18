class Month {
  bool? success;
  String? massege;
  List<String>? month;
  Null? erros;
  int? status;

  Month({this.success, this.massege, this.month, this.erros, this.status});

  Month.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    massege = json['massege'];
    month = json['month'].cast<String>();
    erros = json['erros'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['massege'] = this.massege;
    data['month'] = this.month;
    data['erros'] = this.erros;
    data['status'] = this.status;
    return data;
  }
}
