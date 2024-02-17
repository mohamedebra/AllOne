class AdsModel {
  List<DataAds>? data;

  AdsModel({this.data});

  AdsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataAds>[];
      json['data'].forEach((v) {
        data!.add(new DataAds.fromJson(v));
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

class DataAds {
  int? id;
  String? image;
  Null? url;
  int? visible;
  Null? sort;
  int? status;
  Null? offer;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? description;
  List<TranslationsAds>? translations;

  DataAds(
      {this.id,
        this.image,
        this.url,
        this.visible,
        this.sort,
        this.status,
        this.offer,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.title,
        this.description,
        this.translations});

  DataAds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    url = json['url'];
    visible = json['visible'];
    sort = json['sort'];
    status = json['status'];
    offer = json['offer'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
    description = json['description'];
    if (json['translations'] != null) {
      translations = <TranslationsAds>[];
      json['translations'].forEach((v) {
        translations!.add(new TranslationsAds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['url'] = this.url;
    data['visible'] = this.visible;
    data['sort'] = this.sort;
    data['status'] = this.status;
    data['offer'] = this.offer;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.translations != null) {
      data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TranslationsAds {
  int? id;
  int? bannerId;
  String? title;
  String? description;
  String? locale;

  TranslationsAds(
      {this.id, this.bannerId, this.title, this.description, this.locale});

  TranslationsAds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerId = json['banner_id'];
    title = json['title'];
    description = json['description'];
    locale = json['locale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner_id'] = this.bannerId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['locale'] = this.locale;
    return data;
  }
}