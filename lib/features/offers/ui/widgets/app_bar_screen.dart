// import 'package:all_one/features/home/data/repo/repo_types.dart';
// import 'package:all_one/features/offers/data/model/city_model.dart';
// import 'package:all_one/features/offers/data/model/model_country.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dialogs/flutter_dialogs.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../../controller/offers_controoler.dart';
// import '../../../../core/networks/api_service.dart';
// import '../../../../core/theming/colors.dart';
// import '../../../../core/theming/styles.dart';
// import '../../../home/data/model/model_products.dart';
// import '../../../home/data/repo/Product_repo.dart';
// import '../../data/repo/offer_repo.dart';
// import '../../logic/offers_screen_contrroler.dart';
//
// class AppBarScreen extends StatelessWidget {
//    AppBarScreen({super.key});
//    OffersScreenController controller = Get.put(OffersScreenController(OfferRepo(ApiService(Dio()))));
//    bool on = false;
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           'OFFERS'.tr,
//           style: TextStyles.font20BlueBold,
//         ),
//         GetBuilder<OffersScreenController>(
//             init: OffersScreenController(OfferRepo(ApiService(Dio()))),
//             builder: (controller) {
//               return Column(
//                 children: [
//                   TextButton(
//                     onPressed: () => chooseName(context),
//                     child: Text('ChooseaCity'.tr,
//                         style: TextStyles.font14BlueSemiBold),
//                   ),
//                 ],
//               );
//             })
//       ],
//     );
//   }
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
//             itemCount: controller.countryList.length,
//             itemBuilder: (BuildContext context, int index) {
//               CountryApi country = controller.countryList[index];
//
//               return CheckboxListTile(
//                 title: Text(
//                   country.countryListApi![index].translations![index].title!,
//                   style: GoogleFonts.cairo(
//                     textStyle: TextStyles.font13DarkBlueRegular,
//                   ),
//                 ),
//                 value: controller.selectedCountry == country.countryListApi![index].translations![index].title!,
//                 activeColor: ColorsManager.mainMauve,
//                 onChanged: (bool? value) {
//                   if (value == true) {
//                     controller.selectedCountry = country.countryListApi![index].translations![index].title!;
//                   } else {
//                     controller.selectedCountry = null; // Reset country selection
//                   }
//                   controller.selectedCity = null; // Reset city selection as well
//                   controller.updateDisplayedProducts(); // Update displayed products based on new filter
//                   Navigator.pop(context);
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
//
//   showDialogCity(BuildContext context) {
//     if (controller.selectedCountry != null) {
//       showPlatformDialog(
//         context: context,
//         builder: (BuildContext context) => BasicDialogAlert(
//           title: const Text("Select City"),
//           content: SizedBox(
//             height: 300,
//             width: MediaQuery.of(context).size.width,
//             child: ListView.builder(
//               itemCount: controller.selectedCountryCities.length,
//               itemBuilder: (BuildContext context, int index) {
//
//                 CountryListApi city = controller.countryList.firstWhere((country) => country.countryListApi![index].translations![index].title! == controller.selectedCountry).countryListApi![index]!;
//                 CityListApi cityData = city.cityListApi![index];
//
//                 return CheckboxListTile(
//                   title: Text(
//                     city.translations![index].title!,
//                     style: GoogleFonts.cairo(
//                       textStyle: TextStyles.font13DarkBlueRegular,
//                     ),
//                   ),
//                   value:  controller.selectedCity == city.translations![index].title!,
//                   activeColor: ColorsManager.mainMauve,
//                   onChanged: (bool? value) {
//                     controller.selectedCity = value! ? city.translations![index].title! : null;
//
//                     Navigator.of(context).pop();
//                     if (value == true) {
//                       controller.selectedCityProducts.add(cityData.items![index]!);
//                       Navigator.pop(context);
//                     } else {
//                       controller.selectedCityProducts.remove(cityData);
//                       Navigator.pop(context);
//                       // controllerData.selectedOptionValue(value);
//                     }
//                     controller.setSelectedCity(city.translations![index].title!);
//
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
// }
