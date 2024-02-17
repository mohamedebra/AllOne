import 'package:all_one/core/wedgits/app_localization.dart';
import 'package:all_one/core/helper/extensions.dart';
import 'package:all_one/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theming/styles.dart';


class AlreadyHaveAccountTextRegester extends StatelessWidget {
  const AlreadyHaveAccountTextRegester({super.key});
//Already have an account?
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "already_have_an_account".tr,
            style: GoogleFonts.cabin(
              textStyle: TextStyles.font13DarkBlueRegular,
            )
          ),
          SizedBox(width: 7,),
          InkWell(
            onTap: (){
              context.pushNamed(Routes.loginScreen);
            },
            child: Text(
              "login".tr,
              style: GoogleFonts.cabin(
                textStyle: TextStyles.font13BlueSemiBold,
              )
            ),
          ),
        ],
      );

  }
}
