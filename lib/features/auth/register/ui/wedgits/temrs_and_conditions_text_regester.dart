import 'package:all_one/core/wedgits/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/theming/styles.dart';


class TermsAndConditionsTextRegister extends StatelessWidget {
  const TermsAndConditionsTextRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "by_logging_you_agree_to_our".tr,
            style: GoogleFonts.cabin(
              textStyle: TextStyles.font13GrayRegular,
            )
          ),
          TextSpan(
            text: "terms_Conditions".tr,
            style: GoogleFonts.cabin(
              textStyle: TextStyles.font13DarkBlueMedium,
            )
          ),
          TextSpan(
            text: 'and'.tr,
    style: GoogleFonts.cabin(
    textStyle: TextStyles.font13GrayRegular.copyWith(height: 1.5),
    )
          ),
          TextSpan(
            text: "privacy_policy".tr,
            style: GoogleFonts.cabin(
              textStyle: TextStyles.font13DarkBlueMedium,
            )
          ),
        ],
      ),
    );
  }
}
