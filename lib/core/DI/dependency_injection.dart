import 'package:all_one/core/networks/api_service.dart';
import 'package:all_one/core/networks/dio_factory.dart';
import 'package:all_one/features/home/data/repo/Product_repo.dart';
import 'package:all_one/features/home/logic/home_cubit.dart';
import 'package:all_one/features/offers/data/repo/offer_repo.dart';
import 'package:all_one/features/offers/logic/offers_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/login/data/repo/login_repo.dart';
import '../../features/auth/login/logic/login_cubit.dart';
import '../../features/auth/register/data/repo/register_repo.dart';
import '../../features/auth/register/logic/register_cubit.dart';
import '../../features/home/data/repo/repo_types.dart';
import '../../features/home/logic/product_cuibt/product_cuibt_cubit.dart';


final getIt = GetIt.instance;

// Future<void> setupGetIt() async{
//
//   Dio dio =  DioFactory.getDio();
//   getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
//
//   // // login
//   // getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
//   // getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
//   // // register
//   // getIt.registerLazySingleton<RegisterRepo>(() => RegisterRepo(getIt()));
//   // getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt()));
//   //
//   // getIt.registerLazySingleton<TypesRepo>(() => TypesRepo(getIt()));
//   // getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));
//   //
//   // getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
//
//   // login
//   getIt.registerFactory<LoginRepo>(() => LoginRepo(ApiService(Dio())));
//   getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
//   // register
//   getIt.registerFactory<RegisterRepo>(() => RegisterRepo(getIt()));
//   getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt()));
//
//   getIt.registerFactory<TypesRepo>(() => TypesRepo(getIt()));
//   getIt.registerFactory<ProductRepo>(() => ProductRepo(getIt()));
//   getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));
// }
Future<void> setupGetIt() async {
  Dio dio = Dio(); // Assuming DioFactory.getDio() essentially does this
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // Repositories
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerLazySingleton<RegisterRepo>(() => RegisterRepo(getIt()));
  getIt.registerLazySingleton<TypesRepo>(() => TypesRepo(getIt()));
  getIt.registerLazySingleton<ProductRepo>(() => ProductRepo(getIt()));
  getIt.registerLazySingleton<OfferRepo>(() => OfferRepo(getIt()));

  // Cubits
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));
  getIt.registerFactory<ProductCuibtCubit>(() => ProductCuibtCubit(getIt()));
  // getIt.registerFactory<OffersCubit>(() => OffersCubit(getIt()));
}