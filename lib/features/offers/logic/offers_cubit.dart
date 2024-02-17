// import 'package:all_one/core/networks/api_result.dart';
// import 'package:all_one/features/home/data/model/model_types.dart';
// import 'package:all_one/features/home/data/model/product_offer.dart';
// import 'package:all_one/features/offers/logic/offers_state.dart';
// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dialogs/flutter_dialogs.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../core/helper/chache_helper.dart';
// import '../../../core/theming/colors.dart';
// import '../../../core/theming/styles.dart';
// import '../../home/data/model/model_products.dart';
// import '../data/model/city_model.dart';
// import '../data/model/model_country.dart';
// import '../data/repo/offer_repo.dart';
//
// class OffersCubit extends Cubit<OfferState> {
//   OffersCubit(this.offerRepo) : super(OfferInitialState());
//   final OfferRepo offerRepo;
//   List selectedCategories = [];
//   String? selectedCountry;
//   String? selectedCity;
//
//   List categories = [];
//   List<CategoriesData> itemsProductApi = [];
//
//   List<ProductOffers> displayedProducts = [];
//   List<ProductOffers> allProducts = [];
//   List<CountryListApi> countryListCity = [];
//   List<CityListApi> selectedCountryCities = [];
//
//   TextEditingController searchController = TextEditingController();
//   final lang = CacheHelper.getData(key: 'lang');
//   List<ProductOffers> filteredProducts = [];
//
//   List<ProductOffers> selectedCityProducts = [];
//
//   List<ProductOffers> typesCategory = [];
//   bool on = false;
//
//   void fetchCategory() {
//     // for (DataProduct obj in displayedProducts) {
//     //   for(TranslationsData typesProduct in obj.types!.translations!) {
//     //     var title = typesProduct.locale;
//     //     if(title == 'ar'){
//     //       if (!categories.contains(typesProduct.title)) {
//     //         categories.add(typesProduct.title);
//     //         print(typesProduct.title);
//     //       }
//     //     }
//     //
//     //   }
//     //   print(obj.translations![0].title);
//     //
//     // }
//   }
//   void fetchCountry() async {
//     // isLoading.value = true;
//
//     try {
//       final result = await offerRepo.getCountry();
//
//       result.when(
//         success: (types) {
//           countryListCity
//               .addAll(CountryApi.fromJson(types.toJson()).countryListApi!);
//           // print(countryListCity.length);
//           emit(OfferLoadedStateTypes(types));
//         },
//         failure: (error) {
//           emit(state);
//         },
//       );
//     } catch (error) {
//       print("Error fetching posts: $error");
//     }
//   }
//
//   void fetchProduct() async {
//     emit(OfferLoadingState());
//     final result = await offerRepo.getProduct();
//     result.when(
//       success: (types) {
//         // displayedProducts.map((e) => types);
//         displayedProducts.addAll([types]);
//         emit(OfferLoadedState([types])); // Trigger UI updates
//
//         // displayedProducts.add(ProductOffers.fromJson(types.toJson()));
//       },
//       failure: (error) =>
//           emit(OfferErrorState(error.apiErrorModel.message ?? '')),
//     );
//   }
//
//   void updateDisplayedProducts() {
//     selectedCountryCities = []; // Clear the list before populating
//
//     List<ProductOffers> tempProducts = List<ProductOffers>.from(allProducts);
//
//     // Filter by selected country's cities if a country is selected
//     if (selectedCountry?.isNotEmpty == true) {
//       print(selectedCountry);
//       List<CityListApi>? countryCities = countryListCity
//           .firstWhere((country) =>
//       country.translations!
//           .firstWhere((element) => element.locale!.endsWith('ar'),
//           orElse: () => TranslationsListCountry())
//           .title ==
//           selectedCountry)
//           .cityListApi;
//       print(countryCities);
//
//       tempProducts = countryCities!.expand((city) => city.items!).toList();
//       selectedCountryCities.addAll(countryCities); // Add all cities to the list
//       print(selectedCountryCities);
//     }
//     // Further filter by selected city if a city is selected
//     if (selectedCity?.isNotEmpty == true) {
//       tempProducts = selectedCountryCities
//           .firstWhere((city) =>
//       city.translations!
//           .firstWhere((element) => element.locale!.endsWith('ar'))
//           .title ==
//           selectedCity)
//           .items!;
//     }
//     // Apply category filters if any
//     if (selectedCategories.isNotEmpty) {
//       tempProducts = tempProducts
//           .where((product) => selectedCategories.contains(product))
//           .toList();
//     }
//
//     // Apply search filter if search text is entered
//     if (searchController.text.isNotEmpty) {
//       tempProducts = tempProducts
//           .where((product) =>
//               product.data!.any((cityProduct) => cityProduct.title!
//                   .toLowerCase()
//                   .startsWith(searchController.text)) &&
//               selectedCategories.contains(product))
//           .toList();
//     }
//
//     displayedProducts.addAll(tempProducts);
//     emit(OfferLoadedState(displayedProducts));
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
//   void chooseName(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return SizedBox(
//           height: MediaQuery.sizeOf(context).height / 2,
//           child: Wrap(
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(top: 30.h, right: 30, left: 30),
//                 child: Text(
//                   'Select country',
//                   style: TextStyles.font18BlackMedium,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 15),
//                 child: InkWell(
//                   onTap: () {
//                     showDialogCountry(context);
//                     on = true;
//                   },
//                   child: ListTile(
//                     leading: Icon(Icons.menu),
//                     title: Text('Select country'),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 30.h, right: 30, left: 30),
//                 child: Text(
//                   'Select City',
//                   style: TextStyles.font18BlackMedium,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 15),
//                 child: InkWell(
//                   onTap: () {
//                     on ? showDialogCity(context) : Center();
//                   },
//                   child: ListTile(
//                     leading: Icon(Icons.menu),
//                     title: Text('Select City'),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   showDialogCountry(BuildContext context) {
//     showPlatformDialog(
//       context: context,
//       builder: (BuildContext context) => BasicDialogAlert(
//         title: const Text("Select Country"),
//         content: SizedBox(
//           height: 200,
//           width: MediaQuery.of(context).size.width,
//           child: ListView.builder(
//             itemCount: countryListCity.length,
//             itemBuilder: (BuildContext context, int index) {
//               CountryListApi country = countryListCity[index];
//
//               return CheckboxListTile(
//                 title: Text(
//                   countryListCity![index]
//                           .translations!
//                           .firstWhere(
//                             (title) => title.locale!.endsWith('ar'),
//                           )
//                           .title ??
//                       'ed',
//                   style: GoogleFonts.cairo(
//                     textStyle: TextStyles.font13DarkBlueRegular,
//                   ),
//                 ),
//                 value: selectedCountry ==
//                     country.translations
//                         ?.firstWhere(
//                           (title) => title.locale!.endsWith('ar'),
//                         )
//                         .title,
//                 activeColor: ColorsManager.mainMauve,
//                 onChanged: (bool? value) {
//                   if (value == true) {
//                     selectedCountry = country.translations
//                             ?.firstWhere(
//                               (title) => title.locale!.endsWith('ar'),
//                             )
//                             .title ??
//                         'gfdg';
//                   } else {
//                     selectedCountry = null; // Reset country selection
//                   }
//                   selectedCity = null; // Reset city selection as well
//                   updateDisplayedProducts(); // Update displayed products based on new filter
//                   Navigator.pop(context);
//                 },
//               );
//             },
//           ),
//         ),
//         actions: <Widget>[
//           BasicDialogAction(
//             title: Text("Cancel"),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   showDialogCity(BuildContext context) {
//     if (selectedCountry != null) {
//       showPlatformDialog(
//         context: context,
//         builder: (BuildContext context) => BasicDialogAlert(
//           title: const Text("Select City"),
//           content: SizedBox(
//             height: 300,
//             width: MediaQuery.of(context).size.width,
//             child: ListView.builder(
//               itemCount: countryListCity.length,
//               itemBuilder: (BuildContext context, int index) {
//                 List<CityListApi> city = countryListCity
//                     .firstWhere(
//                       (country) => country.cityListApi!.any(
//                         (city) =>
//                             city.translations![index].title == selectedCountry,
//                       ),
//                       orElse: () =>
//                           CountryListApi(), // Provide a default value or handle the case
//                     )
//                     .cityListApi!; // CityListApi cityData = city.cityListApi![index];
//                 // List<CityListApi> city = selectedCountryCities[index].items.;
//
//                 return CheckboxListTile(
//                   title: Text(
//                     city[index].translations![index].title!,
//                     style: GoogleFonts.cairo(
//                       textStyle: TextStyles.font13DarkBlueRegular,
//                     ),
//                   ),
//                   value:
//                       selectedCity == city[index].translations![index].title!,
//                   activeColor: ColorsManager.mainMauve,
//                   onChanged: (bool? value) {
//                     selectedCity =
//                         value! ? city[index].translations![index].title! : null;
//
//                     Navigator.of(context).pop();
//                     if (value == true) {
//                       selectedCityProducts.add(city[index].items![index]!);
//                       Navigator.pop(context);
//                     } else {
//                       selectedCityProducts.remove(city);
//                       Navigator.pop(context);
//                       // controllerData.selectedOptionValue(value);
//                     }
//                     setSelectedCity(city[index].translations![index].title!);
//                   },
//                 );
//               },
//             ),
//           ),
//           actions: <Widget>[
//             BasicDialogAction(
//               title: Text("Cancel"),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   void setSelectedCity(String city) {
//     selectedCity = city;
//     updateDisplayedProducts();
//   }
//
// // fetchCategory() {
// //   for (Types obj in typesCategory) {
// //     for(Data cate in obj.data!) {
// //       for(TranslationLang lan in cate.translations!){
// //         if (!categories.contains(lan.title)) {
// //           categories.add(lan.title!);
// //           // print(obj.category);
// //         }
// //
// //       }
// //     }
// //   }
// // }
// //void updateDisplayedProductxs() {
// //   //   List<ProductOffers>? tempProducts = List<ProductOffers>.from(allProducts); // Start with all products
// //   //   // String? changeLang = state.productOffers.data![index].translations!.firstWhere(
// //   //   //         (title) => title.locale!.endsWith(lang)
// //   //   // Filter by selected country's cities if a country is selected
// //   //   if (selectedCountry?.isNotEmpty == true) {
// //   //     List<CityListApi> countryCities = countryListCity.firstWhere((country) => country.translations!.firstWhere((element) => element.title!.endsWith(lang)) == selectedCountry).cityListApi!;
// //   //     tempProducts = countryCities.expand((city) => city.items!).cast<ProductOffers>().toList();
// //   //     selectedCountryCities.addAll(countryCities);
// //   //   }
// //   //
// //   //   // Further filter by selected city if a city is selected
// //   //   if (selectedCity?.isNotEmpty == true) {
// //   //     tempProducts = selectedCountryCities.firstWhere((city) => city.translations!.firstWhere((element) => element.title!.endsWith(lang)) == selectedCity).items!.cast<ProductOffers>();
// //   //   }
// //   //
// //   //   // Apply category filters if any
// //   //   if (selectedCategories.isNotEmpty) {
// //   //     tempProducts = tempProducts.where((product) => selectedCategories.contains(product)).toList();
// //   //   }
// //   //
// //   //   // Apply search filter if search text is entered
// //   //   if (searchController.text.isNotEmpty) {
// //   //     tempProducts = tempProducts.where((element) => element.data!.firstWhere((element) => element.title!.endsWith('ar')).title!.toLowerCase().startsWith(searchController.text))
// //   //         .toList();
// //   //   }
// //   //
// //   //   // Update the displayed products list
// //   //   displayedProducts.addAll(tempProducts);
// //   //   emit(state); // This is crucial for GetX to trigger UI updates
// //   // }
// }
