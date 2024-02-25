import 'package:all_one/core/networks/api_service.dart';
import 'package:all_one/core/wedgits/app_localization.dart';
import 'package:all_one/features/home/data/repo/repo_types.dart';
import 'package:all_one/features/home/logic/home_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../logic/home_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return BlocProvider(
        create: (BuildContext context) => HomeCubit(TypesRepo(ApiService(Dio())))..fetchTypes(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (BuildContext context, state) {
            var cubit = HomeCubit.get(context);
            return Scaffold(
              extendBody: true,
              // backgroundColor: background,
              body: cubit.screen[cubit.currentIndex],
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: BottomNavigationBar(
                    elevation: 0,
                    backgroundColor:Colors.transparent,
                    // selectedItemColor: Colors.white,
                    currentIndex: cubit.currentIndex,
                    onTap: (index) {
                      cubit.changeBottonNav(index);

                    },
                    items:  [
                      BottomNavigationBarItem(
                          icon: SvgPicture.asset('asstes/svgs/icons8-home.svg',color: Colors.black87 ,width: 25,height: 25,), label: 'Home'.tr),
                      BottomNavigationBarItem(
                          icon: SvgPicture.asset('asstes/svgs/flame-icon.svg',color: Colors.black87,width: 25, height: 25,),
                          label: 'Offers'.tr,
                      ),
                      BottomNavigationBarItem(
                          icon: SvgPicture.asset('asstes/svgs/icons8-setting.svg',color: Colors.black87,width: 25, height: 25,),
                          label: 'Setting'.tr),
                    ]),
              ),

            );
          },
        ));
  }
}

//PersistentTabView(
//               context,
//               controller: controller,
//               screens: cubit.buildScreens(),
//               items: cubit.navBarsItems(context),
//               // confineInSafeArea: true,
//               backgroundColor: Colors.white, // Default is Colors.white.
//               // handleAndroidBackButtonPress: true, // Default is true.
//               resizeToAvoidBottomInset:
//                   true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
//               // stateManagement: true, // Default is true.
//               hideNavigationBarWhenKeyboardShows:
//                   true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
//               decoration: NavBarDecoration(
//                   borderRadius: BorderRadius.circular(10.0),
//                   colorBehindNavBar: Colors.white),
//               popAllScreensOnTapOfSelectedTab: true,
//               popActionScreens: PopActionScreensType.once,
//
//               itemAnimationProperties: const ItemAnimationProperties(
//                 // Navigation Bar's items animation properties.
//                 duration: Duration(milliseconds: 50),
//                 curve: Curves.ease,
//               ),
//               screenTransitionAnimation: const ScreenTransitionAnimation(
//                 // Screen transition animation on change of selected tab.
//                 animateTabTransition: true,
//                 curve: Curves.ease,
//                 duration: Duration(milliseconds: 50),
//               ),
//               navBarStyle: NavBarStyle
//                   .style1, // Choose the nav bar style with this property.
//             );