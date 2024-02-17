// import 'package:all_one/features/home/data/model/product_offer.dart';
// import 'package:all_one/features/home/data/repo/repo_types.dart';
// import 'package:all_one/features/offers/data/repo/offer_repo.dart';
// import 'package:all_one/features/offers/logic/offers_cubit.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../../../controller/offers_controoler.dart';
// import '../../../../core/helper/chache_helper.dart';
// import '../../../../core/networks/api_service.dart';
// import '../../../../core/theming/styles.dart';
// import '../../../home/data/model/model_products.dart';
// import '../../../home/data/repo/Product_repo.dart';
// import '../../data/model/model_country.dart';
// import '../../logic/offers_screen_contrroler.dart';
//
// class BodyOffersScreen extends StatelessWidget {
//    BodyOffersScreen({super.key, required this.items});
//    ProductOffers items;
//    final lang = CacheHelper.getData(key: 'lang');
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Expanded(
//       child: GetBuilder<OfferController>(
//         init: OfferController(ProductRepo(ApiService(Dio())),TypesRepo(ApiService(Dio()))),
//         builder: (controller){
//           return ListView.builder(
//
//             itemBuilder: (context, index) {
//               String? changeLang = items.data![index].translations!.firstWhere(
//                     (title) => title.locale!.endsWith(lang),
//               ).title;
//               DataProduct productItems = items.data![index];
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   children: [
//                     InkWell(
//                       onTap: () {},
//                       child: SizedBox(
//                         height: 110,
//                         child: Row(
//                           children: [
//                             Stack(
//                               alignment:
//                               AlignmentDirectional.topStart,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius:
//                                   BorderRadius.circular(16),
//                                   child: AspectRatio(
//                                     aspectRatio: 2.6 / 3,
//                                     child: Container(
//                                       color: Colors.grey[100],
//                                       child: buildProductImage(
//                                           items.data![index]),
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding:
//                                   EdgeInsets.only(right: 15.w),
//                                   child: const Image(
//                                     image: AssetImage(
//                                         'asstes/icons/special-png.png'),
//                                     width: 80,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               width: 15,
//                             ),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.center,
//                                 children: [
//                                   SizedBox(
//                                     width: MediaQuery.of(context)
//                                         .size
//                                         .width *
//                                         .5,
//                                     child: Text( changeLang ??
//                                         'No title',
//                                         maxLines: 2,
//                                         overflow:
//                                         TextOverflow.ellipsis,
//                                         style: TextStyles
//                                             .font18BlackMedium),
//                                   ),
//                                   const SizedBox(
//                                     height: 3,
//                                   ),
//                                   Text(
//                                     'productItems.details!',
//                                     style:
//                                     TextStyles.font13GrayRegular,
//                                   ),
//                                   const SizedBox(
//                                     height: 3,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 12.h,
//                     ),
//                   ],
//                 ),
//               );
//             },
//             itemCount: items.data!.length,
//
//           );
//
//         },
//       ),
//     );
//   }
//    Widget buildProductImage(DataProduct product) {
//      // Find the first image file that is an actual image (ignoring non-image files).
//
//      // String? imageUrl = product.files?.firstWhere(
//      //       (file) => file.image!.endsWith('.jpg') || file.image!.endsWith('.jpeg') || file.image!.endsWith('.png'),
//      //   orElse: () => null, // Use orElse to handle the case when no valid image is found.
//      //
//      // ).image;
//      String? imageUrl = product.files
//          ?.firstWhere(
//              (file) =>
//          file.image!.endsWith('.jpg') ||
//              file.image!.endsWith('.jpeg') ||
//              file.image!.endsWith('.png'),
//          orElse: () => Files(
//              fileType:
//              'asstes/images/2.jpg') // Use orElse to handle the case when no valid image is found.
//      )
//          .image;
//
//      // Check if an image URL was found and is not null.
//      if (imageUrl != null) {
//        // Complete the URL if necessary (if the stored URL is relative).
//        String fullImageUrl = 'http://app.misrgidda.com$imageUrl';
//
//        // Return an Image widget to display the image.
//        // return Image(image: NetworkImage(fullImageUrl),fit: BoxFit.cover,);
//        return CachedNetworkImage(
//          fit: BoxFit.fill,
//          imageUrl: fullImageUrl,
//          errorWidget: (context, url, error) => Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//              Icon(Icons.error, color: Colors.red),
//              Text('Failed to load image'),
//            ],
//          ),
//        );
//      }
//      return Image.asset('asstes/icons/Error.png');
//    }
//
// }