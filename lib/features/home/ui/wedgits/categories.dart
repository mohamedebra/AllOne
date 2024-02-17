import 'package:admob_flutter/admob_flutter.dart';
import 'package:all_one/core/helper/extensions.dart';
import 'package:all_one/core/wedgits/app_localization.dart';
import 'package:all_one/features/home/data/model/model.dart';
import 'package:all_one/features/home/data/model/model_types.dart';
import 'package:all_one/features/home/logic/home_cubit.dart';
import 'package:all_one/features/home/logic/home_state.dart';
import 'package:all_one/features/home/ui/wedgits/category_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:native_ads_flutter/native_ads.dart';
import '../../../../core/helper/ads_manager.dart';
import '../../../../core/helper/chache_helper.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/wedgits/error.dart';
import '../../../../core/wedgits/loding.dart';
import '../../../../core/wedgits/loding_category.dart';
import '../../data/model/model_products.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  final lang = CacheHelper.getData(key: 'lang') ?? 'en';


  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().fetchTypes();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('categories'.tr,style: TextStyles.font20BlueBold,),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextButton(onPressed: (){
                context.pushNamed(Routes.categoryScreen);
              }, child: Text("see_all".tr,style: TextStyles.font14BlueSemiBold,)),
            )

          ],
        ),

        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is TypesLoading) {
              return const LoadingCategory();
            } else if (state is TypesSuccess) {
              // Render your list here
              return Column(
                children: [
                  SizedBox(
                    height: 75.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        final imageUrl = 'http://app.misrgidda.com/${state.types.data![index].image!.image!}';
                        String? changeLang = state.types.data![index].translations!.firstWhere(
                              (TranslationLang translation) => translation.locale!.endsWith(lang),
                          orElse: () => TranslationLang(),
                        )?.title;
                        return  Padding(
                          padding: const EdgeInsets.only(right: 20,left: 7),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40,width: 30,
                                child:
                                CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  errorWidget: (context,url,error)=> Icon(Icons.error),
                                ), // Use the full URL here
                              ),
                              verticalSpace(10.h),
                              Text(changeLang ?? 'no category',style: TextStyles.font13GrayRegular,)
                            ],
                          ),
                        );

                      },
                      itemCount: state.types.data!.length,
                    ),
                  ),
                ],
              );
            } else if (state is TypesError) {
              return state.error == 'defaultError' ? const LoadingCategory() : CustomErrorWidget(errMessage: state.error,);
            }
            return Container(height: 40,); // Fallback
          },
        ),
      ],
    );
  }
}
//      return
// CachedNetworkImage(
//         imageUrl: fullImageUrl,
//         errorWidget: (context,url,error)=> Icon(Icons.error),
//       );