class FoodModel {
  List<MainMeal>? mainMeal;
  List<SweateType>? sweateType;
  List<MainCake>? mainCake;

  FoodModel({this.mainMeal, this.sweateType, this.mainCake});

  FoodModel.fromJson(Map<String, dynamic> json) {
    if (json['mainMeal'] != null) {
      mainMeal = <MainMeal>[];
      json['mainMeal'].forEach((v) {
        mainMeal!.add(new MainMeal.fromJson(v));
      });
    }
    if (json['SweateType'] != null) {
      sweateType = <SweateType>[];
      json['SweateType'].forEach((v) {
        sweateType!.add(new SweateType.fromJson(v));
      });
    }
    if (json['MainCake'] != null) {
      mainCake = <MainCake>[];
      json['MainCake'].forEach((v) {
        mainCake!.add(new MainCake.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mainMeal != null) {
      data['mainMeal'] = this.mainMeal!.map((v) => v.toJson()).toList();
    }
    if (this.sweateType != null) {
      data['SweateType'] = this.sweateType!.map((v) => v.toJson()).toList();
    }
    if (this.mainCake != null) {
      data['MainCake'] = this.mainCake!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MainMeal {
  int? id;
  int? placeId;
  int? foodTypeId;
  int? sweateTypeId;
  int? mainCakeId;
  Null? createdAt;
  Null? updatedAt;
  FoodType? foodType;

  MainMeal(
      {this.id,
      this.placeId,
      this.foodTypeId,
      this.sweateTypeId,
      this.mainCakeId,
      this.createdAt,
      this.updatedAt,
      this.foodType});

  MainMeal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    placeId = json['place_id'];
    foodTypeId = json['food_type_id'];
    sweateTypeId = json['sweate_type_id'];
    mainCakeId = json['main_cake_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    foodType = json['food_type'] != null
        ? new FoodType.fromJson(json['food_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['place_id'] = this.placeId;
    data['food_type_id'] = this.foodTypeId;
    data['sweate_type_id'] = this.sweateTypeId;
    data['main_cake_id'] = this.mainCakeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.foodType != null) {
      data['food_type'] = this.foodType!.toJson();
    }
    return data;
  }
}

class FoodType {
  int? id;
  String? name;
  int? price;
  Null? createdAt;
  Null? updatedAt;

  FoodType({this.id, this.name, this.price, this.createdAt, this.updatedAt});

  FoodType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class SweateType {
  int? id;
  int? placeId;
  int? foodTypeId;
  int? sweateTypeId;
  int? mainCakeId;
  Null? createdAt;
  Null? updatedAt;
  FoodType? sweateType;

  SweateType(
      {this.id,
      this.placeId,
      this.foodTypeId,
      this.sweateTypeId,
      this.mainCakeId,
      this.createdAt,
      this.updatedAt,
      this.sweateType});

  SweateType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    placeId = json['place_id'];
    foodTypeId = json['food_type_id'];
    sweateTypeId = json['sweate_type_id'];
    mainCakeId = json['main_cake_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sweateType = json['sweate_type'] != null
        ? new FoodType.fromJson(json['sweate_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['place_id'] = this.placeId;
    data['food_type_id'] = this.foodTypeId;
    data['sweate_type_id'] = this.sweateTypeId;
    data['main_cake_id'] = this.mainCakeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.sweateType != null) {
      data['sweate_type'] = this.sweateType!.toJson();
    }
    return data;
  }
}

class MainCake {
  int? id;
  int? placeId;
  int? foodTypeId;
  int? sweateTypeId;
  int? mainCakeId;
  Null? createdAt;
  Null? updatedAt;
  FoodType? mainCake;

  MainCake(
      {this.id,
      this.placeId,
      this.foodTypeId,
      this.sweateTypeId,
      this.mainCakeId,
      this.createdAt,
      this.updatedAt,
      this.mainCake});

  MainCake.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    placeId = json['place_id'];
    foodTypeId = json['food_type_id'];
    sweateTypeId = json['sweate_type_id'];
    mainCakeId = json['main_cake_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mainCake = json['main_cake'] != null
        ? new FoodType.fromJson(json['main_cake'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['place_id'] = this.placeId;
    data['food_type_id'] = this.foodTypeId;
    data['sweate_type_id'] = this.sweateTypeId;
    data['main_cake_id'] = this.mainCakeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.mainCake != null) {
      data['main_cake'] = this.mainCake!.toJson();
    }
    return data;
  }
}
