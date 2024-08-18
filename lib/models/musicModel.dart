class MusicModel {
  List<Typemusic>? typemusic;
  List<Sing>? sing;
  List<More>? more;

  MusicModel({this.typemusic, this.sing, this.more});

  MusicModel.fromJson(Map<String, dynamic> json) {
    if (json['typemusic'] != null) {
      typemusic = <Typemusic>[];
      json['typemusic'].forEach((v) {
        typemusic!.add(Typemusic.fromJson(v));
      });
    }
    if (json['sing'] != null) {
      sing = <Sing>[];
      json['sing'].forEach((v) {
        sing!.add(Sing.fromJson(v));
      });
    }
    if (json['more'] != null) {
      more = <More>[];
      json['more'].forEach((v) {
        more!.add(More.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (typemusic != null) {
      data['typemusic'] = typemusic!.map((v) => v.toJson()).toList();
    }
    if (sing != null) {
      data['sing'] = sing!.map((v) => v.toJson()).toList();
    }
    if (more != null) {
      data['more'] = more!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Typemusic {
  int? id;
  int? placeId;
  int? musicId;
  String? createdAt;
  String? updatedAt;
  Music? music;

  Typemusic(
      {this.id,
      this.placeId,
      this.musicId,
      this.createdAt,
      this.updatedAt,
      this.music});

  Typemusic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    placeId = json['place_id'];
    musicId = json['music_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    music = json['music'] != null ? Music.fromJson(json['music']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['place_id'] = placeId;
    data['music_id'] = musicId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (music != null) {
      data['music'] = music!.toJson();
    }
    return data;
  }
}

class Music {
  int? id;
  String? typeMusic;
  int? price;
  String? createdAt;
  String? updatedAt;

  Music({this.id, this.typeMusic, this.price, this.createdAt, this.updatedAt});

  Music.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeMusic = json['type_music'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['type_music'] = typeMusic;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Sing {
  int? id;
  int? musicId;
  String? nameSinge;
  String? createdAt;
  String? updatedAt;

  Sing({this.id, this.musicId, this.nameSinge, this.createdAt, this.updatedAt});

  Sing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    musicId = json['music_id'];
    nameSinge = json['name_singe'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['music_id'] = musicId;
    data['name_singe'] = nameSinge;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class More {
  int? id;
  String? more;
  String? createdAt;
  String? updatedAt;

  More({this.id, this.more, this.createdAt, this.updatedAt});

  More.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    more = json['more'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['more'] = more;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

































// class MusicModel {
//   List<Typemusic>? typemusic;
//   List<Sing>? sing;
//   List<More>? more;

//   MusicModel({this.typemusic, this.sing, this.more});

//   MusicModel.fromJson(Map<String, dynamic> json) {
//     if (json['typemusic'] != null) {
//       typemusic = <Typemusic>[];
//       json['typemusic'].forEach((v) {
//         typemusic!.add(new Typemusic.fromJson(v));
//       });
//     }
//     if (json['sing'] != null) {
//       sing = <Sing>[];
//       json['sing'].forEach((v) {
//         sing!.add(new Sing.fromJson(v));
//       });
//     }
//     if (json['more'] != null) {
//       more = <More>[];
//       json['more'].forEach((v) {
//         more!.add(new More.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.typemusic != null) {
//       data['typemusic'] = this.typemusic!.map((v) => v.toJson()).toList();
//     }
//     if (this.sing != null) {
//       data['sing'] = this.sing!.map((v) => v.toJson()).toList();
//     }
//     if (this.more != null) {
//       data['more'] = this.more!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Typemusic {
//   int? id;
//   int? placeId;
//   int? musicId;
//   Null createdAt;
//   Null updatedAt;
//   Music? music;

//   Typemusic(
//       {this.id,
//       this.placeId,
//       this.musicId,
//       this.createdAt,
//       this.updatedAt,
//       this.music});

//   Typemusic.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     placeId = json['place_id'];
//     musicId = json['music_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     music = json['music'] != null ? new Music.fromJson(json['music']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['place_id'] = this.placeId;
//     data['music_id'] = this.musicId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.music != null) {
//       data['music'] = this.music!.toJson();
//     }
//     return data;
//   }
// }

// class Music {
//   int? id;
//   String? typeMusic;
//   int? price;
//   Null createdAt;
//   Null updatedAt;

//   Music({this.id, this.typeMusic, this.price, this.createdAt, this.updatedAt});

//   Music.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     typeMusic = json['type_music'];
//     price = json['price'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['type_music'] = this.typeMusic;
//     data['price'] = this.price;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }

// class Sing {
//   int? id;
//   int? musicId;
//   String? nameSinge;
//   Null createdAt;
//   Null updatedAt;

//   Sing({this.id, this.musicId, this.nameSinge, this.createdAt, this.updatedAt});

//   Sing.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     musicId = json['music_id'];
//     nameSinge = json['name_singe'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['music_id'] = this.musicId;
//     data['name_singe'] = this.nameSinge;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }

// class More {
//   int? id;
//   String? more;
//   String? createdAt;
//   String? updatedAt;

//   More({this.id, this.more, this.createdAt, this.updatedAt});

//   More.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     more = json['more'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['more'] = this.more;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
