// import 'package:all_one/core/networks/api_service.dart';
// import 'package:all_one/features/home/data/model/model_types.dart';
// import 'package:all_one/features/offers/data/model/city_model.dart';
// import 'package:all_one/features/offers/data/model/model_country.dart';
// import 'package:all_one/features/offers/logic/offers_cubit.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../core/helper/chache_helper.dart';
// import '../../home/data/model/model_products.dart';
// import '../../home/data/model/product_offer.dart';
// import '../data/repo/offer_repo.dart';
// import 'package:http/http.dart' as http;
//
// class OffersScreenController extends GetxController{
//   final OfferRepo offerRepo;
//
//   OffersScreenController(this.offerRepo);
//   var productList = <ProductOffers>[].obs;
//   var typesProduct = <Types>[].obs;
//   var allProducts = <ProductOffers>[].obs;
//   var displayedProducts = <ProductOffers>[].obs;
//
//   var countryList = <CountryApi>[].obs;
//   var countryListCity = <CountryListApi>[].obs;
//   List<CityListApi> selectedCountryCities = [];
//   List selectedCategories = [];
//   Dio dio = Dio();
//
//   String? selectedCountry;
//   String? selectedCity;
//   TextEditingController searchController = TextEditingController();
//   List<ProductOffers> selectedCityProducts = [];
//   var offercubit = OffersCubit(OfferRepo(ApiService(Dio())));
//
//   var offer = OffersCubit(OfferRepo(ApiService(Dio())));
//   List categories = [];
//   final lang = CacheHelper.getData(key: 'lang');
//
//   @override
//   void onInit() {
//     // fetchProduct();
//     // fetchCountry();
//     // fetchProduct();
//     // fetchCountry();
//     // fetchCategory();
//     allProducts.assignAll(productList); // Assuming productItems is your initial list
//
//     super.onInit();
//   }
//
//   void fetchProduct() async {
//     // isLoading.value = true;
//
//     try {
//       final result = await offerRepo.getProduct();
//
//       result.when(
//         success: (types) {
//           productList.add(ProductOffers.fromJson(types.toJson())); // Use add to append to the list
//                    print('productList${productList[0].data!.length}');
//         },
//         failure: (error) {
//           print("Error fetching posts: $error");
//         },
//       );
//     } catch (error) {
//       print("Error fetching posts: $error");
//     }
//
//   }
//   Future<void> fetchData() async {
//     try {
//       final response = await dio.get('http://app.misrgidda.com/api/items'); // Replace with your API endpoint
//
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data['data'];
//         productList.assignAll(data.map((item) => ProductOffers.fromJson(item)).toList());
//         print(productList[1].data);
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (error) {
//       print('Error fetching data: $error');
//     }
//   }
//   void fetchCategory() {
//     for (ProductOffers obj in productList) {
//       for (DataProduct dataProduct in obj.data!) {
//         for(TranslationsData typesProduct in dataProduct.types!.translations!) {
//           var title = typesProduct.locale;
//           if(title == 'ar'){
//             if (!categories.contains(typesProduct.title)) {
//               categories.add(typesProduct.title);
//               print(typesProduct.title);
//             }
//           }
//         }
//         print(dataProduct.title);
//
//       }
//     }
//   }
//
//
//   void fetchTypes() async {
//     // isLoading.value = true;
//
//     try {
//       final result = await offerRepo.getTypes();
//
//       result.when(
//         success: (types) {
//           typesProduct.add(types); // Use assignAll directly on the list
//         },
//         failure: (error) {
//           print("Error fetching posts: $error");
//         },
//       );
//     } catch (error) {
//       print("Error fetching posts: $error");
//     }
//
//   }
//   void fetchCountry() async {
//     // isLoading.value = true;
//
//     try {
//       final result = await offerRepo.getCountry();
//
//       result.when(
//         success: (types) {
//           countryListCity.addAll(CountryApi.fromJson(types.toJson()).countryListApi!);
//           print('countryListCity${countryListCity[0].cityListApi!.length}');
//           update();
//         },
//         failure: (error) {
//           print(error.apiErrorModel.message);
//           update();
//           },
//       );
//     } catch (error) {
//       print("Error fetching posts: $error");
//     }
//
//   }
//   void updateDisplayedProducts() {
//     List<ProductOffers> tempProducts = List<ProductOffers>.from(allProducts);
//
//     // Filter by selected country's cities if a country is selected
//     if (selectedCountry?.isNotEmpty == true) {
//       print(selectedCountry);
//       List<CityListApi>? countryCities = countryListCity
//           .firstWhere(
//               (country) => country.translations!.firstWhere((element) => element.locale!.endsWith('ar'),
//               orElse: () => TranslationsListCountry()).title == selectedCountry)
//           .cityListApi;
//       print(countryCities);
//
//
//       tempProducts = countryCities!.expand((city) => city.items!).toList();
//       selectedCountryCities.addAll(countryCities);
//     }
//
//     // Further filter by selected city if a city is selected
//     if (selectedCity?.isNotEmpty == true) {
//       tempProducts = tempProducts
//           .where((product) =>
//       product.data!
//           .any((cityProduct) =>
//       cityProduct.translations!
//           .firstWhere(
//               (element) => element.title!.endsWith(lang),
//           orElse: () => TranslationsProduct())
//           .title ==
//           selectedCity) &&
//           selectedCategories.contains(product))
//           .toList();
//     }
//
//     // Apply category filters if any
//     if (selectedCategories.isNotEmpty) {
//       tempProducts =
//           tempProducts.where((product) => selectedCategories.contains(product)).toList();
//     }
//
//     // Apply search filter if search text is entered
//     if (searchController.text.isNotEmpty) {
//       tempProducts = tempProducts
//           .where((product) =>
//       product.data!
//           .any((cityProduct) =>
//           cityProduct.title!.toLowerCase().startsWith(searchController.text)) &&
//           selectedCategories.contains(product))
//           .toList();
//     }
//
//     displayedProducts.addAll(tempProducts);
//   }
//
//   void setSelectedCity(String city) {
//     selectedCity = city;
//     updateDisplayedProducts();
//   }
//
//   void addRemoveCategory(String category, bool isSelected) {
//     if (isSelected) {
//       selectedCategories.add(category);
//     } else {
//       selectedCategories.remove(category);
//     }
//     updateDisplayedProducts();
//   }
//
//   void setSearchText(String text) {
//     searchController.text = text;
//     updateDisplayedProducts();
//   }
//
// }
//
//
//
// //  void updateDisplayedProductss() {
// //     List<ProductOffers>? tempProducts = List<ProductOffers>.from(allProducts); // Start with all products
// //
// //     // Filter by selected country's cities if a country is selected
// //     if (selectedCountry?.isNotEmpty == true) {
// //       List<CityListApi>? countryCities = offercubit.countryListCity.firstWhere((country) => country.translations!.firstWhere(
// //               (element) => element.locale!.endsWith('ar') ) == selectedCountry).cityListApi;
// //       tempProducts = countryCities?.expand((city) => city.items!).toList();
// //       selectedCountryCities.assignAll(countryCities!);
// //     }
// //
// //     // Further filter by selected city if a city is selected
// //     if (selectedCity?.isNotEmpty == true) {
// //       tempProducts = selectedCountryCities.firstWhere((city) => city.translations!.firstWhere((element) => element.title!.endsWith(lang)) == selectedCity).items!.cast<ProductOffers>();
// //     }
// // //Filter by selected country's cities if a country is selected
// //
// //
// //     // // Further filter by selected city if a city is selected
// //
// //     // Apply category filters if any
// //     if (selectedCategories.isNotEmpty) {
// //       tempProducts = tempProducts?.where((product) => selectedCategories.contains(product)).toList();
// //     }
// //
// //     // Apply search filter if search text is entered
// //     if (searchController.text.isNotEmpty) {
// //       tempProducts = tempProducts?.where((element) => element.data!.firstWhere((element) => element.title!.endsWith('ar')).title!.toLowerCase().startsWith(searchController.text))
// //           .toList();
// //     }
// //
// //     // Update the displayed products list
// //     displayedProducts.assignAll(tempProducts!);
// //     update(); // This is crucial for GetX to trigger UI updates
// //   }