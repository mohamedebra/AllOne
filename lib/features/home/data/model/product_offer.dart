
import 'package:hive/hive.dart';
part 'product_offer.g.dart';
class ProductOffers{
  ProductOffersA? data;
  ProductOffers({this.data});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();



    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }

    return data;
  }
  factory ProductOffers.fromJson(Map<String, dynamic> json) => ProductOffers(
    data: json['data'] != null ? ProductOffersA.fromJson(json['data']) : null,
  );

}
class ProductOffersA {
  List<DataProduct>? data;

  ProductOffersA({this.data});

  factory ProductOffersA.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      return ProductOffersA(
        data: (json['data'] as List<dynamic>)
            ?.map((e) => DataProduct.fromJson(e))
            ?.toList(),
      );
    } else {
      return ProductOffersA();
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
@HiveType(typeId: 4)
class DataProduct {
  @HiveField(0)
  int? id;
  @HiveField(1)
  double? price;
  @HiveField(2)
  String? weight;
  @HiveField(3)
  double? maxCount;
  @HiveField(4)
  int? typeId;
  @HiveField(5)
  int? delivary;
  @HiveField(6)
  String? created_at;
  @HiveField(7)
  int? status;
  @HiveField(8)
  String? createdAt;
  @HiveField(9)
  String? updatedAt;
  @HiveField(10)
  String? title;
  @HiveField(11)
  List<Files>? files;
  @HiveField(12)
  List<CategoriesData>? categories;
  @HiveField(13)
  TypesProduct? types;
  @HiveField(14)
  List<TranslationsProduct>? translations;

  DataProduct(
      {this.id,
        this.maxCount,
        this.weight,
        this.created_at,
        this.price,
        this.typeId,
        this.delivary,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.title,
        this.files,
        this.categories,
        this.types,
        this.translations});

  factory DataProduct.fromJson(Map<String, dynamic> json) => DataProduct(
    id: json['id'],
    created_at: json['created_at'],
    maxCount: json['max_count'],
    weight: json['weight'],
    price: json['price'],
    typeId: json['type_id'],
    delivary: json['delivary'],
    status: json['status'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
    title: json['title'],
    files: json['files'] != null ? List<Files>.from(json['files'].map((v) => Files.fromJson(v))) : null,
    categories: json['categories'] != null ? List<CategoriesData>.from(json['categories'].map((v) => CategoriesData.fromJson(v))) : null,
    types: json['types'] != null ? TypesProduct.fromJson(json['types']) : null,
    translations: json['translations'] != null ? List<TranslationsProduct>.from(json['translations'].map((v) => TranslationsProduct.fromJson(v))) : null,
  );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.created_at;
    data['max_count'] = this.maxCount;
    data['weight'] = this.weight;
    data['price'] = this.price;
    data['type_id'] = this.typeId;
    data['delivary'] = this.delivary;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['title'] = this.title;
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
  Pivot? pivot;
  List<TranslationsProduct>? translations;

  CategoriesData(
      {this.id,
        this.categoryId,
        this.sort,
        this.createdAt,
        this.updatedAt,
        this.pivot,
        this.translations});

  factory CategoriesData.fromJson(Map<String, dynamic> json) => CategoriesData(
    id: json['id'],
    categoryId: json['category_id'],
    sort: json['sort'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
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
  String? locale;

  Translation(
      {this.id, this.itemId, this.title, this.locale});

  Translation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    title = json['title'];
    locale = json['locale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['title'] = this.title;
    data['locale'] = this.locale;
    return data;
  }
}