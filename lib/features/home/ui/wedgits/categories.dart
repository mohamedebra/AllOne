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
import '../../../../core/helper/ads_manager.dart';
import '../../../../core/helper/chache_helper.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/wedgits/error.dart';
import '../../../../core/wedgits/loding.dart';
import '../../../../core/wedgits/loding_category.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  final lang = CacheHelper.getData(key: 'lang') ?? 'en';
  final types = CacheHelper.getData(key: 'types');


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
              padding:  EdgeInsets.only(top: 10.h),
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
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(

                        children: [
                      for (int i = 0; i < state.types.data!.length; i++)

                        Padding(
                          padding:  EdgeInsets.only(right: 20.w,left: 7.w),
                          child: Column(

                            children: [
                              SizedBox(
                                height: 40.h,width: 30.w,
                                child:
                                CachedNetworkImage(
                                  imageUrl: 'http://app.misrgidda.com/${state.types.data![i].image!.image!}',
                                  errorWidget: (context,url,error)=> Icon(Icons.error),
                                ), // Use the full URL here
                              ),
                              verticalSpace(10.h),
                              Text(state.types.data![i].translations!.firstWhere(
                                    (TranslationLang translation) => translation.locale!.endsWith(lang),
                                orElse: () => TranslationLang(),
                              ).title ?? 'no category',style: TextStyles.font13GrayRegular,)
                            ],
                          ),
                        ),
                    ]),
                  ),
                ],
              );
            } else if (state is TypesError) {
              return state.error == 'defaultError' ? const LoadingCategory() : CustomErrorWidget(errMessage: state.error,);
            }
            return Container(height: 40,); // Fallback
          },
        ),
        SizedBox(height: 5.h,),


      ],
    );
  }
}
//      return
// CachedNetworkImage(
//         imageUrl: fullImageUrl,
//         errorWidget: (context,url,error)=> Icon(Icons.error),
//       );