

import 'package:all_one/core/routing/routes.dart';
import 'package:all_one/features/auth/login/ui/wedgits/forgt_password.dart';
import 'package:all_one/features/home/data/model/model.dart';
import 'package:all_one/features/home/data/model/product_offer.dart';
import 'package:all_one/features/home/ui/wedgits/category_screen.dart';
import 'package:all_one/features/home/ui/wedgits/details_product.dart';
import 'package:all_one/features/offers/logic/offers_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/login/logic/login_cubit.dart';
import '../../features/auth/login/ui/login_screen.dart';
import '../../features/auth/register/logic/register_cubit.dart';
import '../../features/auth/register/ui/register_screen.dart';
import '../../features/home/data/repo/repo_types.dart';
import '../../features/home/logic/home_cubit.dart';
import '../../features/home/ui/home_view.dart';
import '../../features/notification/ui/notification_screen.dart';
import '../../features/offers/data/repo/offer_repo.dart';
import '../../features/offers/logic/offers_cubit.dart';
import '../../features/offers/ui/offers_screen.dart';
import '../DI/dependency_injection.dart';
import '../networks/api_service.dart';

class AppRouter{

  //  Route generateRoute(RouteSettings settings){
  //    final arguments = settings.arguments;
  //   switch(settings.name) {
  //
  //       case Routes.offerScreen:
  //       return MaterialPageRoute(
  //         builder: (_) => BlocProvider(
  //             create: (context) => OffersCubit(OfferRepo()),
  //             child:  Offers()),
  //       );
  //     case Routes.detailsProduct:
  //       return MaterialPageRoute(
  //         builder: (_) =>  DetailsProduct(productItems: arguments as ProductItems,),
  //       );
  //     case Routes.loginScreen:
  //       return MaterialPageRoute(
  //         builder: (_) => BlocProvider(
  //             create: (context) => getIt<LoginCubit>(),
  //             child:  LoginScreen())
  //       );
  //     case Routes.registerScreen:
  //       return MaterialPageRoute(
  //           builder: (_) => BlocProvider(
  //               create: (context) => getIt<RegisterCubit>(),
  //               child:  RegisterScreen())
  //       );
  //     case Routes.notificationScreen:
  //       return MaterialPageRoute(builder: (_) => const NotificationScreen());
  //     case Routes.homeScreen:
  //       return MaterialPageRoute(
  //         builder: (_) =>  HomeView(),
  //       );
  //
  //     default: return MaterialPageRoute(
  //         builder: (_) => Scaffold(
  //           body:  Center(child:
  //           Text('No Route default for ${settings.name}'),),
  //         )
  //     );
  //   }
  //
  // }
   Route? generateRoute(RouteSettings settings) {
     final arguments = settings.arguments;

     switch (settings.name) {
       case Routes.offerScreen:
         return MaterialPageRoute(
           builder: (_) => const Offers(),
         );
       case Routes.notificationScreen:
         return MaterialPageRoute(
           builder: (_) => const NotificationScreen(),
         );

       case Routes.forgotPassword:
         return MaterialPageRoute(
           builder: (_) => const ForgotPassword(),
         );
       case Routes.loginScreen:
         return MaterialPageRoute(
             builder: (_) => BlocProvider(
                 create: (context) => getIt<LoginCubit>(),
                 child:  const LoginScreen())
         );

       case Routes.registerScreen:
         return MaterialPageRoute(
             builder: (_) => BlocProvider(
                 create: (context) => getIt<RegisterCubit>(),
                 child:  const RegisterScreen())
         );

       case Routes.homeScreen:
         return MaterialPageRoute(
           builder: (_) =>  const HomeView(),
         );


       case Routes.detailsProduct:
         return MaterialPageRoute(
           builder: (_) =>  DetailsProduct(productItems: arguments as DataProduct, ),
         );
       case Routes.categoryScreen:
         return MaterialPageRoute(
           builder: (_) =>  BlocProvider(
               create: (BuildContext context) => HomeCubit(TypesRepo(ApiService(Dio())))..fetchTypes(),
               child: const CategoryScreen()),
         );
     }
   }
}