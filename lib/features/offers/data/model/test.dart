import 'package:all_one/features/home/data/model/product_offer.dart';

class Country {
  final int id;
  final int? categoryId;
  final int sort;
  final String? title;
  final List<City>? city;
  List<TranslationsListCountry>? translations;


  Country({
    required this.id,
    required this.categoryId,
    required this.sort,
    required this.title,
    required this.city,
    this.translations
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    List<City>? childrenRecursive;
    if (json['children_recursive'] != null) {
      childrenRecursive = List<City>.from(json['children_recursive']
          .map((category) => City.fromJson(category)));
    }
    List<TranslationsListCountry> translations;
    if (json['translations'] != null) {
      translations = List<TranslationsListCountry>.from(json['translations']
          .map((category) => TranslationsListCountry.fromJson(category)));
    }

    return Country(
      id: json['id'],
      categoryId: json['category_id'],
      sort: json['sort'],
      title: json['title'],
      city: childrenRecursive,
    );
  }
}

class City {
  final int id;
  final int? categoryId;
  final int sort;
  final String? title;
  final List<ProductOffers>? items;


  City({
    required this.id,
    required this.categoryId,
    required this.sort,
    required this.title,
    required this.items,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    List<ProductOffers>? items;
    if (json['items'] != null) {
      items = List<ProductOffers>.from(
          json['items'].map((item) => ProductOffers.fromJson(item)));
    }

    return City(
      id: json['id'],
      categoryId: json['category_id'],
      sort: json['sort'],
      title: json['title'],
      items: items,
    );
  }
}


class TranslationCity {
  final int id;
  final String title;
  final String locale;

  TranslationCity({
    required this.id,
    required this.title,
    required this.locale,
  });

  factory TranslationCity.fromJson(Map<String, dynamic> json) {
    return TranslationCity(
      id: json['id'],
      title: json['title'],
      locale: json['locale'],
    );
  }
}
class TranslationsListCountry {
  int? id;
  int? categoryId;
  String? title;
  String? locale;

  TranslationsListCountry({this.id, this.categoryId, this.title, this.locale});

  TranslationsListCountry.fromJson(Map<String, dynamic> json) {
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
