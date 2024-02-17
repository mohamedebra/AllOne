// import 'package:freezed_annotation/freezed_annotation.dart';
// part 'model_products.g.dart';
// @JsonSerializable()
// class Country {
//   final String name;
//   final List<City> cities;
//
//   Country(this.name, this.cities);
//   factory Country.fromJson(Map<String , dynamic> json) => _$CountryFromJson(json);
//
// }
//
// @JsonSerializable()
// class City {
//   final String name;
//   final List<ProductItems> products;
//
//   City(this.name, this.products);
//   factory City.fromJson(Map<String , dynamic> json) => _$CityFromJson(json);
//
// }
// @JsonSerializable()
// class ProductItems {
//   int? id;
//   String? name;
//   String? image;
//   String? details;
//   String? category;
//   double? lang;
//   double? lati;
//
//   ProductItems({this.name, this.image, this.details,this.category,this.id,this.lati,this.lang});
//
//   factory ProductItems.fromJson(Map<String , dynamic> json) => _$ProductItemsFromJson(json);
// }
//
//
//
// @JsonSerializable()
// class Category{
//   String? name;
//   String? image;
//   Category({
//     this.name,
//     this.image
//   });
//   factory Category.fromJson(Map<String , dynamic> json) => _$CategoryFromJson(json);
// }
//
// List<Category> itemsCategory =[
//   Category(
//       name: 'Restaurants',
//       image: 'asstes/icons/fast-food-restaurant-png.png'
//   ),
//   Category(
//       name: 'Supermarket',
//       image: 'asstes/icons/icons8-supermarket-64.png'
//   ),
//   Category(
//       name: 'Other',
//       image: 'asstes/icons/10357967.png'
//   ),
// ];
//
// List<Country> countries = [
//   Country(
//     "مصر",
//     [
//       City("القاهره", productOfCityCairo),
//       City("اسكندريه", productOfCityAlix),
//     ],
//   ),
//   Country(
//     "",
//     [
//       City("دبي", productOfCityDuobe),
//       City("ابوظبي", productOfCityApoZapy),
//     ],
//   ),
// ];
//
// List<ProductItems> productItems = [
//   ProductItems(
//       id: 0,
//       name : 'Dierbergs markets',
//       image : 'asstes/images/3.jpg',
//       details : 'Discounts on most foods',
//       category: 'Supermarket',
//       lang: 55.1746406,
//       lati: 25.16371532
//   ),
//   ProductItems(
//     id: 1,
//     name: 'Steakhouse Oasis',
//     details: 'Discounts on most foods',
//     image: 'asstes/images/restaurana.jpg',
//     category: 'Restaurants',
//
//     lang: 31.02537,
//     lati: 31.22306,
//   ),
//   ProductItems(
//     id: 2,
//     name : 'Fresh Express',
//     image : 'asstes/images/3.jpg',
//     details : 'Discounts on most foods',
//     category: 'Supermarket',
//
//   ),
//   ProductItems(
//     id: 3,
//     name: 'Steakhouse Oasis',
//     details: 'Discounts on most foods',
//     image: 'asstes/images/restaurana2.jpg',
//     category: 'Restaurants',
//
//   ),
//   ProductItems(
//     id: 4,
//     name: 'Steakhouse Oasis',
//     details: 'Discounts on most foods',
//     image: 'asstes/images/restaurana.jpg',
//     category: 'Restaurants',
//
//   ),
//   ProductItems(
//     id: 5,
//     name : 'Grocery Haven',
//     image : 'asstes/images/2.jpg',
//     details : 'Discounts on most foods',
//     category: 'Supermarket',
//
//   ),
//   ProductItems(
//     id: 6,
//     name: 'Steakhouse Oasis',
//     details: 'Discounts on most foods',
//     image: 'asstes/images/restaurana.jpg',
//     category: 'Restaurants',
//
//   ),
// ];
// List<ProductItems> productOfCityCairo = [
//   ProductItems(
//       id: 0,
//       name : 'Dierbergs markets',
//       image : 'asstes/images/3.jpg',
//       details : 'Discounts on most foods',
//       category: 'Supermarket',
//       lang: 55.1746406,
//       lati: 25.16371532
//   ),
//   ProductItems(
//     id: 1,
//     name: 'Steakhouse Oasis',
//     details: 'Discounts on most foods',
//     image: 'asstes/images/restaurana.jpg',
//     category: 'Restaurants',
//
//     lang: 31.02537,
//     lati: 31.22306,
//   ),
// ];
// List<ProductItems> productOfCityAlix = [
//   ProductItems(
//       id: 0,
//       name : 'Dierbergs markets',
//       image : 'asstes/images/3.jpg',
//       details : 'Discounts on most foods',
//       category: 'Supermarket',
//       lang: 55.1746406,
//       lati: 25.16371532
//   ),
//   ProductItems(
//     id: 1,
//     name: 'Steakhouse Oasis',
//     details: 'Discounts on most foods',
//     image: 'asstes/images/restaurana.jpg',
//     category: 'Restaurants',
//
//     lang: 31.02537,
//     lati: 31.22306,
//   ),
//   ProductItems(
//     id: 1,
//     name: 'ateakhouse Oasis',
//     details: 'Discounts on most foods',
//     image: 'asstes/images/restaurana.jpg',
//     category: 'Restaurants',
//
//     lang: 31.02537,
//     lati: 31.22306,
//   ),
// ];
// List<ProductItems> productOfCityDuobe = [
//   ProductItems(
//       id: 0,
//       name : 'Dierbergs markets',
//       image : 'asstes/images/3.jpg',
//       details : 'Discounts on most foods',
//       category: 'Supermarket',
//       lang: 55.1746406,
//       lati: 25.16371532
//   ),
//   ProductItems(
//     id: 1,
//     name: 'Steakhouse Oasis',
//     details: 'Discounts on most foods',
//     image: 'asstes/images/restaurana.jpg',
//     category: 'Restaurants',
//
//     lang: 31.02537,
//     lati: 31.22306,
//   ),
//   ProductItems(
//       id: 0,
//       name : 'Dierbergs markets',
//       image : 'asstes/images/3.jpg',
//       details : 'Discounts on most foods',
//       category: 'Supermarket',
//       lang: 55.1746406,
//       lati: 25.16371532
//   ),
//   ProductItems(
//     id: 1,
//     name: 'Steakhouse Oasis',
//     details: 'Discounts on most foods',
//     image: 'asstes/images/restaurana.jpg',
//     category: 'Restaurants',
//
//     lang: 31.02537,
//     lati: 31.22306,
//   ),
// ];
// List<ProductItems> productOfCityApoZapy = [
//   ProductItems(
//       id: 0,
//       name : 'aierbergs markets',
//       image : 'asstes/images/3.jpg',
//       details : 'Discounts on most foods',
//       category: 'Supermarket',
//       lang: 55.1746406,
//       lati: 25.16371532
//   ),
//   ProductItems(
//     id: 1,
//     name: 'Steakhouse Oasis',
//     details: 'Discounts on most foods',
//     image: 'asstes/images/restaurana.jpg',
//     category: 'Restaurants',
//
//     lang: 31.02537,
//     lati: 31.22306,
//   ),
//   ProductItems(
//     id: 1,
//     name: 'ateakhouse Oasis',
//     details: 'Discounts on most foods',
//     image: 'asstes/images/restaurana.jpg',
//     category: 'Restaurants',
//
//     lang: 31.02537,
//     lati: 31.22306,
//   ),
//   ProductItems(
//     id: 1,
//     name: 'Steakhouse Oasis',
//     details: 'Discounts on most foods',
//     image: 'asstes/images/restaurana.jpg',
//     category: 'Restaurants',
//
//     lang: 31.02537,
//     lati: 31.22306,
//   ),
//   ProductItems(
//     id: 1,
//     name: 'Steakhouse Oasis',
//     details: 'Discounts on most foods',
//     image: 'asstes/images/restaurana.jpg',
//     category: 'Restaurants',
//
//     lang: 31.02537,
//     lati: 31.22306,
//   ),
// ];