class LoginModel {
  bool? success;
  String? message;
  Data? data;
  Null? erros;
  int? status;

  LoginModel({this.success, this.message, this.data, this.erros, this.status});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  int? id;
  String? fullName;
  String? email;
  Null? emailVerifiedAt;
  int? wallet;
  String? createdAt;
  String? updatedAt;
  String? token;
  User? user;

  Data(
      {this.id,
      this.fullName,
      this.email,
      this.emailVerifiedAt,
      this.wallet,
      this.createdAt,
      this.updatedAt,
      this.token,
      this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    wallet = json['wallet'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['wallet'] = this.wallet;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? email;
  String? password;

  User({this.email, this.password});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
















// class LoginModel {
//   bool? success;
//   String? message;
//   Data? data;
//   int? status;

//   LoginModel({this.success, this.message, this.data, this.status});

//   LoginModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//     status = json['status'];
//   }
// }

// class Data {
//   String? token;
//   User? user;
//   int? wallet; // Add the wallet field

//   Data({this.token, this.user, this.wallet}); // Add wallet to the constructor

//   Data.fromJson(Map<String, dynamic> json) {
//     token = json['token'];
//     user = json['user'] != null ? User.fromJson(json['user']) : null;
//     wallet = json['wallet']; // Deserialize wallet
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['token'] = this.token;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     data['wallet'] = this.wallet; // Serialize wallet
//     return data;
//   }
// }

// class User {
//   String? fullName;
//   String? email;
//   String? password;

//   User({this.fullName, this.email, this.password});

//   User.fromJson(Map<String, dynamic> json) {
//     fullName = json['full_name'];
//     email = json['email'];
//     password = json['password'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['full_name'] = this.fullName;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     return data;
//   }
// }
