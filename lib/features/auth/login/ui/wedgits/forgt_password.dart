import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/spacing.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/wedgits/app_text_button.dart';
import '../../../../../core/wedgits/app_text_form_field.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Forgot Password',
                      style: TextStyles.font24BlueBold,
                    ),
                    verticalSpace(8.h),
                    Text(
                      '''At our app, we take the security of your information seriously.''',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,

                      style: TextStyles.font14GrayRegular,
                    ),
                    verticalSpace(30.h),
                    AppTextFormField(
                      hintText: 'Please Enter Your Email',
                      validator: (String? value) {  },),

                  ],
                ),
              ),
              AppTextButton(
                buttonText: "Reset Password",
                textStyle: TextStyles.font16WhiteSemiBold,
                onPressed: () {
                  // validateThenDoLogin(context);
                },
              ),

            ],
          ),
        ),

      ),
    );
  }
}
