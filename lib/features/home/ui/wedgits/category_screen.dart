import 'package:all_one/features/home/logic/home_cubit.dart';
import 'package:all_one/features/home/logic/home_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/helper/chache_helper.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/networks/api_service.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/wedgits/error.dart';
import '../../../../core/wedgits/loding.dart';
import '../../../../core/wedgits/loding_category.dart';
import '../../data/model/model.dart';
import '../../data/model/model_types.dart';
import '../../data/repo/repo_types.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<HomeCubit>(context).fetchTypes();

    super.initState();
  }
  final lang = CacheHelper.getData(key: 'lang') ?? 'en';

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => HomeCubit(TypesRepo(ApiService(Dio())))..fetchTypes(),

      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is TypesLoading) {
                return  Padding(
                  padding: EdgeInsets.only(top: 50.h,right: 20.w,left: 20.w),
                  child: const LoadingCategory(),
                );
              } else if (state is TypesSuccess) {

                // Render your list here
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30.w,top: 30.h,bottom: 10.h,right: 30.w),
                      child:  Text('Category'.tr,style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: .3,
                        ),
                        itemBuilder: (context, index) {

                          final imageUrl = 'http://app.misrgidda.com/${state.types.data![index].image!.image!}';
                          String? changeLang = state.types.data![index].translations!.firstWhere(
                                (TranslationLang translation) => translation.locale!.endsWith(lang),
                            orElse: () => TranslationLang(),
                          )?.title;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Column(
                              children: [
                                if (imageUrl != null)

                                  Image.network(imageUrl,width: 33.w,),
                                if (imageUrl == null)
                                  Image.asset('asstes/icons/Error.png',width: 35.w,),
                                verticalSpace(15.h),
                                Text(changeLang ?? 'no category',style: TextStyles.font13GrayRegular,)
                              ],
                            ),
                          );
                        },
                        itemCount: state.types.data!.length,
                      ),
                    )
                  ],
                );
              } else if (state is TypesError) {
                // Handle error state
                //
              return state.error == 'defaultError' ? const CustomLoadingIndicator() :CustomErrorWidget(errMessage: state.error,);

              }
              return SizedBox.shrink(); // Fallback
            },
          ),
        ),
      ),
    );
  }
  // Widget buildProductImage(DataProduct product) {
  //   // Find the first image file that is an actual image (ignoring non-image files).
  //
  //   // String? imageUrl = product.files?.firstWhere(
  //   //       (file) => file.image!.endsWith('.jpg') || file.image!.endsWith('.jpeg') || file.image!.endsWith('.png'),
  //   //   orElse: () => null, // Use orElse to handle the case when no valid image is found.
  //   //
  //   // ).image;
  //   String? imageUrl = product.files
  //       ?.firstWhere(
  //           (file) =>
  //       file.image!.endsWith('.jpg') ||
  //           file.image!.endsWith('.jpeg') ||
  //           file.image!.endsWith('.png'),
  //       orElse: () => Files(
  //           fileType:
  //           'asstes/images/2.jpg') // Use orElse to handle the case when no valid image is found.
  //   )
  //       .image;
  //
  //   // Check if an image URL was found and is not null.
  //   if (imageUrl != null) {
  //     // Complete the URL if necessary (if the stored URL is relative).
  //     String fullImageUrl = 'http://app.misrgidda.com$imageUrl';
  //
  //     // Return an Image widget to display the image.
  //     // return Image(image: NetworkImage(fullImageUrl),fit: BoxFit.cover,);
  //     return CachedNetworkImage(
  //       fit: BoxFit.fill,
  //       imageUrl: fullImageUrl,
  //       errorWidget: (context, url, error) => Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Icon(Icons.error, color: Colors.red),
  //           Text('Failed to load image'),
  //         ],
  //       ),
  //     );
  //   }
  //   return Container();
  // }

}
