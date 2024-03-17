

import 'package:all_one/core/helper/extensions.dart';
import 'package:all_one/features/home/logic/product_cuibt/product_cuibt_cubit.dart';
import 'package:all_one/features/home/ui/wedgits/ads.dart';
import 'package:all_one/features/home/ui/wedgits/categories.dart';
import 'package:all_one/features/home/ui/wedgits/coustom_all_view_.dart';
import 'package:all_one/features/home/ui/wedgits/details_product.dart';
import 'package:all_one/features/home/ui/wedgits/goggle_maps_product.dart';
import 'package:all_one/features/home/ui/wedgits/slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;
import '../../../controller/ads_controller.dart';
import '../../../core/helper/chache_helper.dart';
import '../../../core/helper/spacing.dart';
import '../../../core/networks/api_service.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../../core/wedgits/error.dart';
import '../../../core/wedgits/loading_ads.dart';
import '../../../core/wedgits/loading_coustom_all_view.dart';
import '../../../core/wedgits/loding.dart';
import '../../../core/wedgits/loding_category.dart';
import '../data/model/ads/ads_model.dart';
import '../data/model/product_offer.dart';
import '../data/repo/Product_repo.dart';
import '../logic/ads_cubit/ads_cubit.dart';
import '../logic/home_cubit.dart';
import '../logic/product_cuibt/product_cuibt_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool isConnected;
  bool isClose = true;
  ScrollController scrollController = ScrollController();


  Future onRefresh() async {
    BlocProvider.of<HomeCubit>(context).fetchTypes();
    BlocProvider.of<ProductCuibtCubit>(context).resetAndFetchProduct();
    BlocProvider.of<AdsCubit>(context).fetchAds();
    setState(() {
      isClose = true;
    });
     isConnected = await checkInternet();

    if (!isConnected) {
      // If no internet, show a widget
      // You can use a Snackbar, AlertDialog, or any other widget to inform the user
      // For example, showing a Snackbar:
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No Internet connection"),
        ),
      );

    }
  }
  Future<bool> checkInternet() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      return connectivityResult != ConnectivityResult.none;
    } catch (e) {
      return false;
    }
  }

  @override
  void initState() {
    onRefresh();
    scrollController.addListener(() {
      scroll();
    });
    super.initState();
  }
  Widget buildProductImageAds(DataAds product) {
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
  void callNumber(DataProduct product) async {
    String number = product.weight!; //set the number here
    await FlutterPhoneDirectCaller.callNumber(number!);
  }

  scroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      BlocProvider.of<ProductCuibtCubit>(context).loadNextPage();
    }
  }

  final lang = CacheHelper.getData(key: 'lang') ?? 'en';


  @override
  Widget build(BuildContext context) {
    final name = CacheHelper.getData(key: 'loginName');

    return BlocBuilder<ProductCuibtCubit,ProductCuibtState>(
      builder: (BuildContext context, ProductCuibtState state) {
        // if(state is ProductLoading ){
        //   return const Center(child: CircularProgressIndicator());
        // }
        if(state is ProductError){
          return noInternet();
        }
        return RefreshIndicator(
          onRefresh: onRefresh,
          child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Stack(
                    children: [
                      // const AdsMob(),
                      BlocBuilder<AdsCubit,AdsState>(
                          builder: (context,state){
                            if(state is AdsLoading){
                              return SizedBox(height: 50.h,);
                            }
                            if(state is AdsSuccess){
                              return SizedBox(
                                height: 120.h,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context,index){
                                    if(state.adsModel.data![index].visible == 1) {
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
                                      if(isClose == true) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Stack(
                                              children: [
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          height: 70.h,
                                                          child: buildProductImageAds(state.adsModel.data![index]),
                                                        ),
                                                        Container(
                                                          color: Colors.grey[700],
                                                          height: 75.h,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Padding(
                                                                padding:  EdgeInsets.symmetric(
                                                                    horizontal: 7.w),
                                                                child: Text(
                                                                  title,
                                                                  style: GoogleFonts.cabin(
                                                                      textStyle:
                                                                      TextStyles.font16WhiteMedium),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:  EdgeInsets.symmetric(
                                                                    horizontal: 7.w),
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
                                                    child: CircleAvatar(
                                                      radius: 12.h,
                                                      backgroundColor: ColorsManager.lighterGray,
                                                      child: IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                               isClose = false;

                                                            });
                                                            print('isClose: ${context.read<AdsCubit>().isClose}');

                                                          },
                                                          icon: SvgPicture.asset(
                                                              'asstes/svgs/211652_close_icon.svg',)),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
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

                      ),
                      Padding(
                          padding:
                          isClose  ? EdgeInsets.only(top: 80.h, right: 20.w, left: 20.w) : EdgeInsets.only(top: 10.h, right: 20.w, left: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text('hi'.tr,
                                          style: GoogleFonts.cairo(
                                              textStyle:
                                              TextStyles.font20BlueBold)),
                                      Text(name ?? "",
                                          style: GoogleFonts.cairo(
                                            textStyle: TextStyles.font20BlueBold,
                                          )),
                                    ],
                                  ),

                                  badges.Badge(
                                    position: badges.BadgePosition.custom(
                                      bottom: 15,
                                    ),
                                    badgeContent: const Text(
                                      "",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    badgeStyle: const badges.BadgeStyle(
                                      badgeColor: Colors.red,
                                      padding: EdgeInsets.all(5),
                                    ),
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: ColorsManager.lighterGray,
                                      child: IconButton(
                                          onPressed: () {
                                            // context.pushNamed(Routes.notificationScreen);
                                            // Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
                                            context.pushNamed(
                                                Routes.notificationScreen);
                                          },
                                          icon: SvgPicture.asset(
                                              'asstes/svgs/Alert.svg')),
                                    ),
                                  )
                                ],
                              ),
                              verticalSpace(18.h),
                              const SliderAppBar(),
                              const Categories(),
                              // verticalSpace(5.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(bottom: 12.h),
                                    child: Text(
                                      "all_offers".tr,
                                      style: TextStyles.font18BlackMedium,
                                    ),
                                  ),
                                ],
                              ),
                              const CustomAllView(),
                                if(context.read<ProductCuibtCubit>().isLoading)
                                  const Center(child: CircularProgressIndicator())

                              // if(state is ProductSuccess)
                            ],
                          )),


                    ],
                  ),
                ),
              )

          ),
        );

      },

    );
  }
  Widget noInternet() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'asstes/icons/no_internet.png',
            color: Colors.red,
            height: 100,
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: const Text(
              "No Internet connection",
              style: TextStyle(fontSize: 22),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: const Text("Check your connection, then refresh the page."),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
            ),
            onPressed: () async {
              // You can also check the internet connection through this below function as well
              ConnectivityResult result = await Connectivity().checkConnectivity();
             await onRefresh();
              print(result.toString());
            },
            child: const Text("Refresh"),
          ),
        ],
      ),
    );
  }
}
