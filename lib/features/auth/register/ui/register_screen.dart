import 'package:all_one/core/theming/styles.dart';
import 'package:all_one/features/auth/register/ui/wedgits/aready_have_account_text_register.dart';
import 'package:all_one/features/auth/register/ui/wedgits/connect_Media_register.dart';
import 'package:all_one/features/auth/register/ui/wedgits/email_and_password_register.dart';
import 'package:all_one/features/auth/register/ui/wedgits/regester_bloc_listener.dart';
import 'package:all_one/features/auth/register/ui/wedgits/temrs_and_conditions_text_regester.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/wedgits/app_text_button.dart';
import '../../login/data/models/login_request_body.dart';
import '../../login/logic/login_cubit.dart';
import '../data/models/register_request_body.dart';
import '../logic/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create Account',
                    style: TextStyles.font24BlueBold,
                  ),
                  verticalSpace(8.h),
                  Text(
                    '''Sign up now and start exploring all that our \napp has to offer. We're excited to welcome \nyou to our community!''',
                    style: TextStyles.font14GrayRegular,
                  ),
                  verticalSpace(30.h),
                  Column(
                    children: [
                      const EmailAndPasswordRegister(),
                      verticalSpace(40),
                      AppTextButton(
                        buttonText: "Create Account",
                        textStyle: TextStyles.font16WhiteSemiBold,
                        onPressed: () {
                          validateThenDoLogin(context);
                        },
                      ),
                      // verticalSpace(70),
                      const ConnectMediaRegister(),
                      const TermsAndConditionsTextRegister(),
                      verticalSpace(50.h),
                      const AlreadyHaveAccountTextRegester(),
                      const RegisterBlocListener(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void validateThenDoLogin(BuildContext context) {
    if (context.read<RegisterCubit>().formKey.currentState!.validate()) {
      context.read<RegisterCubit>().emitRegisterStates();
    }  }
}
