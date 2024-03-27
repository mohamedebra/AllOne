import 'package:all_one/core/networks/api_result.dart';
import 'package:all_one/features/home/data/model/model_types.dart';
import 'package:all_one/features/home/data/model/product_offer.dart';
import 'package:all_one/features/offers/logic/offers_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../core/helper/chache_helper.dart';
import '../../../core/sql/sql_data.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../home/data/model/model_local/local_model.dart';
import '../../home/data/repo/Product_repo.dart';
import '../data/model/city_model.dart';
import '../data/model/model_country.dart';
import '../data/repo/offer_repo.dart';

class OffersCubit extends Cubit<OfferState> {
  OffersCubit(this.offerRepo, this.productRepo) : super(OfferInitialState());
  final OfferRepo offerRepo;
  final ProductRepo productRepo;

  List<DataProduct> allProducts = [
    // Add more products
  ];

  List<DataProduct> displayedProducts = [];
  List<String> categories = <String>[]; //
  CountryApi? country;
  String? titleCategory;
  String? selectedCountry;
  String? selectedCity;
  List<String> selectedCategories = [];
  ProductOffers? productOffers;

  bool isLoading = false;

  TextEditingController searchController = TextEditingController();
  bool on = false;
  final lang = CacheHelper.getData(key: 'lang') ?? 'en';

  List<City> selectedCountryCities = [];
  var countryList = <Country>[];
  int currentPage = 1; // Keep track of the current page
  int itemsPerPage = 10; // Define how many items per page you want
  bool hasMoreData = true; // Indicates if there are more data to load
  List<String> c =[];

  List<LocaleModelProduct> listLocal = [];
  int _currentPage = 1;
  final int _limit = 10;
  // void fetchTypes() async {
  //   emit(OfferLoadingState());
  //
  //   try {
  //     final productResponse = await offerRepo.getProduct(page: _currentPage, limit: _limit);
  //     final countryResponse = await offerRepo.getCountry();
  //
  //     // Assuming these responses are processed correctly and you have product and country data
  //     allProducts = productResponse.data!.data!;
  //     countryList = countryResponse.country;
  //
  //     // Initially display all products without any filter
  //     updateDisplayedProducts();
  //   } catch (error) {
  //     emit(OfferLoadedStateTypes());
  //   }
  // }
  // void updateDisplayedProducts({
  //   String? selectedCountry,
  //   String? selectedCity,
  //   List<String>? selectedCategories,
  //   String? searchText,
  // }) async {
  //   var tempProducts = List<DataProduct>.from(allProducts); // Ensure you work with a copy of allProducts
  //
  //   // Apply filters only if they are not null and not empty
  //   if (selectedCountry != null && selectedCountry.isNotEmpty) {
  //     List<City> countryCities = country!.country
  //         .firstWhere((country) =>
  //     country.translations!
  //         .firstWhere((element) => element.locale!.endsWith('ar'))
  //         .title ==
  //         selectedCountry)
  //         .city!;
  //     tempProducts = countryCities.expand((city) => city.items!).toList();
  //     selectedCountryCities.addAll(countryCities);
  //   }
  //
  //   if (selectedCity != null && selectedCity.isNotEmpty) {
  //     tempProducts = selectedCountryCities
  //         .firstWhere((city) =>
  //     city.translations!
  //         .firstWhere((element) => element.locale!.endsWith('ar'))
  //         .title ==
  //         selectedCity)
  //         .items!;
  //
  //   }
  //
  //   if (selectedCategories != null && selectedCategories.isNotEmpty) {
  //     tempProducts = tempProducts.where((product) {
  //       var translations = product.types?.translations;
  //       if (translations != null && translations.isNotEmpty) {
  //         var title = translations
  //             .firstWhere(
  //               (element) => element.locale!.endsWith(lang),
  //           orElse: () =>
  //               TranslationsData(), // Handle the case where no matching translation is found
  //         )
  //             ?.title;
  //
  //         return title != null && selectedCategories.contains(title);
  //       }
  //       return false;
  //     }).toList();
  //
  //   }
  //   if (searchText != null && searchText.isNotEmpty) {
  //     tempProducts.retainWhere((product) => product.title?.toLowerCase().contains(searchText.toLowerCase()) ?? false);
  //   }
  //
  //   // No need to await here since _fetchCategories can be made synchronous if it's processing local data
  //   final categories = _fetchCategories(tempProducts);
  //   final countries = countryList; // Assuming countryList is already populated
  //
  //   emit(OffersSuccess(tempProducts, categories, countries));
  // }
  // List<String> _fetchCategories(List<DataProduct> products) {
  //     // Implement your logic to fetch categories based on products
  //     // This is a simplified version
  //     return products.map((product) => product.types?.translations?.firstWhere(
  //           (translation) => translation.locale!.endsWith(lang),
  //       orElse: () => TranslationsData(title: 'Unknown'),
  //     ).title ?? 'Unknown'
  //     ).toSet().toList();
  //   }

    // Future<List<String>> fetchCategories(List<DataProduct> products) async {
  //   // Implement the logic to fetch categories based on products
  //   // This is a placeholder for your actual fetchCategories implementation
  //   return products.map((e) => e..types!.translations!
  //       .firstWhere(
  //         (element) => element.locale!
  //         .endsWith(lang), // Provide a default empty title
  //   )
  //       .title).toSet().toList() as List<String>;
  // }


  Future<void> fetchData() async {
    if (!hasMoreData) return; // Prevent fetching if no more data to load
    try {
      isLoading = true;


      emit(OfferLoadingState());
      
      final response = await http.get(
        Uri.tryParse('http://app.misrgidda.com/api/items?page=$currentPage&limit=$itemsPerPage')!,
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var newProducts = ProductOffers.fromJson(result).data!.data!;

        if (newProducts!.isEmpty) {
          hasMoreData = false; // No more data to load
        } else {
          allProducts.addAll(newProducts); // Append new products to the list
          displayedProducts = allProducts;
          updateDisplayedProducts(allProducts);
          emit(OffersSuccess(displayedProducts));

          currentPage++; // Increment the page number for the next request
          for (DataProduct pro in allProducts) {
            var title = pro.types!.translations!
                .firstWhere(
                  (element) => element.locale!
                  .endsWith(lang), // Provide a default empty title
            )
                .title;

            if (title != null && !categories.contains(title)) {
              categories
                  .add(title); // Add to the list only if not already present
              print("///////////////////////////$title");
            }
            title = titleCategory;

          }

        }
      } else {
        hasMoreData = false; // Assume no more data to load on error
      }
    } catch (e) {
      hasMoreData = false; // Assume no more data to load on exception
      print('Error while getting data: $e');
    } finally {
      isLoading = false;

    }
  }
  fetchCountry() async {
    try {
      http.Response response = await http
          .get(Uri.tryParse('http://app.misrgidda.com/api/categories')!);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        // print(result);

        country = CountryApi.fromJson(result);
        countryList = country!.country;
        // dataCityItems = country.country.expand((element) => element.city.expand((element) => element.items));
        // print(countryList[0].city![0].items![1].translations![0].title);
        // if (product.data != null) {
        //   // Continue processing data...
        // } else {
        //   print('Error: Data field is null');
        // }
      } else {
        print('Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {}
  }


  void updateDisplayedProducts(allProducts) {
    List<DataProduct> tempProducts = allProducts;

    if (selectedCountry?.isNotEmpty == true) {
      List<City> countryCities = country!.country
          .firstWhere((country) =>
      country.translations!
          .firstWhere((element) => element.locale!.endsWith('ar'))
          .title ==
          selectedCountry)
          .city!;
      tempProducts = countryCities.expand((city) => city.items!).toList();
      selectedCountryCities.addAll(countryCities);
    }

    // Further filter by selected city if a city is selected
    if (selectedCity?.isNotEmpty == true) {
      tempProducts = selectedCountryCities
          .firstWhere((city) =>
      city.translations!
          .firstWhere((element) => element.locale!.endsWith('ar'))
          .title ==
          selectedCity)
          .items!;
    }

    //tempProducts
    //           .where((product) => product.types!
    //               .((category) => selectedCategories.contains(category)))
    //           .toList();

    // Further filter by selected categories
    if (selectedCategories.isNotEmpty) {
      tempProducts = tempProducts.where((product) {
        var translations = product.types?.translations;
        if (translations != null && translations.isNotEmpty) {
          var title = translations
              .firstWhere(
                (element) => element.locale!.endsWith(lang),
            orElse: () =>
                TranslationsData(), // Handle the case where no matching translation is found
          )
              ?.title;

          return title != null && selectedCategories.contains(title);
        }
        return false;
      }).toList();
    }
    // Apply search filter if search text is entered
    if (searchController.text.isNotEmpty) {
      tempProducts = tempProducts
          .where((product) => product.title!
          .toLowerCase()
          .contains(searchController.text.toLowerCase()))
          .toList();
    }

    displayedProducts = tempProducts;
    
    emit(OffersSuccess(displayedProducts));

  }


}
