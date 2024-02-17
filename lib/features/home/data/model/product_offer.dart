class ProductOffers {
  List<DataProduct>? data;

  ProductOffers({this.data});

  factory ProductOffers.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      return ProductOffers(
        data: (json['data'] as List<dynamic>)
            ?.map((e) => DataProduct.fromJson(e))
            ?.toList(),
      );
    } else {
      return ProductOffers();
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

class DataProduct {
  int? id;
  Null? sku;
  double? maxCount;
  Null? weight;
  Null? videoUrl;
  Null? videoText;
  Null? shipweight;
  double? price;
  Null? net;
  Null? stock;
  Null? discount;
  Null? discountnum;
  Null? disEndDate;
  int? typeId;
  int? delivary;
  String? created_at;
  Null? countryId;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? title;
  Null? description;
  List<Files>? files;
  List<CategoriesData>? categories;
  TypesProduct? types;
  List<TranslationsProduct>? translations;

  DataProduct(
      {this.id,
        this.sku,
        this.maxCount,
        this.weight,
        this.videoUrl,
        this.videoText,
        this.shipweight,
        this.created_at,
        this.price,
        this.net,
        this.stock,
        this.discount,
        this.discountnum,
        this.disEndDate,
        this.typeId,
        this.delivary,
        this.countryId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.title,
        this.description,
        this.files,
        this.categories,
        this.types,
        this.translations});

  factory DataProduct.fromJson(Map<String, dynamic> json) => DataProduct(
    id: json['id'],
    sku: json['sku'],
    created_at: json['created_at'],
    maxCount: json['max_count'],
    weight: json['weight'],
    videoUrl: json['video_url'],
    videoText: json['video_text'],
    shipweight: json['shipweight'],
    price: json['price'],
    net: json['net'],
    stock: json['stock'],
    discount: json['discount'],
    discountnum: json['discountnum'],
    disEndDate: json['dis_end_date'],
    typeId: json['type_id'],
    delivary: json['delivary'],
    countryId: json['country_id'],
    status: json['status'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
    title: json['title'],
    description: json['description'],
    files: json['files'] != null ? List<Files>.from(json['files'].map((v) => Files.fromJson(v))) : null,
    categories: json['categories'] != null ? List<CategoriesData>.from(json['categories'].map((v) => CategoriesData.fromJson(v))) : null,
    types: json['types'] != null ? TypesProduct.fromJson(json['types']) : null,
    translations: json['translations'] != null ? List<TranslationsProduct>.from(json['translations'].map((v) => TranslationsProduct.fromJson(v))) : null,
  );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sku'] = this.sku;
    data['created_at'] = this.created_at;
    data['max_count'] = this.maxCount;
    data['weight'] = this.weight;
    data['video_url'] = this.videoUrl;
    data['video_text'] = this.videoText;
    data['shipweight'] = this.shipweight;
    data['price'] = this.price;
    data['net'] = this.net;
    data['stock'] = this.stock;
    data['discount'] = this.discount;
    data['discountnum'] = this.discountnum;
    data['dis_end_date'] = this.disEndDate;
    data['type_id'] = this.typeId;
    data['delivary'] = this.delivary;
    data['country_id'] = this.countryId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.types != null) {
      data['types'] = this.types!.toJson();
    }
    if (this.translations != null) {
      data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Files {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? fileId;
  String? fileType;
  String? image;
  int? main;

  Files(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.fileId,
        this.fileType,
        this.image,
        this.main});

  Files.fromJson(Map<String, dynamic> json) {
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

class CategoriesData {
  int? id;
  int? categoryId;
  int? sort;
  String? createdAt;
  String? updatedAt;
  Null? title;
  Pivot? pivot;
  List<TranslationsProduct>? translations;

  CategoriesData(
      {this.id,
        this.categoryId,
        this.sort,
        this.createdAt,
        this.updatedAt,
        this.title,
        this.pivot,
        this.translations});

  factory CategoriesData.fromJson(Map<String, dynamic> json) => CategoriesData(
    id: json['id'],
    categoryId: json['category_id'],
    sort: json['sort'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
    title: json['title'],
    pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
    translations: json['translations'] != null ? List<TranslationsProduct>.from(json['translations'].map((v) => TranslationsProduct.fromJson(v))) : null,
  );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['sort'] = this.sort;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['title'] = this.title;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    if (this.translations != null) {
      data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pivot {
  int? itemId;
  int? categoryId;

  Pivot({this.itemId, this.categoryId});

  Pivot.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['category_id'] = this.categoryId;
    return data;
  }
}

class TranslationsProduct {
  int? id;
  int? categoryId;
  String? title;
  String? locale;

  TranslationsProduct({this.id, this.categoryId, this.title, this.locale});

  TranslationsProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    locale = json['locale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['title'] = this.title;
    data['locale'] = this.locale;
    return data;
  }
}
class TranslationsData {
  int? id;
  int? typeId;
  String? title;
  String? locale;

  TranslationsData({this.id, this.typeId, this.title, this.locale});

  factory TranslationsData.fromJson(Map<String, dynamic> json) => TranslationsData(
    id: json['id'],
    typeId: json['type_id'],
    title: json['title'],
    locale: json['locale'],
  );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.typeId;
    data['title'] = this.title;
    data['locale'] = this.locale;
    return data;
  }
}

class TypesProduct {
  int? id;
  int? sort;
  String? createdAt;
  String? updatedAt;
  String? title;
  List<TranslationsData>? translations;

  TypesProduct(
      {this.id,
        this.sort,
        this.createdAt,
        this.updatedAt,
        this.title,
        this.translations});

  factory TypesProduct.fromJson(Map<String, dynamic> json) => TypesProduct(
    id: json['id'],
    sort: json['sort'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
    title: json['title'],
    translations: json['translations'] != null
        ? List<TranslationsData>.from(json['translations'].map((v) => TranslationsData.fromJson(v)))
        : null,
  );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sort'] = this.sort;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['title'] = this.title;
    if (this.translations != null) {
      data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Translation{
  int? id;
  int? itemId;
  String? title;
  Null? description;
  String? locale;

  Translation(
      {this.id, this.itemId, this.title, this.description, this.locale});

  Translation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    title = json['title'];
    description = json['description'];
    locale = json['locale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['locale'] = this.locale;
    return data;
  }
}