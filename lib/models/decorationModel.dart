class DecorationModel {
  List<ChairsNumber>? chairsNumber;
  List<TableesNumber>? tableesNumber;
  List<Lighting>? lighting;
  List<Theme>? theme;
  List<ThemeColor>? themeColor;

  DecorationModel({
    this.chairsNumber,
    this.tableesNumber,
    this.lighting,
    this.theme,
    this.themeColor,
  });

  DecorationModel.fromJson(Map<String, dynamic> json) {
    if (json['ChairsNumber'] != null) {
      chairsNumber = <ChairsNumber>[];
      json['ChairsNumber'].forEach((v) {
        chairsNumber!.add(ChairsNumber.fromJson(v));
      });
    }
    if (json['TableesNumber'] != null) {
      tableesNumber = <TableesNumber>[];
      json['TableesNumber'].forEach((v) {
        tableesNumber!.add(TableesNumber.fromJson(v));
      });
    }
    if (json['Lighting'] != null) {
      lighting = <Lighting>[];
      json['Lighting'].forEach((v) {
        lighting!.add(Lighting.fromJson(v));
      });
    }
    if (json['Theme'] != null) {
      theme = <Theme>[];
      json['Theme'].forEach((v) {
        theme!.add(Theme.fromJson(v));
      });
    }
    if (json['ThemeColor'] != null) {
      themeColor = <ThemeColor>[];
      json['ThemeColor'].forEach((v) {
        themeColor!.add(ThemeColor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (chairsNumber != null) {
      data['ChairsNumber'] = chairsNumber!.map((v) => v.toJson()).toList();
    }
    if (tableesNumber != null) {
      data['TableesNumber'] = tableesNumber!.map((v) => v.toJson()).toList();
    }
    if (lighting != null) {
      data['Lighting'] = lighting!.map((v) => v.toJson()).toList();
    }
    if (theme != null) {
      data['Theme'] = theme!.map((v) => v.toJson()).toList();
    }
    if (themeColor != null) {
      data['ThemeColor'] = themeColor!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChairsNumber {
  int? id;
  int? placeId;
  int? charId;
  String? createdAt;
  String? updatedAt;
  Char? char;

  ChairsNumber({
    this.id,
    this.placeId,
    this.charId,
    this.createdAt,
    this.updatedAt,
    this.char,
  });

  ChairsNumber.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    placeId = json['place_id'];
    charId = json['char_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    char = json['char'] != null ? Char.fromJson(json['char']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['place_id'] = placeId;
    data['char_id'] = charId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (char != null) {
      data['char'] = char!.toJson();
    }
    return data;
  }
}

class Char {
  int? id;
  int? num;
  int? price;
  String? createdAt;
  String? updatedAt;

  Char({this.id, this.num, this.price, this.createdAt, this.updatedAt});

  Char.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    num = json['num'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['num'] = num;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class TableesNumber {
  int? id;
  int? placeId;
  int? tableId;
  String? createdAt;
  String? updatedAt;
  Char? table;

  TableesNumber({
    this.id,
    this.placeId,
    this.tableId,
    this.createdAt,
    this.updatedAt,
    this.table,
  });

  TableesNumber.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    placeId = json['place_id'];
    tableId = json['table_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    table = json['table'] != null ? Char.fromJson(json['table']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['place_id'] = placeId;
    data['table_id'] = tableId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (table != null) {
      data['table'] = table!.toJson();
    }
    return data;
  }
}

class Lighting {
  // Define Lighting model as per the API response structure
  Lighting.fromJson(Map<String, dynamic> json) {
    // Parse JSON
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // Convert to JSON
    return data;
  }
}

class Theme {
  int? id;
  String? typeTheme;
  int? price;
  String? createdAt;
  String? updatedAt;

  Theme({this.id, this.typeTheme, this.price, this.createdAt, this.updatedAt});

  Theme.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeTheme = json['type_theme'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type_theme'] = typeTheme;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ThemeColor {
  int? id;
  String? type;
  int? price;
  String? createdAt;
  String? updatedAt;

  ThemeColor({this.id, this.type, this.price, this.createdAt, this.updatedAt});

  ThemeColor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
