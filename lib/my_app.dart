

import 'package:all_one/core/routing/app_router.dart';
import 'package:all_one/features/home/data/repo/Product_repo.dart';
import 'package:all_one/features/home/data/repo/repo_ads.dart';
import 'package:all_one/features/home/logic/ads_cubit/ads_cubit.dart';
import 'package:all_one/features/home/logic/home_cubit.dart';
import 'package:all_one/features/home/logic/product_cuibt/product_cuibt_cubit.dart';
import 'package:all_one/features/notification/data/repo/notaification_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/locale/locale.dart';
import 'core/locale/locale_controller.dart';
import 'core/networks/api_service.dart';
import 'core/routing/routes.dart';
import 'core/theming/colors.dart';
import 'features/home/data/repo/repo_types.dart';
import 'features/notification/logic/notification_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    MyLocaleController controller =  Get.put(MyLocaleController());
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductCuibtCubit(ProductRepo(ApiService(Dio())))..fetchProduct()),
        BlocProvider(create: (context) => HomeCubit(TypesRepo(ApiService(Dio())))..fetchTypes()),
        BlocProvider(create: (context) => AdsCubit(RepoAds(ApiService(Dio())))..fetchAds()),
        BlocProvider(create: (context) => NotificationCubit(NoteRepo(ApiService(Dio())))..fetchNote()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        child: GetMaterialApp(
          locale: controller.initLang,
          translations: MyLocale(),
          debugShowCheckedModeBanner: false,
          title: "All One",
          theme: ThemeData(
              primaryColor: ColorsManager.mainMauve
          ),

          initialRoute: Routes.homeScreen,
          onGenerateRoute: appRouter.generateRoute,
          onUnknownRoute: appRouter.generateRoute,
        ),
      ),
    );
  }
}
