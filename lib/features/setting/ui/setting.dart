import 'package:all_one/controller/offers_controoler.dart';
import 'package:all_one/core/helper/chache_helper.dart';
import 'package:all_one/core/locale/locale_controller.dart';
import 'package:all_one/core/routing/routes.dart';
import 'package:all_one/core/wedgits/app_localization.dart';
import 'package:all_one/core/helper/extensions.dart';
import 'package:all_one/core/helper/spacing.dart';
import 'package:all_one/core/theming/colors.dart';
import 'package:all_one/core/theming/styles.dart';
import 'package:all_one/core/wedgits/app_text_button.dart';
import 'package:all_one/features/auth/login/ui/login_screen.dart';
import 'package:all_one/features/setting/ui/personal_Information.dart';
import 'package:all_one/core/helper/lang_cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final email = CacheHelper.getData(key: 'loginEmail');
  final name = CacheHelper.getData(key: 'loginName');
  final image = CacheHelper.getData(key: 'Image');
  final lang = CacheHelper.getData(key: 'lang');
  @override
  void initState() {
    if (email == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showNullValueDialog(context);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyLocaleController controller = Get.find();
    if (email != null) {
      return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(top: 25.h),
            child: Text(
              'Profile'.tr,
              style: TextStyles.font25WhiteSemiBold,
            ),
          ),
          centerTitle: true,
          backgroundColor: ColorsManager.mainMauve,
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 5,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          height: MediaQuery.sizeOf(context).height / 6,
                          width: double.infinity,
                          color: ColorsManager.mainMauve,
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 10,
                          ),
                          Container(
                            width: double.infinity,
                            height: 80.h,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadiusDirectional.only(
                                  topStart: Radius.circular(50),
                                  topEnd: Radius.circular(50),
                                ),
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ], //?? NetworkImage(image)
                    //AssetImage('asstes/images/person.jpg')
                  ),
                ),
                Text(
                  name ?? "Mo",
                  style: TextStyles.font20BlueBold,
                ),
                Text(
                  email ?? "Mo@gmail",
                  style: TextStyles.font13GrayRegular,
                ),
                verticalSpace(40.h),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) =>  PersonalInformation()));
                //   },
                //   child: Padding(
                //     padding:
                //         EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                //     child: Row(
                //       children: [
                //         SvgPicture.asset(
                //           'asstes/svgs/personalcard.svg',
                //           width: 32,
                //           color: ColorsManager.mainMauve,
                //         ),
                //         horizontalSpace(20.w),
                //         Text(
                //           'Personal_Information'.tr,
                //           style: TextStyles.font16BlackSemiBold,
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'asstes/svgs/language.svg',
                        width: 32,
                        color: ColorsManager.mainMauve,
                      ),
                      horizontalSpace(20.w),
                      Text(
                        'Language'.tr,
                        style: TextStyles.font16BlackSemiBold,
                      ),
                      const Spacer(),
                      DropdownButton(
                          value: lang ?? 'en',
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            size: 12,
                            color: ColorsManager.gray,
                          ),
                          items: ['ar', 'en'].map((String itms) {
                            return DropdownMenuItem(
                                value: itms,
                                child: Text(
                                  itms,
                                  style: TextStyles.font14GrayRegular,
                                ));
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              controller.changeLocale(value.toString());
                            }
                          })
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    GoogleSignIn googleSignIn = GoogleSignIn();
                    googleSignIn.disconnect();
                    CacheHelper.sharedPreferences!.clear();
                    FacebookAuth.instance.logOut();
                    context.pushAndRemoveUntil(Routes.loginScreen,
                        predicate: (Route<dynamic> route) => false);
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'asstes/svgs/logout.svg',
                          width: 32,
                          color: Colors.red,
                        ),
                        horizontalSpace(20.w),
                        Text(
                          'Logout'.tr,
                          style: TextStyles.font16BlackSemiBold
                              .copyWith(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'asstes/icons/Error.png',
                width: MediaQuery.sizeOf(context).width / 3.5,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Please login to your account',
                style:
                    GoogleFonts.cairo(textStyle: TextStyles.font18BlackMedium),
              ),
              const SizedBox(
                height: 15,
              ),
              AppTextButton(
                  buttonText: 'Login',
                  textStyle: TextStyles.font14WhiteMedium,
                  buttonWidth: MediaQuery.sizeOf(context).width * .25,
                  buttonHeight: MediaQuery.sizeOf(context).height * .001,
                  verticalPadding: 4,
                  backgroundColor: ColorsManager.gray,

                  onPressed: () {
                    Get.offAllNamed(Routes.loginScreen);
                  })
            ],
          ),
        ),
      );
    }
  }

  void showNullValueDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 32,
        ),
        content: Text(
          'Please login to your account',
          style: TextStyles.font15DarkBlueMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.offAllNamed(Routes.loginScreen);
            },
            child: Text(
              'Login',
              style: TextStyles.font14BlueSemiBold,
            ),
          ),
        ],
      ),
    );
  }
}
