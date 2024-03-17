// import 'package:all_one/core/networks/api_service.dart';
// import 'package:all_one/features/home/data/repo/Product_repo.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_dialogs/flutter_dialogs.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../../core/theming/colors.dart';
// import '../../../../core/theming/styles.dart';
// import '../../../home/data/model/product_offer.dart';
// import '../../../home/ui/wedgits/details_product.dart';
// import '../../../home/ui/wedgits/goggle_maps_product.dart';
// import '../../data/model/model_country.dart';
// import '../../data/repo/offer_repo.dart';
// import '../../logic/offers_cubit.dart';
// import '../../logic/offers_state.dart';
//
// class OffersScreenTest extends StatefulWidget {
//   @override
//   State<OffersScreenTest> createState() => _OffersScreenTestState();
// }
//
// class _OffersScreenTestState extends State<OffersScreenTest> {
//   ScrollController scrollController = ScrollController();
//   bool on = false;
//
//   @override
//   Widget build(BuildContext context) {
//
//     return BlocProvider(
//       create: (context) => OffersCubit(OfferRepo(ApiService(Dio())),ProductRepo(ApiService(Dio())))..fetchTypes(),
//       child: BlocBuilder<OffersCubit, OfferState>(
//         builder: (context,state){
//           var cubit = context.read<OffersCubit>();
//           return Scaffold(
//             appBar: AppBar(
//               title: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'OFFERS'.tr,
//                     style: TextStyles.font20BlueBold,
//                   ),
//                   Column(
//                     children: [
//                       TextButton(
//                         onPressed: () => chooseName(context,cubit),
//                         child: Text('ChooseaCity'.tr,
//                             style: TextStyles.font14BlueSemiBold),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             body: BlocBuilder<OffersCubit, OfferState>(
//               builder: (context, state) {
//                 if (state is OfferLoadingState) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state is OffersSuccess) {
//                   // Build your UI with state.products and state.categories
//                   return  Column(
//                     children: [
//                       Padding(
//                         padding:
//                         const EdgeInsets.only(top: 25, left: 20, right: 20),
//                         child: TextFormField(
//                           controller: cubit.searchController,
//                           decoration: InputDecoration(
//                             isDense: true,
//                             contentPadding:
//                             EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
//                             focusedBorder:
//                             OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                 color: ColorsManager.mainMauve,
//                                 width: 1.3,
//                               ),
//                               borderRadius: BorderRadius.circular(16.0),
//                             ),
//                             enabledBorder:
//                             OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                 color: ColorsManager.lighterGray,
//                                 width: 1.3,
//                               ),
//                               borderRadius: BorderRadius.circular(16.0),
//                             ),
//                             errorBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                 color: Colors.red,
//                                 width: 1.3,
//                               ),
//                               borderRadius: BorderRadius.circular(16.0),
//                             ),
//                             focusedErrorBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                 color: Colors.red,
//                                 width: 1.3,
//                               ),
//                               borderRadius: BorderRadius.circular(16.0),
//                             ),
//                             hintStyle:  TextStyles.font14LightGrayRegular,
//                             hintText: 'Search'.tr,
//                             suffixIcon: const Icon(
//                               Icons.search_sharp,
//                               color: ColorsManager.lightGray,
//                               size: 25,
//                             ),
//                             fillColor:  ColorsManager.moreLightGray,
//                             filled: true,
//                           ),
//                           obscureText:  false,
//                           style: TextStyles.font14DarkBlueMedium,
//                           validator: (value) {
//                           },
//                           onChanged: (searchText) {
//                             cubit.updateDisplayedProducts();
//                             // controllerData.addSearchProduct(searchText);
//                           },                            ),
//                       ),
//                       // Filter chips
//                       Wrap(
//                         spacing: 8.0.w,
//                         children: List<Widget>.generate(
//                           cubit.categories.length,
//                               (int index) {
//                             return FilterChip(
//                               label: Text(cubit.categories[index],style: TextStyle(fontSize: 13.sp),),
//                               selected: cubit.selectedCategories.contains(cubit.categories[index]),
//                               onSelected: (bool selected) {
//                                 if (selected!) {
//                                   cubit.selectedCategories.add(cubit.categories[index]);
//                                 } else {
//                                   cubit.selectedCategories.remove(cubit.categories[index]);
//                                 }
//                                 cubit.updateDisplayedProducts();
//                               },                          );
//                           },
//                         ),
//                       ),
//                       Expanded(
//                         child: Column(
//                           children: [
//                             Expanded(
//                               child: ListView.builder(
//                                 shrinkWrap: true,
//                                 controller: scrollController,
//                                 itemBuilder: (context, index) {
//                                   final product = state.products[index];
//
//                                   String? changeLang = product.translations!.firstWhere(
//                                         (title) => title.locale!.endsWith('en'),
//                                   ).title ?? '';
//                                   // DataProduct productItems = state.displayedProducts.data![index];
//                                   return Padding(
//                                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                                     child:  Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       children: [
//                                         InkWell(
//                                           onTap: () {
//                                             Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) => DetailsProduct(
//                                                       productItems:
//                                                       product,
//                                                     )));
//                                           },
//                                           child: Column(
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   Stack(
//                                                     alignment: AlignmentDirectional.topCenter,
//                                                     children: [
//                                                       Container(
//
//                                                         decoration:  BoxDecoration(
//                                                             borderRadius: BorderRadius.circular(25)
//                                                         ),
//                                                         width: 70.w,
//                                                         height: 75.h,
//                                                         child: buildProductImage(
//                                                             product),
//                                                       ),
//                                                       Padding(
//                                                         padding: EdgeInsets.only(right: 15.w),
//                                                         child: Image(
//                                                           image: const AssetImage(
//                                                               'asstes/icons/special-png.png'),
//                                                           width: 55.w,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   SizedBox(
//                                                     width: 15.w,
//                                                   ),
//                                                   Expanded(
//                                                     child: Row(
//                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                       children: [
//                                                         Column(
//                                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                                           mainAxisAlignment: MainAxisAlignment.center,
//                                                           children: [
//                                                             SizedBox(
//                                                               width: MediaQuery.of(context).size.width *
//                                                                   .5,
//                                                               child: Text(product.translations!
//                                                                   .firstWhere(
//                                                                     (title) => title.locale!.endsWith('en'),
//                                                               )
//                                                                   .title ?? 'No title',
//                                                                   maxLines: 2,
//                                                                   overflow: TextOverflow.ellipsis,
//                                                                   style:
//                                                                   TextStyles.font14DarkBlueMedium),
//                                                             ),
//                                                             SizedBox(
//                                                               height: 3.h,
//                                                             ),
//                                                             SizedBox(
//                                                               width: MediaQuery.of(context).size.width *
//                                                                   .5,
//                                                               child: Text(
//                                                                   "${'Bestoffers'.tr + product.translations!
//                                                                       .firstWhere(
//                                                                         (title) => title.locale!.endsWith('en'),
//                                                                   )
//                                                                       .title!}",
//                                                                   maxLines: 1,
//                                                                   overflow: TextOverflow.ellipsis,
//                                                                   style: TextStyles.font14GrayRegular),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         Column(
//                                                           mainAxisAlignment: MainAxisAlignment.center,
//                                                           children: [
//
//                                                             InkWell(
//                                                               // onTap: () => callNumber(displayedProducts[index]),
//                                                               child: CircleAvatar(
//                                                                 radius: 10.h,
//                                                                 backgroundImage: const AssetImage('asstes/icons/phone-call-icon.png'),
//                                                               ),
//                                                             ),
//                                                             SizedBox(height: 7.h,),
//                                                             InkWell(
//                                                               onTap: (){
//                                                                 Navigator.push(context, MaterialPageRoute(builder: (context) =>  GoogleMapsProduct(dataProduct:product,)));
//
//                                                               },
//                                                               child: CircleAvatar(
//                                                                 radius: 10.h,
//                                                                 backgroundImage: const AssetImage('asstes/icons/61021.png'),
//                                                               ),
//                                                             ),
//
//                                                           ],
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ),
//
//                                                 ],
//                                               ),
//                                               SizedBox(height: 7.h,)
//                                             ],
//                                           ),
//                                         ),
//
//                                       ],
//                                     ),
//                                   );
//                                 },
//                                 itemCount: state.products.length,
//
//                               ),
//                             ),
//
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//                   // Plus, handle categories UI based on state.categories
//                 } else if (state is OfferLoadedStateTypes) {
//                   return Center(child: Text('Error: '));
//                 }
//                 return Center(child: Text('Unknown state'));
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget buildProductImage(DataProduct product) {
//
//     String? imageUrl = product.files
//         ?.firstWhere(
//             (file) =>
//         file.image!.endsWith('.jpg') ||
//             file.image!.endsWith('.jpeg') ||
//             file.image!.endsWith('.png'),
//         orElse: () => Files(
//             fileType:
//             'asstes/images/2.jpg') // Use orElse to handle the case when no valid image is found.
//     )
//         .image;
//
//     // Check if an image URL was found and is not null.
//     if (imageUrl != null) {
//       // Complete the URL if necessary (if the stored URL is relative).
//       String fullImageUrl = 'http://app.misrgidda.com$imageUrl';
//
//       // Return an Image widget to display the image.
//       // return Image(image: NetworkImage(fullImageUrl),fit: BoxFit.cover,);
//       return CachedNetworkImage(
//         fit: BoxFit.fill,
//         imageUrl: fullImageUrl,
//         errorWidget: (context, url, error) => Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.error, color: Colors.red),
//             Text('Failed to load image'),
//           ],
//         ),
//       );
//     }
//     return Container();
//   }
//
//   void chooseName(BuildContext context,cubit) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return SizedBox(
//           height: MediaQuery.sizeOf(context).height / 2,
//           width: MediaQuery.sizeOf(context).width * .8,
//           child: Wrap(
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(top: 30.h, right: 30, left: 30),
//                 child: Text(
//                   'Select country'.tr,
//                   style: TextStyles.font18BlackMedium,
//                 ),
//               ),
//               Padding(
//                 padding:  EdgeInsets.only(top: 15.h),
//                 child: InkWell(
//                   onTap: () {
//                     showDialogCountry(context);
//                     // on = true;
//                   },
//                   child: ListTile(
//                     leading: Icon(Icons.menu,size: 22.h,),
//                     title: Text('Select country'.tr,style: TextStyle(fontSize: 15.sp),),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 30.h, right: 30, left: 30),
//                 child: Text(
//                   'Select City'.tr,
//                   style: TextStyles.font18BlackMedium,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 15),
//                 child: InkWell(
//                   onTap: () {
//                     // on ? : Center();
//                     showDialogCity(context,cubit);
//                   },
//                   child: ListTile(
//                     leading: Icon(Icons.menu,size: 22.h,),
//                     title: Text('Select City'.tr,style: TextStyle(fontSize: 15.sp),),
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
//         title:  Text("Select Country".tr,style: TextStyle(fontSize: 15.sp),),
//         content: SizedBox(
//           height: 200.h,
//           width: MediaQuery.of(context).size.width,
//           child: BlocProvider(
//             create: (context) => OffersCubit(OfferRepo(ApiService(Dio())),ProductRepo(ApiService(Dio())))..fetchTypes(),
//
//             child: BlocBuilder<OffersCubit,OfferState>(
//               builder: (BuildContext context, OfferState state) {
//                 var cubit = context.read<OffersCubit>();
//
//                 if(state is OffersSuccess){
//                 }
//                 return ListView.builder(
//                   itemCount:cubit.countryList.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     // Country select = country!.country[index];
//
//                     return CheckboxListTile(
//                       title: Text(
//                         cubit!.countryList![index]
//                             .translations!
//                             .firstWhere(
//                               (title) => title.locale!.endsWith('ar'),
//                         )
//                             .title ??
//                             'ed',
//                         style: GoogleFonts.cairo(
//                           textStyle: TextStyles.font13DarkBlueRegular,
//                         ),
//                       ),
//                       value: cubit.selectedCountry ==
//                           cubit.countryList[index].translations
//                               ?.firstWhere(
//                                 (title) => title.locale!.endsWith('ar'),
//                           )
//                               .title,
//
//                       activeColor: ColorsManager.mainMauve,
//                       onChanged: (bool? value) {
//                         if (value == true) {
//                           cubit.selectedCountry = cubit.countryList[index].translations
//                               ?.firstWhere(
//                                 (title) => title.locale!.endsWith('ar'),
//                           )
//                               .title ??
//                               'مصر';
//                         } else {
//                           setState(() {
//                             cubit.selectedCountry = null; // Reset country selection
//                           });
//                         }
//                         setState(() {
//                           cubit. selectedCity = null; // Reset city selection as well
//                         });
//                         // updateDisplayedProducts(); // Update displayed products based on new filter
//                         Navigator.pop(context);
//
//                       },
//                     );
//                   },
//                 );
//
//               },
//             ),
//           ),
//         ),
//         actions: <Widget>[
//           BasicDialogAction(
//             title: Text("Cancel".tr),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   void showDialogCity(BuildContext context,OffersCubit cubit) {
//     if(cubit.selectedCountryCities.isEmpty) {
//       // Handle empty state, maybe fetch data or show a message
//       return;
//     }
//
//     showPlatformDialog(
//       context: context,
//       builder: (BuildContext context) => BasicDialogAlert(
//         title: Text("Select City".tr, style: TextStyle(fontSize: 15.sp)),
//         content: SizedBox(
//           height: 300.h,
//           width: MediaQuery.of(context).size.width,
//           child: ListView.builder(
//             itemCount: cubit.selectedCountryCities.length, // Use the correct list and ensure it's not empty
//             itemBuilder: (BuildContext context, int index) {
//               City city = cubit.selectedCountryCities[index];
//               return CheckboxListTile(
//                 title: Text(
//                   city.translations!.firstWhere(
//                         (element) => element.locale!.endsWith('ar'),
//                     orElse: () => TranslationsCity(),
//                   ).title ?? 'Unknown',
//                   style: GoogleFonts.cairo(
//                     textStyle: TextStyles.font13DarkBlueRegular,
//                   ),
//                 ),
//                 value: cubit.selectedCity == city.translations!.firstWhere((element) => element.locale!.endsWith('ar')).title,
//                 activeColor: Colors.black,
//                 onChanged: (bool? value) {
//                   if(value != null && value) {
//                     cubit.selectedCity = city.translations!.firstWhere((element) => element.locale!.endsWith('ar')).title;
//                     // Trigger any updates if necessary, like fetching new data or updating the UI
//                     cubit.updateDisplayedProducts(selectedCity: cubit.selectedCity); // This line updates the displayed products based on the new city selection
//                   }
//                   Navigator.pop(context);
//                 },
//               );
//             },
//           ),
//         ),
//         actions: <Widget>[
//           BasicDialogAction(
//             title: Text("Cancel".tr),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }