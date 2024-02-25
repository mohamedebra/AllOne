import 'package:all_one/core/helper/extensions.dart';
import 'package:all_one/core/theming/styles.dart';
import 'package:all_one/features/home/data/model/ads/ads_model.dart';
import 'package:all_one/features/home/logic/ads_cubit/ads_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controller/ads_controller.dart';
import '../../../../core/helper/chache_helper.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/wedgits/error.dart';
import '../../../../core/wedgits/loading_ads.dart';
import '../../../../core/wedgits/loding_category.dart';

class Ads extends StatefulWidget {
  const Ads({super.key});

  @override
  State<Ads> createState() => _AdsState();
}

class _AdsState extends State<Ads> {
  @override
  Widget build(BuildContext context) {
    var controllerAds = Get.put(AdsController());
    final lang = CacheHelper.getData(key: 'lang') ?? 'en';

    return BlocBuilder<AdsCubit,AdsState>(
        builder: (context,state){
      if(state is AdsLoading){
        return const LoadingCategory();
      }
      if(state is AdsSuccess){
        return Padding(
          padding: const EdgeInsets.only(bottom: 70),
          child: SizedBox(
            height: 75,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  String title = state.adsModel.data![index].translations!
                      .firstWhere(
                        (title) => title.locale!.endsWith(lang),
                  )
                      .title?? '';
                  String description = state.adsModel.data![index].translations!
                      .firstWhere(
                        (title) => title.locale!.endsWith(lang),
                  )
                      .description ?? '';
              if(state.adsModel.data![index].visible == 1) {
                if(context.read<AdsCubit>().isClose == true) {

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Column(
                              children: [
                                const SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 70,
                                      child: buildProductImage(state.adsModel.data![index]),
                                    ),
                                    Container(
                                      color: Colors.grey[700],
                                      height: 70,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 7),
                                            child: Text(
                                              title,
                                              style: GoogleFonts.cabin(
                                                  textStyle:
                                                  TextStyles.font16WhiteMedium),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 7),
                                            child: SizedBox(
                                              width:
                                              MediaQuery.sizeOf(context).width /
                                                  2,
                                              child: Text(
                                                description,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.cabin(
                                                    textStyle:
                                                    TextStyles.font14WhiteMedium),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 1.07,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: GetBuilder(
                                  init: AdsController(),
                                  builder: (controller) {
                                    return CircleAvatar(
                                      radius: 12,
                                      backgroundColor: ColorsManager.lighterGray,
                                      child: IconButton(
                                          onPressed: () {
                                            context.read<AdsCubit>().changeCloseTrue();
                                            print('isClose: ${context.read<AdsCubit>().isClose}');

                                          },
                                          icon: SvgPicture.asset(
                                              'asstes/svgs/211652_close_icon.svg')),
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }
                else{
                  return const SizedBox();
                }
              }
              if(state.adsModel.data![index].visible == 0) {
                return  const SizedBox();
              }
            },
              itemCount: state.adsModel.data!.length,

            ),
          ),
        );


      }
      if(state is AdsError){
        return state.error == 'defaultError'
            ? const LoadingAds()
            : CustomErrorWidget(
          errMessage: state.error,
        );
      }
        else{
          return SizedBox();
      }
        }

    );
  }

  Widget buildProductImage(DataAds product) {
    // Find the first image file that is an actual image (ignoring non-image files).

    // String? imageUrl = product.files?.firstWhere(
    //       (file) => file.image!.endsWith('.jpg') || file.image!.endsWith('.jpeg') || file.image!.endsWith('.png'),
    //   orElse: () => null, // Use orElse to handle the case when no valid image is found.
    //
    // ).image;
    String? imageUrl = product.image;

    // Check if an image URL was found and is not null.
    if (imageUrl != null) {
      // Complete the URL if necessary (if the stored URL is relative).
      String fullImageUrl = 'http://app.misrgidda.com$imageUrl';

      // Return an Image widget to display the image.
      // return Image(image: NetworkImage(fullImageUrl),fit: BoxFit.cover,);
      return CachedNetworkImage(
        fit: BoxFit.fill,
        width: MediaQuery.sizeOf(context).width / 2.5,
        // fit: BoxFit.cover,
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

}


//Card(
//                 elevation: .5,
//                 child: Stack(
//                   children: [
//                     SizedBox(
//                       width: MediaQuery.sizeOf(context).width / 1.1,
//                       height: 50,
//                       child: Column(
//                         children: [Text('لا يوجد اعلان ')],
//                       ),
//                     ),
//                     // SizedBox(
//                     //   width: MediaQuery.sizeOf(context).width / 1.1,
//                     //   child: Align(
//                     //     alignment: Alignment.bottomRight,
//                     //     child: CircleAvatar(
//                     //       radius: 12,
//                     //       backgroundColor: ColorsManager.lighterGray,
//                     //       child: IconButton(
//                     //           onPressed: () {
//                     //             setState(() {
//                     //               state.adsModel.data![0].visible == 1;
//                     //             });
//                     //             // controller.changeCloseTrue();
//                     //           },
//                     //           icon: SvgPicture.asset(
//                     //               'asstes/svgs/arrow_back-1.svg')),
//                     //     ),
//                     //   ),
//                     // )
//                   ],
//                 ),
//               )

//Stack(
//                     children: [
//                       SizedBox(
//                         height: 70,
//                         child: Image(
//                           image: AssetImage('asstes/images/2.jpg'),
//                           width: MediaQuery.sizeOf(context).width / 1.1,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           if (lang == 'en') SizedBox(),
//                           if (lang == 'ar')SizedBox(
//                             width: MediaQuery.sizeOf(context).width / 1.25,
//                           ),
//                           Column(
//
//                             children: [
//                               Container(
//                                 color: Colors.white70,
//
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 7),
//                                   child: Text(
//                                     'Dierbergs markets',
//                                     style: GoogleFonts.cabin(
//                                         textStyle: TextStyles.font16BlackSemiBold),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 color: Colors.white70,
//
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 7),
//                                   child: SizedBox(
//                                     width: 200,
//                                     child: Text(
//                                       'jbJQBDFJqebfjabsfjwbelfBEFDHILEWbfwBAJDBJKBDJEBDJEBJDSB',
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: GoogleFonts.cabin(
//                                           textStyle: TextStyles.font16BlackSemiBold),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         width: MediaQuery.sizeOf(context).width / 1.1,
//                         child: Align(
//                           alignment: Alignment.bottomRight,
//                           child: GetBuilder(
//                             init: AdsController(),
//                             builder: (controller) {
//                               return CircleAvatar(
//                                 radius: 12,
//                                 backgroundColor: ColorsManager.lighterGray,
//                                 child: IconButton(
//                                     onPressed: () {
//                                       controller.changeCloseFalse();
//                                     },
//                                     icon: SvgPicture.asset(
//                                         'asstes/svgs/211652_close_icon.svg',)),
//                               );
//                             },
//                           ),
//                         ),
//                       )
//                     ],
//                   )
