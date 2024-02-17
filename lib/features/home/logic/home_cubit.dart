import 'dart:async';

import 'package:all_one/core/wedgits/app_localization.dart';
import 'package:all_one/features/home/logic/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../offers/test.dart';
import '../../offers/ui/offers_screen.dart';
import '../../setting/ui/setting.dart';
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

  List<PersistentBottomNavBarItem> navBarsItems(context) {
    return [
      PersistentBottomNavBarItem(
        activeColorPrimary: const Color(0xFFB768A2),
        icon: SvgPicture.asset('asstes/svgs/icons8-home.svg',color: Colors.black87,),
        title: ("Home".tr),
      ),
      PersistentBottomNavBarItem(
          activeColorPrimary: const Color(0xFFB768A2),
          icon: SvgPicture.asset('asstes/svgs/flame-icon.svg',color: Colors.black87,),
          title: 'Offers'.tr),
      PersistentBottomNavBarItem(
          activeColorPrimary: const Color(0xFFB768A2),
          icon: SvgPicture.asset('asstes/svgs/icons8-setting.svg',color: Colors.black87,),
          title: 'Setting'.tr),
    ];
  }
  final Set<Marker> markers = Set();
  StreamSubscription<Position>? positionStream;
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
    emit(TypesLoading());
    final result = await repo.getTypes();
    result.when(
      success: (types) => emit(TypesSuccess(types)),
      failure: (error) =>             emit(TypesError(error.apiErrorModel.message ?? '')),
    );
    // try{
    //   emit(TypesSuccess(result.data));
    // }catch(e){
    //   emit(TypesError(result.error!.apiErrorModel.message ?? ''));
    // }
  }
  // void fetchProduct() async {
  //   emit(ProductLoading());
  //   final result = await repo.getProduct();
  //   result.when(
  //     success: (types) => emit(ProductSuccess(types)),
  //     failure: (error) =>             emit(ProductError(error.apiErrorModel.message ?? '')),
  //   );
  // }

}
