
import '../../../home/data/model/product_offer.dart';

class CountryApi {
  List<Country> country;

  CountryApi({required this.country});

  factory CountryApi.fromJson(Map<String, dynamic> json) {
    if (json['parent_categories'] != null) {
      return CountryApi(
        country: (json['parent_categories'] as List<dynamic>)
            ?.map((e) => Country.fromJson(e))
            .toList() ?? [], // Provide a default empty list if null
      );
    } else {
      return CountryApi(country: []);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.country != null) {
      data['parent_categories'] = this.country!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}
class Country {
  int? id;
  int? sort;
  List<City>? city;
  List<TranslationsCountry>? translations;

  Country(
      {this.id,
        this.sort,
        this.city,
        this.translations});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sort = json['sort'];
    if (json['children_recursive'] != null) {
      city = <City>[];
      json['children_recursive'].forEach((v) {
        city!.add(new City.fromJson(v));
      });
    }
    if (json['translations'] != null) {
      translations = <TranslationsCountry>[];
      json['translations'].forEach((v) {
        translations!.add(new TranslationsCountry.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sort'] = this.sort;
    if (this.city != null) {
      data['children_recursive'] =
          this.city!.map((v) => v.toJson()).toList();
    }
    if (this.translations != null) {
      data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  int? id;
  List<DataProduct>? items;
  List<TranslationsCity>? translations;

  City(
      {this.id,
        this.items,
        this.translations});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    if (json['items'] != null) {
      items = <DataProduct>[];
      json['items'].forEach((v) {
        items!.add(new DataProduct.fromJson(v));
      });
    }
    if (json['translations'] != null) {
      translations = <TranslationsCity>[];
      json['translations'].forEach((v) {
        translations!.add(new TranslationsCity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.translations != null) {
      data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TranslationsCity {
  int? id;
  int? itemId;
  String? title;
  Null? description;
  String? locale;

  TranslationsCity(
      {this.id, this.itemId, this.title, this.description, this.locale});

  TranslationsCity.fromJson(Map<String, dynamic> json) {
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

class TranslationsCountry {
  int? id;
  int? categoryId;
  String? title;
  String? locale;

  TranslationsCountry({this.id, this.categoryId, this.title, this.locale});

  TranslationsCountry.fromJson(Map<String, dynamic> json) {
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


