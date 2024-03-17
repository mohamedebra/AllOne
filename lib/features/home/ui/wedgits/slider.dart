

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/wedgits/app_text_button.dart';
import '../../../../core/wedgits/error.dart';
import '../../../../core/wedgits/loading_coustom_all_view.dart';
import '../../logic/product_cuibt/product_cuibt_cubit.dart';
import '../../logic/product_cuibt/product_cuibt_state.dart';
import 'google_maps.dart';

class SliderAppBar extends StatelessWidget {
  const SliderAppBar({super.key, });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCuibtCubit,ProductCuibtState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return  Container(
            height: 190.h,
            width: MediaQuery.of(context).size.width *.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [
                    0,
                    .6,
                    1
                  ],
                  colors: [
                    Color(0xFFDF98FA),
                    Color(0xFFB070FD),
                    Color(0xFFB768A2)
                  ]),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("catch_up_and_request_your_offers".tr,
                          style: GoogleFonts.cabin(
                            textStyle:  TextStyles.font18WhiteSemiBold,
                          )

                      ),
                      SizedBox(height: 20.h,),
                      AppTextButton(
                          backgroundColor: Colors.white,
                          buttonWidth: 120,
                          buttonHeight: 40.h,
                          verticalPadding: 0,
                          horizontalPadding: 0,
                          buttonText: "find_nearby".tr,
                          textStyle: TextStyles.font14BlueSemiBold,
                          onPressed: (){

                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>  GoogleMapScreen(dataProduct: state.productOffers,)));
                          }
                      )
                    ],
                  ),
                ),

                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                          height: 120.h,
                          width: 120.w,
                          child: SvgPicture.asset('asstes/svgs/offer-svgrepo-com.svg')),

                    ],
                  ),
                ),
              ],
            ),
          );
        }
         if (state is ProductSuccess) {
          // Render your list here
          return   Container(
            height: 190.h,
            width: MediaQuery.of(context).size.width *.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [
                    0,
                    .6,
                    1
                  ],
                  colors: [
                    Color(0xFFDF98FA),
                    Color(0xFFB070FD),
                    Color(0xFFB768A2)
                  ]),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("catch_up_and_request_your_offers".tr,
                          style: GoogleFonts.cabin(
                            textStyle:  TextStyles.font18WhiteSemiBold,
                          )

                      ),
                      SizedBox(height: 20.h,),
                      AppTextButton(
                          backgroundColor: Colors.white,
                          buttonWidth: 120,
                          buttonHeight: 40.h,
                          verticalPadding: 0,
                          horizontalPadding: 0,
                          buttonText: "find_nearby".tr,
                          textStyle: TextStyles.font14BlueSemiBold,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>  GoogleMapScreen(dataProduct: state.productOffers,)));
                          }
                      )
                    ],
                  ),
                ),

                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                          height: 120.h,
                          width: 120.w,
                          child: SvgPicture.asset('asstes/svgs/offer-svgrepo-com.svg')),

                    ],
                  ),
                ),
              ],
            ),
          );

        } else if (state is ProductError) {
          // Handle error state
          //
          return state.error == 'defaultError'
              ? const LoadingCoustomAllView()
              : CustomErrorWidget(
            errMessage: state.error,
          );
        }
        return  Container(
          height: 190.h,
          width: MediaQuery.of(context).size.width *.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
                  0,
                  .6,
                  1
                ],
                colors: [
                  Color(0xFFDF98FA),
                  Color(0xFFB070FD),
                  Color(0xFFB768A2)
                ]),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("catch_up_and_request_your_offers".tr,
                        style: GoogleFonts.cabin(
                          textStyle:  TextStyles.font18WhiteSemiBold,
                        )

                    ),
                    SizedBox(height: 20.h,),
                    AppTextButton(
                        backgroundColor: Colors.white,
                        buttonWidth: 120,
                        buttonHeight: 40.h,
                        verticalPadding: 0,
                        horizontalPadding: 0,
                        buttonText: "find_nearby".tr,
                        textStyle: TextStyles.font14BlueSemiBold,
                        onPressed: (){

                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>  GoogleMapScreen(dataProduct: state.productOffers,)));
                        }
                    )
                  ],
                ),
              ),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                        height: 120.h,
                        width: 120.w,
                        child: SvgPicture.asset('asstes/svgs/offer-svgrepo-com.svg')),

                  ],
                ),
              ),
            ],
          ),
        );
      },

    );
  }
}
