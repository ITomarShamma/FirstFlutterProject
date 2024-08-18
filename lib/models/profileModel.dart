class profileModel {
  bool? success;
  String? message;
  ProfileData? data;
  Null? erros;
  int? status;

  profileModel(
      {this.success, this.message, this.data, this.erros, this.status});

  profileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new ProfileData.fromJson(json['data']) : null;
    erros = json['erros'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['erros'] = this.erros;
    data['status'] = this.status;
    return data;
  }
}

class ProfileData {
  int? id;
  String? fullName;
  String? email;
  Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  ProfileData(
      {this.id,
      this.fullName,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}







// class ProfileModel {
//   bool success;
//   String message;
//   Data data;
//   Null erros;
//   int status;

//   ProfileModel(
//       {this.success, this.message, this.data, this.erros, this.status});

//   ProfileModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//     erros = json['erros'];
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data.toJson();
//     }
//     data['erros'] = this.erros;
//     data['status'] = this.status;
//     return data;
//   }
// }

// class Data {
//   int id;
//   String fullName;
//   String email;
//   Null emailVerifiedAt;
//   String createdAt;
//   String updatedAt;

//   Data(
//       {this.id,
//       this.fullName,
//       this.email,
//       this.emailVerifiedAt,
//       this.createdAt,
//       this.updatedAt});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     fullName = json['full_name'];
//     email = json['email'];
//     emailVerifiedAt = json['email_verified_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['full_name'] = this.fullName;
//     data['email'] = this.email;
//     data['email_verified_at'] = this.emailVerifiedAt;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }