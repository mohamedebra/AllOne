class Types {
  List<Data>? data;

  Types({this.data});

  Types.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? sort;
  String? title;
  Images? image;
  List<TranslationLang>? translations;

  Data({this.id, this.sort, this.title, this.image, this.translations});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sort = json['sort'];
    title = json['title'];
    image = json['image'] != null ? new Images.fromJson(json['image']) : null;
    if (json['translations'] != null) {
      translations = <TranslationLang>[];
      json['translations'].forEach((v) {
        translations!.add(new TranslationLang.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sort'] = this.sort;
    data['title'] = this.title;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    if (this.translations != null) {
      data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? fileId;
  String? fileType;
  String? image;
  int? main;

  Images(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.fileId,
        this.fileType,
        this.image,
        this.main});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fileId = json['file_id'];
    fileType = json['file_type'];
    image = json['image'];
    main = json['main'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['file_id'] = this.fileId;
    data['file_type'] = this.fileType;
    data['image'] = this.image;
    data['main'] = this.main;
    return data;
  }
}

class TranslationLang {
  int? id;
  int? typeId;
  String? title;
  String? locale;

  TranslationLang({this.id, this.typeId, this.title, this.locale});

  TranslationLang.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeId = json['type_id'];
    title = json['title'];
    locale = json['locale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type_id'] = this.typeId;
    data['title'] = this.title;
    data['locale'] = this.locale;
    return data;
  }
}