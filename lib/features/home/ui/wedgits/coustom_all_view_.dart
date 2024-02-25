import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/helper/chache_helper.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/wedgits/error.dart';
import '../../../../core/wedgits/loading_coustom_all_view.dart';
import '../../data/model/product_offer.dart';
import '../../logic/product_cuibt/product_cuibt_cubit.dart';
import '../../logic/product_cuibt/product_cuibt_state.dart';
import 'details_product.dart';

class CustomAllView extends StatefulWidget {
  const CustomAllView({super.key});

  @override
  State<CustomAllView> createState() => _CustomAllViewState();
}

class _CustomAllViewState extends State<CustomAllView> {
  final lang = CacheHelper.getData(key: 'lang') ?? 'en';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCuibtCubit, ProductCuibtState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const LoadingCoustomAllView();
        } else if (state is ProductSuccess) {
          // Render your list here
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              String? changeLang =
                  state.productOffers.data![index].translations!
                      .firstWhere(
                        (title) => title.locale!.endsWith(lang),
                  )
                      .title;
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsProduct(
                                productItems: state.productOffers.data![index],
                              )));
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
                                    child: buildProductImage(state.productOffers.data![index]),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
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
              );
            },
            itemCount: state.productOffers.data!.length,
          );
        } else if (state is ProductError) {
          // Handle error state
          //
          return state.error == 'defaultError'
              ? const LoadingCoustomAllView()
              : CustomErrorWidget(
            errMessage: state.error,
          );
        }
        return Container(
          height: 40,
        ); // Fallback
      },
    );
  }

  Widget buildProductImage(DataProduct product) {
    // Find the first image file that is an actual image (ignoring non-image files).

    // String? imageUrl = product.files?.firstWhere(
    //       (file) => file.image!.endsWith('.jpg') || file.image!.endsWith('.jpeg') || file.image!.endsWith('.png'),
    //   orElse: () => null, // Use orElse to handle the case when no valid image is found.
    //
    // ).image;
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
}