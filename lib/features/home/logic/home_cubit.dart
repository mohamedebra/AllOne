import 'dart:async';
import 'dart:convert';

import 'package:all_one/core/fanction/fanction.dart';
import 'package:all_one/core/helper/chache_helper.dart';
import 'package:all_one/core/networks/api_constants.dart';
import 'package:all_one/core/wedgits/app_localization.dart';
import 'package:all_one/features/home/data/model/model_types.dart';
import 'package:all_one/features/home/logic/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import '../../../core/sql/sql_data.dart';
import '../../offers/ui/offers_screen.dart';
import '../../setting/ui/setting.dart';
import '../data/model/model_local/local_model.dart';
import '../data/model/product_offer.dart';
import '../data/repo/repo_types.dart';
import '../ui/home_Screen.dart';

class HomeCubit extends Cubit<HomeState> {
  final TypesRepo repo;

  HomeCubit(this.repo,) : super(HomeInit());
  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;


  List<Widget> buildScreens() {
    return [
      const HomeScreen(),
      const Offers(),
      const Setting(),
    ];
  }
List screen = [
  const HomeScreen(),
  const Offers(),
  const Setting(),
];

  final Set<Marker> markers = Set();
  StreamSubscription<Position>? positionStream;
  List<LocaleModelProduct> listLocal = [];

  void changeBottonNav(index) {
    currentIndex = index;
    emit(ChangeNavBar());
  }

  getCurrentLocation(){
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
     positionStream = Geolocator.getPositionStream().listen(
            (Position? position) {
          print(position == null ? 'Unknown' : '${position.latitude.toString()}, ${position.longitude.toString()}');
          print('========================================');
          print(position!.latitude);
          print(position.longitude);
          markers.removeWhere((element) => element.markerId.value == '1');
          markers.add(Marker(
            markerId: const MarkerId('1'),
            position: LatLng(position.latitude, position.longitude),

          ));
          emit(ChangePosition());
            });

  }

  void fetchTypes() async {

    if (state is ProductLoading) {

      var db = DatabaseHelper.instance;
      listLocal =await db.queryAllRows();
      emit(TypesLoading(listLocal));
    } // Prevent concurrent fetches
    final result = await repo.getTypes();
    result.when(
      success: (types) async{
        for (var i = 0; i < types.data!.length; i++)

        {
          var db = DatabaseHelper.instance;
          String? title = types.data![i].translations!
              .firstWhere(
                (title) => title.locale!.endsWith('en'),
          )
              .title;
          int id = types.data![i].id!;
          String imageUrl = types.data![i].image!.image ?? '';
          int quantity = types.data!.length;

          db.insert(LocaleModelProduct(
            title: title,
            id: id,
            image: imageUrl,
            quantity: quantity,
          ));
        }
        emit(TypesSuccess(types.data!));
        },
      failure: (error) =>             emit(TypesError(error.apiErrorModel.message ?? '')),
    );
    // try{
    //   emit(TypesSuccess(result.data));
    // }catch(e){
    //   emit(TypesError(result.error!.apiErrorModel.message ?? ''));
    // }
  }


  // Future<void> _loadCachedData() async {
  //   try {
  //     final cachedProducts = await databaseHelper.getProducts();
  //     if (cachedProducts.isNotEmpty) {
  //       emit(ProductLoaded(cachedProducts));
  //     } else {
  //       emit(ProductError('No data available.'));
  //     }
  //   } catch (e) {
  //     emit(ProductError('Failed to load cached data.'));
  //   }
  // void fetchProduct() async {
  //   emit(ProductLoading());
  //   final result = await repo.getProduct();
  //   result.when(
  //     success: (types) => emit(ProductSuccess(types)),
  //     failure: (error) =>             emit(ProductError(error.apiErrorModel.message ?? '')),
  //   );
  // }

}
