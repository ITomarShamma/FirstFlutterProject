class Budget1 {
  bool? success;
  String? message;
  List<BudgetData>? data;
  Null? erros;
  int? status;

  Budget1({this.success, this.message, this.data, this.erros, this.status});

  Budget1.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BudgetData>[];
      json['data'].forEach((v) {
        data!.add(BudgetData.fromJson(v));
      });
    }
    erros = json['erros'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['erros'] = erros;
    data['status'] = status;
    return data;
  }
}

class BudgetData {
  int? id;
  int? areaId;
  int? budgetId;
  Null? createdAt;
  Null? updatedAt;
  Budget? budget;

  BudgetData(
      {this.id,
      this.areaId,
      this.budgetId,
      this.createdAt,
      this.updatedAt,
      this.budget});

  BudgetData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    areaId = json['area_id'];
    budgetId = json['budget_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    budget = json['budget'] != null ? Budget.fromJson(json['budget']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['area_id'] = areaId;
    data['budget_id'] = budgetId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (budget != null) {
      data['budget'] = budget!.toJson();
    }
    return data;
  }
}

class Budget {
  int? id;
  String? classify;
  String? createdAt;
  String? updatedAt;

  Budget({this.id, this.classify, this.createdAt, this.updatedAt});

  Budget.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classify = json['classify'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['classify'] = classify;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}




























// class Budget1 {
//   bool? success;
//   String? message;
//   List<Data2>? data;
//   Null? erros;
//   int? status;

//   Budget1({this.success, this.message, this.data, this.erros, this.status});

//   Budget1.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data2>[];
//       json['data'].forEach((v) {
//         data!.add(new Data2.fromJson(v));
//       });
//     }
//     erros = json['erros'];
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['erros'] = this.erros;
//     data['status'] = this.status;
//     return data;
//   }
// }

// class Data2 {
//   int? id;
//   int? areaId;
//   int? budgetId;
//   Null? createdAt;
//   Null? updatedAt;
//   Budget? budget;

//   Data2(
//       {this.id,
//       this.areaId,
//       this.budgetId,
//       this.createdAt,
//       this.updatedAt,
//       this.budget});

//   Data2.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     areaId = json['area_id'];
//     budgetId = json['budget_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     budget =
//         json['budget'] != null ? new Budget.fromJson(json['budget']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['area_id'] = this.areaId;
//     data['budget_id'] = this.budgetId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.budget != null) {
//       data['budget'] = this.budget!.toJson();
//     }
//     return data;
//   }
// }

// class Budget {
//   int? id;
//   String? classify;
//   String? createdAt;
//   String? updatedAt;

//   Budget({this.id, this.classify, this.createdAt, this.updatedAt});

//   Budget.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     classify = json['classify'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['classify'] = this.classify;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }











// class BudgetData {
//   int? id;
//   String? classify;
//   String? createdAt;
//   String? updatedAt;

//   BudgetData({this.id, this.classify, this.createdAt, this.updatedAt});

//   BudgetData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     classify = json['classify'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['classify'] = this.classify;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
