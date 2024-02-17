import 'package:all_one/core/helper/spacing.dart';
import 'package:all_one/core/theming/styles.dart';
import 'package:all_one/core/wedgits/app_localization.dart';
import 'package:all_one/core/wedgits/app_text_button.dart';
import 'package:all_one/core/wedgits/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:  Text('Personal_Information'.tr),
        centerTitle: true,
        titleSpacing: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 20, left: 25, right: 25, bottom: 20),
            child: AppTextFormField(
              hintText: 'name'.tr,
              validator: (val) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
            child: AppTextFormField(hintText: 'Email'.tr, validator: (val) {}),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
            child:
                AppTextFormField(hintText: 'Password'.tr, validator: (val) {}),
          ),
          verticalSpace(120.h),
          AppTextButton(
              buttonWidth: MediaQuery.sizeOf(context).width /1.7,
              buttonText: 'Save'.tr,
              textStyle: TextStyles.font16WhiteSemiBold,
              onPressed: () {})
        ],
      ),
    );
  }
}
