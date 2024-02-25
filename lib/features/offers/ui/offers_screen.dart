import 'dart:convert';

import 'package:all_one/core/networks/api_service.dart';
import 'package:all_one/features/home/logic/product_cuibt/product_cuibt_cubit.dart';
import 'package:all_one/features/home/logic/product_cuibt/product_cuibt_state.dart';
import 'package:all_one/features/offers/ui/widgets/app_bar_screen.dart';
import 'package:all_one/features/offers/ui/widgets/body_offers.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/helper/chache_helper.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../home/data/model/product_offer.dart';
import '../../home/ui/wedgits/details_product.dart';
import '../data/model/model_country.dart';
import 'package:http/http.dart' as http;

class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  // final OfferController controllerData = Get.put(OfferController());
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

  fetchData() async {

    try {
      setState(() {
        isLoading = true;
      });
      var isCache = await APICacheManager().isAPICacheKeyExist("Api_Product");
      http.Response response =
      await http.get(Uri.tryParse('http://app.misrgidda.com/api/items')!);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        // Assuming `ProductOffers` is the model for your product items
       bool isSaved =  await CacheHelper.saveDataWithExpiration(response.body, const Duration(days: 10));
        if (isSaved) {
          setState(() {
            productOffers = ProductOffers.fromJson(result);
            isLoading = false;

          });

          // Add the decoded result to the allProducts list
          // allProducts.add(productOffers);
          setState(() {
            allProducts = productOffers!.data!;
            displayedProducts = allProducts;
          });
          // tempProducts = productOffers!.data ;
          print(allProducts.length);
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
            setState(() {
              title = titleCategory;
            });
          }
          // Print the title of the first item in the added productOffers list
          print('//////////////allProducts////////// ${allProducts[1].title}');
          return response.body;
        } else {
          return response.body;
        }



        // Trigger an update in your UI using GetX
      }
    } catch (e) {
      print('Error while getting data is $e');
    }
  }
  void updateDisplayedProducts() {
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

    setState(() {
      displayedProducts = tempProducts;
    });
  }

  ScrollController scrollController = ScrollController();

  Future getData()async{
  await  fetchData();
  await fetchCountry();
  }
  @override
  void initState() {
    getData();
    scrollController.addListener(() {
      scroll();
    });
    super.initState();
  }


  scroll(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      fetchData();
    }
  }


  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh: getData,
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'OFFERS'.tr,
                  style: TextStyles.font20BlueBold,
                ),
                Column(
                  children: [
                    TextButton(
                      onPressed: () => chooseName(context),
                      child: Text('ChooseaCity'.tr,
                          style: TextStyles.font14BlueSemiBold),
                    ),
                  ],
                )
              ],
            ),
          ),
          body: SizedBox(
            height: MediaQuery.sizeOf(context).height * .83,
            child: Column(
              children: [

                // Search field
                Padding(
                  padding:
                  const EdgeInsets.only(top: 25, left: 20, right: 20),
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
                      focusedBorder:
                      OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: ColorsManager.mainMauve,
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      enabledBorder:
                      OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: ColorsManager.lighterGray,
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      hintStyle:  TextStyles.font14LightGrayRegular,
                      hintText: 'Search'.tr,
                      suffixIcon: const Icon(
                        Icons.search_sharp,
                        color: ColorsManager.lightGray,
                        size: 25,
                      ),
                      fillColor:  ColorsManager.moreLightGray,
                      filled: true,
                    ),
                    obscureText:  false,
                    style: TextStyles.font14DarkBlueMedium,
                    validator: (value) {
                    },
                    onChanged: (searchText) {
                      updateDisplayedProducts();
                      // controllerData.addSearchProduct(searchText);
                    },                            ),
                ),
                // Filter chips
                Wrap(
                  spacing: 8.0,
                  children: List<Widget>.generate(
                    categories.length,
                        (int index) {
                      return FilterChip(
                        label: Text(categories[index]),
                        selected: selectedCategories.contains(categories[index]),
                        onSelected: (bool selected) {
                          if (selected!) {
                            selectedCategories.add(categories[index]);
                          } else {
                            selectedCategories.remove(categories[index]);
                          }
                          updateDisplayedProducts();
                        },                          );
                    },
                  ),
                ),
                // BodyOffersScreen(items: state.displayedProducts,),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            String? changeLang = displayedProducts[index].translations!.firstWhere(
                                  (title) => title.locale!.endsWith(lang),
                            ).title ?? '';
                            // DataProduct productItems = state.displayedProducts.data![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // Assume `filteredProducts` is your current list after search/filter

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailsProduct(
                                                productItems: displayedProducts[index],
                                              )
                                          )
                                      );

                                    },
                                    child: SizedBox(
                                      height: 70,
                                      child: Row(
                                        children: [
                                          Stack(
                                            alignment: AlignmentDirectional.topCenter,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(7),
                                                child: AspectRatio(
                                                  aspectRatio: 9 / 9, // Adjust the aspect ratio as needed
                                                  child: Container(
                                                    color: Colors.grey[100],
                                                    child: buildProductImage(displayedProducts[index]),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(right: 15.w),
                                                child: Image(
                                                  image: AssetImage('asstes/icons/special-png.png'),
                                                  width: 55,
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width * .5,
                                                  child: Text(changeLang ??'No title',
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyles.font14DarkBlueMedium
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width * .5,

                                                  child: Text("${'Bestoffers'.tr + changeLang!}",
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyles.font14GrayRegular),
                                                ),

                                                const SizedBox(
                                                  height: 3,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: displayedProducts.length,

                        ),
                      ),
                      if(isLoading)
                        CircularProgressIndicator()
                    ],
                  ),
                )
              ],
            ),
          )

      ),
    );
  }
  Widget buildProductImage(DataProduct product) {

    String? imageUrl = product.files
        ?.firstWhere(
            (file) =>
        file.image!.endsWith('.jpg') ||
            file.image!.endsWith('.jpeg') ||
            file.image!.endsWith('.png'),
        orElse: () => Files(
            fileType:
            'asstes/images/2.jpg') // Use orElse to handle the case when no valid image is found.
    )
        .image;

    // Check if an image URL was found and is not null.
    if (imageUrl != null) {
      // Complete the URL if necessary (if the stored URL is relative).
      String fullImageUrl = 'http://app.misrgidda.com$imageUrl';

      // Return an Image widget to display the image.
      // return Image(image: NetworkImage(fullImageUrl),fit: BoxFit.cover,);
      return CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: fullImageUrl,
        errorWidget: (context, url, error) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, color: Colors.red),
            Text('Failed to load image'),
          ],
        ),
      );
    }
    return Container();
  }
  void chooseName(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.sizeOf(context).height / 2,
          child: Wrap(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30.h, right: 30, left: 30),
                child: Text(
                  'Select country'.tr,
                  style: TextStyles.font18BlackMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: InkWell(
                  onTap: () {
                    showDialogCountry(context);
                    on = true;
                  },
                  child: ListTile(
                    leading: Icon(Icons.menu),
                    title: Text('Select country'.tr),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.h, right: 30, left: 30),
                child: Text(
                  'Select City'.tr,
                  style: TextStyles.font18BlackMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: InkWell(
                  onTap: () {
                    on ? showDialogCity(context) : Center();
                  },
                  child: ListTile(
                    leading: Icon(Icons.menu),
                    title: Text('Select City'.tr),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  showDialogCountry(BuildContext context) {
    showPlatformDialog(
      context: context,
      builder: (BuildContext context) => BasicDialogAlert(
        title:  Text("Select Country".tr),
        content: SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount:country!.country.length,
            itemBuilder: (BuildContext context, int index) {
              Country select = country!.country[index];

              return CheckboxListTile(
                title: Text(
                  country!.country![index]
                      .translations!
                      .firstWhere(
                        (title) => title.locale!.endsWith('ar'),
                  )
                      .title ??
                      'ed',
                  style: GoogleFonts.cairo(
                    textStyle: TextStyles.font13DarkBlueRegular,
                  ),
                ),
                value: selectedCountry ==
                    select.translations
                        ?.firstWhere(
                          (title) => title.locale!.endsWith('ar'),
                    )
                        .title,

                activeColor: ColorsManager.mainMauve,
                onChanged: (bool? value) {
                  if (value == true) {
                    selectedCountry = select.translations
                        ?.firstWhere(
                          (title) => title.locale!.endsWith('ar'),
                    )
                        .title ??
                        'مصر';
                  } else {
                    setState(() {
                      selectedCountry = null; // Reset country selection
                    });
                  }
                  setState(() {
                    selectedCity = null; // Reset city selection as well
                  });
                  updateDisplayedProducts(); // Update displayed products based on new filter
                  Navigator.pop(context);

                },
              );
            },
          ),
        ),
        actions: <Widget>[
          BasicDialogAction(
            title: Text("Cancel".tr),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void showDialogCity(BuildContext context) {
    if (selectedCountry != null) {
      // Find the selected country
      Country selectedCountryObj = country!.country.firstWhere(
            (country) => country.translations!
            .any((element) => element.title == selectedCountry),
      );

      // Check if the selected country has cities
      if (selectedCountryObj.city != null) {
        // Populate selectedCountryCities with cities of the selected country
        selectedCountryCities.clear();
        selectedCountryCities.addAll(selectedCountryObj.city!);

        // Show the dialog only if there are cities
        if (selectedCountryCities.isNotEmpty) {
          showPlatformDialog(
            context: context,
            builder: (BuildContext context) => BasicDialogAlert(
              title: const Text("Select City"),
              content: SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: selectedCountryCities.length,
                  itemBuilder: (BuildContext context, int index) {
                    City city = selectedCountryCities[index];
                    return CheckboxListTile(
                      title: Text(
                        city.translations!
                            .firstWhere(
                              (element) => element.locale!.endsWith('ar'),
                          orElse: () => TranslationsCity(),
                        )
                            .title ??
                            ' de',
                      ),
                      value: selectedCity ==
                          city.translations!
                              .firstWhere(
                                  (element) => element.locale!.endsWith('ar'))
                              .title,
                      activeColor: Colors.black,
                      onChanged: (bool? value) {
                        selectedCity = (value!
                            ? city.translations!
                            .firstWhere(
                                (element) => element.locale!.endsWith('ar'))
                            .title
                            : '')!;
                        Navigator.of(context).pop();
                        if (value == true) {
                          // Only update displayed products when city is selected
                          updateDisplayedProducts();
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                        }
                        // setSelectedCity(city.translations!.firstWhere((element) => element.locale!.endsWith('ar')).title ?? '');
                      },
                    );
                  },
                ),
              ),
              actions: <Widget>[
                BasicDialogAction(
                  title: Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        } else {
          print('No cities available for the selected country');
        }
      } else {
        print('No cities available for the selected country');
      }
    } else {
      print('selectedCountry is null');
    }
  }

  // showDialogCity(BuildContext context) {
  //   if (selectedCountry != null) {
  //     showPlatformDialog(
  //       context: context,
  //       builder: (BuildContext context) => BasicDialogAlert(
  //         title: const Text("Select City"),
  //         content: SizedBox(
  //           height: 300,
  //           width: MediaQuery.of(context).size.width,
  //           child: ListView.builder(
  //             itemCount:controller. countryListCity.length,
  //             itemBuilder: (BuildContext context, int index) {
  //               List<CityListApi> city =controller. countryListCity
  //                   .firstWhere(
  //                     (country) => country.cityListApi!.any(
  //                       (city) =>
  //                   city.translations![index].title == controller.selectedCountry,
  //                 ),
  //                 orElse: () =>
  //                     CountryListApi(), // Provide a default value or handle the case
  //               )
  //                   .cityListApi!; // CityListApi cityData = city.cityListApi![index];
  //               // List<CityListApi> city = selectedCountryCities[index].items.;
  //
  //               return CheckboxListTile(
  //                 title: Text(
  //                   city[index].translations![index].title!,
  //                   style: GoogleFonts.cairo(
  //                     textStyle: TextStyles.font13DarkBlueRegular,
  //                   ),
  //                 ),
  //                 value:
  //                 controller.selectedCity == city[index].translations![index].title!,
  //                 activeColor: ColorsManager.mainMauve,
  //                 onChanged: (bool? value) {
  //                   controller.selectedCity =
  //                   value! ? city[index].translations![index].title! : null;
  //
  //                   Navigator.of(context).pop();
  //                   if (value == true) {
  //                     controller.selectedCityProducts.add(city[index].items![index]!);
  //                     Navigator.pop(context);
  //                   } else {
  //                     controller.selectedCityProducts.remove(city);
  //                     Navigator.pop(context);
  //                     // controllerData.selectedOptionValue(value);
  //                   }
  //                   controller. setSelectedCity(city[index].translations![index].title!);
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
  // }
  // void chooseName(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return SizedBox(
  //         height: MediaQuery.sizeOf(context).height / 2,
  //         child: Wrap(
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(top: 30.h, right: 30, left: 30),
  //               child: Text(
  //                 'Select country',
  //                 style: TextStyles.font18BlackMedium,
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(top: 15),
  //               child: InkWell(
  //                 onTap: () {
  //                   showDialogCountry(context);
  //                   on = true;
  //                 },
  //                 child: ListTile(
  //                   leading: Icon(Icons.menu),
  //                   title: Text('Select country'),
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.only(top: 30.h, right: 30, left: 30),
  //               child: Text(
  //                 'Select City',
  //                 style: TextStyles.font18BlackMedium,
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(top: 15),
  //               child: InkWell(
  //                 onTap: () {
  //                   on ? showDialogCity(context) : Center();
  //                 },
  //                 child: ListTile(
  //                   leading: Icon(Icons.menu),
  //                   title: Text('Select City'),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // showDialogCountry(BuildContext context) {
  //   showPlatformDialog(
  //     context: context,
  //     builder: (BuildContext context) => BasicDialogAlert(
  //       title: const Text("Select Country"),
  //       content: SizedBox(
  //         height: 200,
  //         width: MediaQuery.of(context).size.width,
  //         child: ListView.builder(
  //           itemCount: context.read<OffersCubit>().countryListCity.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             CityListApi? country = context.read<OffersCubit>().countryListCity[index].cityListApi![index];
  //
  //             return CheckboxListTile(
  //               title: Text(
  //                 controller.countryList[index].countryListApi![index].translations!.firstWhere(
  //                       (title) => title.locale!.endsWith('ar'),
  //                 ).title ?? 'ed',
  //                 style: GoogleFonts.cairo(
  //                   textStyle: TextStyles.font13DarkBlueRegular,
  //                 ),
  //               ),
  //               value: controller.selectedCountry == country?.translations?[0]?.title,
  //               activeColor: ColorsManager.mainMauve,
  //               onChanged: (bool? value) {
  //                 if (value == true) {
  //                   controller.selectedCountry = country?.translations?[0]?.title ?? 'ellfm';
  //                 } else {
  //                   controller.selectedCountry = null; // Reset country selection
  //                 }
  //                 controller.selectedCity = null; // Reset city selection as well
  //                 controller.updateDisplayedProducts(); // Update displayed products based on new filter
  //                 Navigator.pop(context);
  //
  //               },
  //             );
  //           },
  //         ),
  //       ),
  //       actions: <Widget>[
  //         BasicDialogAction(
  //           title: Text("Cancel"),
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // showDialogCity(BuildContext context) {
  //   if (controller.selectedCountry != null) {
  //     showPlatformDialog(
  //       context: context,
  //       builder: (BuildContext context) => BasicDialogAlert(
  //         title: const Text("Select City"),
  //         content: SizedBox(
  //           height: 300,
  //           width: MediaQuery.of(context).size.width,
  //           child: ListView.builder(
  //             itemCount: controller.selectedCountryCities.length,
  //             itemBuilder: (BuildContext context, int index) {
  //
  //               CountryListApi city = controller.countryList.firstWhere((country) => country.countryListApi![index].translations![index].title! == controller.selectedCountry).countryListApi![index]!;
  //               CityListApi cityData = city.cityListApi![index];
  //
  //               return CheckboxListTile(
  //                 title: Text(
  //                   city.translations![index].title!,
  //                   style: GoogleFonts.cairo(
  //                     textStyle: TextStyles.font13DarkBlueRegular,
  //                   ),
  //                 ),
  //                 value:  controller.selectedCity == city.translations![index].title!,
  //                 activeColor: ColorsManager.mainMauve,
  //                 onChanged: (bool? value) {
  //                   controller.selectedCity = value! ? city.translations![index].title! : null;
  //
  //                   Navigator.of(context).pop();
  //                   if (value == true) {
  //                     controller.selectedCityProducts.add(cityData.items![index]!);
  //                     Navigator.pop(context);
  //                   } else {
  //                     controller.selectedCityProducts.remove(cityData);
  //                     Navigator.pop(context);
  //                     // controllerData.selectedOptionValue(value);
  //                   }
  //                   controller.setSelectedCity(city.translations![index].title!);
  //
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
  // }

}
//        body: BlocBuilder<OffersCubit, OfferState>(
//           builder: (context, state) {
//             if (state is OfferLoadingState) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is OfferLoadedState) {
//               return ListView.builder(
//                 itemCount: state.displayedProducts.length,
//                 itemBuilder: (context, index) {
//                   final product = state.displayedProducts[index];
//                   return ListTile(
//                     title: Text(product.name!),
//                     subtitle: Text(product.details!),
//                     // Add an image or other details as needed
//                   );
//                 },
//               );
//             } else {
//               return Center(child: Text("Error loading offers"));
//             }
//           },
//         ),

//    return BlocProvider(
//       create: (BuildContext context) => OffersCubit(OfferRepo()),
//       child: BlocBuilder<OffersCubit, OfferState>(
//         builder: ( context,  state) {
//             return Scaffold(
//               appBar: AppBar(
//                 title: AppBarScreen(),
//               ),
//               body: Column(
//                 children: [
//                   // Search field
//                   Padding(
//                     padding:
//                     const EdgeInsets.only(top: 25, left: 20, right: 20),
//                     child: AppTextFormField(
//                       controller: controller.searchController,
//                       suffixIcon: const Icon(
//                         Icons.search_sharp,
//                         color: ColorsManager.lightGray,
//                         size: 25,
//                       ),
//                       hintText: 'Search'.tr,
//                       validator: (String? selected) {},
//                       onChanged: (searchText) {
//                         controller.setSearchText(searchText!);
//                         // controllerData.addSearchProduct(searchText);
//                       },
//                     ),
//                   ),                  // Filter chips
//                   Wrap(
//                     spacing: 8.0,
//                     children: List<Widget>.generate(
//                       controller.categories.length,
//                           (int index) {
//                         return GetBuilder(
//                             init: OfferController(),
//                             builder: (controller){
//                           return FilterChip(
//                             label: Text(controller.categories[index]),
//                             selected: controller.selectedCategories.contains(controller.categories[index]),
//                             onSelected: (bool selected) {
//                               controller.addRemoveCategory(controller.categories[index], selected);
//                             },
//                           );
//                         });
//                       },
//                     ),
//                   ),
//                   BodyOffersScreen(),
//                 ],
//               ),
//             );
//           }
//
//       ),
//     );

///
//AppTextFormField(
//                               controller: controller.searchController,
//                               suffixIcon: const Icon(
//                                 Icons.search_sharp,
//                                 color: ColorsManager.lightGray,
//                                 size: 25,
//                               ),
//                               hintText: 'Search'.tr,
//                               validator: (String? searchText) {
//
//                               },
//
//                             )