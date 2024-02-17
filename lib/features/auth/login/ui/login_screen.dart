

import 'dart:convert';

import 'package:all_one/core/helper/extensions.dart';
import 'package:all_one/features/auth/login/ui/test.dart';
import 'package:all_one/features/auth/login/ui/wedgits/aready_have_account_text.dart';
import 'package:all_one/features/auth/login/ui/wedgits/connect_Media.dart';
import 'package:all_one/features/auth/login/ui/wedgits/email_and_password.dart';
import 'package:all_one/features/auth/login/ui/wedgits/login_bloc_listener.dart';
import 'package:all_one/features/auth/login/ui/wedgits/temrs_and_conditions_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/helper/app_regex.dart';
import '../../../../core/helper/spacing.dart';
import '../../../../core/networks/api_service.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/wedgits/app_text_button.dart';
import '../../../../core/wedgits/app_text_form_field.dart';
import '../data/models/login_request_body.dart';
import '../data/models/login_response.dart';
import '../data/repo/login_repo.dart';
import '../logic/login_cubit.dart';
import '../logic/login_state.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscureText = true;

  bool hasLowercase = false;

  bool hasUppercase = false;

  bool hasSpecialCharacters = false;

  bool hasNumber = false;

  bool hasMinLength = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(LoginRepo(ApiService(Dio()))),
      child: BlocConsumer<LoginCubit,LoginState>(
        listener: (context, state){
          if(state is LoginLoading){
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.mainMauve,
                ),
              ),
            );
          }
          else if(state is LoginSuccess){
            Navigator.pushNamedAndRemoveUntil(context, Routes.homeScreen, (route) => false);
          }
          else if(state is LoginError){
            setupErrorState(context, state.error);

          }
        },

        builder: (context,state){
          return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("welcome_back".tr,
                            style: GoogleFonts.cabin(
                                textStyle: TextStyles.font24BlueBold)),
                        verticalSpace(8.h),
                        Text(
                          "we're_excited_to_have_you_back_can't_wait_to_see_what_you've_been_up_to_since_you_last_logged_in"
                              .tr,
                          style: GoogleFonts.cabin (
                              textStyle: TextStyles.font14GrayRegular
                          ),
                        ),
                        verticalSpace(30.h),
                        Column(
                          children: [
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  AppTextFormField(
                                    hintText: 'Email',
                                    validator: (value) {
                                      if (value == null || value.isEmpty || !AppRegex.isEmailValid(value)) {
                                        return "Please enter a valid email";
                                      }
                                    },
                                    controller: emailController,
                                  ),
                                  verticalSpace(18),
                                  AppTextFormField(
                                    controller: passwordController,
                                    hintText: 'Password',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter a valid password";
                                      }
                                    },
                                    isObscureText: isObscureText,
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isObscureText = !isObscureText;
                                        });
                                      },
                                      child: Icon(
                                        isObscureText ? Icons.visibility_off : Icons.visibility,
                                      ),
                                    ),
                                  ),
                                  verticalSpace(24),
                                ],
                              ),
                            ),

                            verticalSpace(40),
                            AppTextButton(
                              buttonText: "Login",
                              textStyle: TextStyles.font16WhiteSemiBold,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  validateThenDoLogin(context);
                                }
                                },
                            ),
                            // verticalSpace(70.h),
                            const ConnectMedia(),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'By logging, you agree to our',
                                    style: TextStyles.font13GrayRegular,
                                  ),
                                  TextSpan(
                                    text: ' Terms & Conditions',
                                    style: TextStyles.font13DarkBlueMedium,
                                  ),
                                  TextSpan(
                                    text: ' and',
                                    style: TextStyles.font13GrayRegular.copyWith(height: 1.5),
                                  ),
                                  TextSpan(
                                    text: ' Privacy Policy',
                                    style: TextStyles.font13DarkBlueMedium,
                                  ),
                                ],
                              ),
                            ),
                            verticalSpace(60),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyles.font13DarkBlueRegular,
                                ),
                                InkWell(
                                  onTap: (){
                                    context.pushNamed(Routes.registerScreen);
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                                  },
                                  child: Text(
                                    ' Sign Up',
                                    style: TextStyles.font13BlueSemiBold,
                                  ),
                                ),
                              ],
                            ),

                            // const LoginBlocListener(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }

  void validateThenDoLogin(BuildContext context) {
    context.read<LoginCubit>().emitLoginStates(
      LoginRequestBody(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
  }
  void setupErrorState(BuildContext context, String error) {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 32,
        ),
        content: Text(
          error,
          style: TextStyles.font14DarkBlueMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Got it',
              style: TextStyles.font14DarkBlueMedium,
            ),
          ),
        ],
      ),
    );
  }

}
