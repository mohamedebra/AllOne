// import 'package:all_one/features/home/data/repo/repo_types.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dialogs/flutter_dialogs.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../core/helper/chache_helper.dart';
// import '../core/theming/colors.dart';
// import '../core/theming/styles.dart';
// import '../features/home/data/model/model_products.dart';
// import 'package:flutter/material.dart';
//
// import '../features/home/data/model/product_offer.dart';
// import '../features/home/data/repo/Product_repo.dart';
//
// class OfferController extends GetxController {
//   final ProductRepo productRepo;
//   final TypesRepo typesRepo ;
//   List selectedCategories = [];
//   String? selectedCountry;
//   String? selectedCity;
//
//   List<City> selectedCountryCities = [];
//   List<ProductItems> selectedCityProducts = [];
//
//   List categories = [];
//
//   var allProducts = <ProductItems>[].obs;
//   var displayedProducts = <ProductItems>[].obs;
//   TextEditingController searchController = TextEditingController();
//   var postList = <ProductOffers>[].obs;
//   var typesProduct = <TypesProduct>[].obs;
//
//   OfferController(this.productRepo,this.typesRepo);
//
//   fetchCategory() {
//     for (ProductItems obj in productItems) {
//       if (!categories.contains(obj.category)) {
//         categories.add(obj.category!);
//         // print(obj.category);
//       }
//     }
//   }
//   void fetchCategoryApi() {
//     // for (ProductOffers obj in postList) {
//     //   for (DataProduct pro in obj.data!) {
//     //     for(TranslationsData type in pro.types!.translations!) {
//     //       if (!categories.contains(type.title)) {
//     //         categories.add(pro.title!);
//     //       }
//     //     }
//     //   }
//     // }
//   }
//
//
//   void fetchPosts() async {
//     // isLoading.value = true;
//
//     try {
//       final result = await productRepo.getProduct();
//
//       result.when(
//         success: (types) {
//           postList.add(types); // Use assignAll directly on the list
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
//   void fetchTypes() async {
//     // isLoading.value = true;
//
//     try {
//       final result = await productRepo.getProduct();
//
//       result.when(
//         success: (types) {
//           postList.add(types); // Use assignAll directly on the list
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
//
//   @override
//   void onInit() {
//     fetchCategory();
//     fetchCategoryApi();
//     fetchPosts();
//     fetchTypes();
//     allProducts.assignAll(productItems); // Assuming productItems is your initial list
//     updateDisplayedProducts();
//     super.onInit();
//   }
//
//
//   void updateDisplayedProducts() {
//     List<ProductItems> tempProducts = List<ProductItems>.from(allProducts); // Start with all products
//
//     // Filter by selected country's cities if a country is selected
//     if (selectedCountry?.isNotEmpty == true) {
//       List<City> countryCities = countries.firstWhere((country) => country.name == selectedCountry).cities;
//       tempProducts = countryCities.expand((city) => city.products).toList();
//       selectedCountryCities.assignAll(countryCities);
//     }
//
//     // Further filter by selected city if a city is selected
//     if (selectedCity?.isNotEmpty == true) {
//       tempProducts = selectedCountryCities.firstWhere((city) => city.name == selectedCity).products;
//     }
//
//     // Apply category filters if any
//     if (selectedCategories.isNotEmpty) {
//       tempProducts = tempProducts.where((product) => selectedCategories.contains(product.category)).toList();
//     }
//
//     // Apply search filter if search text is entered
//     if (searchController.text.isNotEmpty) {
//       tempProducts = tempProducts.where((element) => element.name!.toLowerCase().startsWith(searchController.text))
//           .toList();
//     }
//
//     // Update the displayed products list
//     displayedProducts.assignAll(tempProducts);
//     update(); // This is crucial for GetX to trigger UI updates
//   }
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
