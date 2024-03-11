import 'package:all_one/features/home/ui/wedgits/goggle_maps_product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
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
  ScrollController scrollController = ScrollController();

  scroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      BlocProvider.of<ProductCuibtCubit>(context).loadNextPage();
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    scrollController.addListener(_onScroll);
    // Initial fetch for the first page of products
    // context.read<ProductCuibtCubit>().fetchProduct();
    super.initState();
  }
  void _onScroll() {
    if (_isBottom) context.read<ProductCuibtCubit>().loadNextPage();
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9); // Adjust the threshold as needed
  }
  void callNumber(DataProduct product) async {
    String number = product.weight!; //set the number here
   await FlutterPhoneDirectCaller.callNumber(number!);
  }
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ProductCuibtCubit, ProductCuibtState>(
      builder: (context, state) {

        if (state is ProductLoading) {
          return const LoadingCoustomAllView();
        }  if (state is ProductSuccess) {
          // Render your list here
          return   ListView.builder(
            // controller: scrollController,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,

            itemCount: state.productOffers.length ,
            itemBuilder: (context, i) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsProduct(
                                productItems:
                                state.productOffers[i],
                              )));
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.topCenter,
                              children: [
                                Container(

                                  decoration:  BoxDecoration(
                                    borderRadius: BorderRadius.circular(25)
                                  ),
                                  width: 70.w,
                                  height: 75.h,
                                  child: buildProductImage(
                                      state.productOffers[i]),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 15.w),
                                  child: Image(
                                    image: const AssetImage(
                                        'asstes/icons/special-png.png'),
                                    width: 55.w,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            .5,
                                        child: Text(state.productOffers![i].translations!
                                            .firstWhere(
                                              (title) => title.locale!.endsWith(lang),
                                        )
                                            .title ?? 'No title',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                            TextStyles.font14DarkBlueMedium),
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            .5,
                                        child: Text(
                                            "${'Bestoffers'.tr + state.productOffers![i].translations!
                                                .firstWhere(
                                                  (title) => title.locale!.endsWith(lang),
                                            )
                                                .title!}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyles.font14GrayRegular),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      InkWell(
                                        onTap: () => callNumber(state.productOffers[i]),
                                        child: CircleAvatar(
                                          radius: 10.h,
                                          backgroundImage: const AssetImage('asstes/icons/phone-call-icon.png'),
                                        ),
                                      ),
                                      SizedBox(height: 7.h,),
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  GoogleMapsProduct(dataProduct:state.productOffers![i],)));

                                        },
                                        child: CircleAvatar(
                                          radius: 10.h,
                                          backgroundImage: const AssetImage('asstes/icons/61021.png'),
                                        ),
                                      ),

                                    ],
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 7.h,)
                      ],
                    ),
                  ),

                ],
              );

            },
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
        errorWidget: (context, url, error) => const Column(
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
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
