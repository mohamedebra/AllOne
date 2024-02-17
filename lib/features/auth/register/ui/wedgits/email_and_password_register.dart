import 'package:all_one/features/auth/register/logic/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/app_regex.dart';
import '../../../../../core/helper/spacing.dart';
import '../../../../../core/wedgits/app_text_form_field.dart';
import '../../../login/logic/login_cubit.dart';

class EmailAndPasswordRegister extends StatefulWidget {
  const EmailAndPasswordRegister({super.key});

  @override
  State<EmailAndPasswordRegister> createState() => _EmailAndPasswordRegisterState();
}

class _EmailAndPasswordRegisterState extends State<EmailAndPasswordRegister> {

  bool isObscureText = true;

  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  late TextEditingController passwordController;

  @override
  void initState() {
    passwordController = context.read<RegisterCubit>().passwordController;
    // setupPasswordControllerListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<RegisterCubit>().formKey,
      child: Column(
        children: [
          AppTextFormField(
            hintText: 'Name',
            validator: (value) {
              if (value == null || value.isEmpty ) {
                return "Please enter a valid Name";
              }
            },
            controller: context.read<RegisterCubit>().nameController,
          ),
          verticalSpace(18),
          AppTextFormField(
            hintText: 'Email',
            validator: (value) {
              if (value == null || value.isEmpty ) {
                return "Please enter a valid email";
              }
            },
            controller: context.read<RegisterCubit>().emailController,
          ),
          verticalSpace(18),
          AppTextFormField(
            controller: context.read<RegisterCubit>().passwordController,
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
    );
  }
  // @override
  // void dispose() {
  //   passwordController.dispose();
  //   super.dispose();
  // }
}
