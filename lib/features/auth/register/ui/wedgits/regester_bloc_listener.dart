import 'package:all_one/core/wedgits/app_localization.dart';
import 'package:all_one/core/helper/extensions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../login/logic/login_cubit.dart';
import '../../../login/logic/login_state.dart';
import '../../logic/register_cubit.dart';
import '../../logic/register_state.dart';


class RegisterBlocListener extends StatelessWidget {
  const RegisterBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocListener<RegisterCubit,RegisterState>(
        listenWhen: (previous, current) =>
        current is RegisterLoading || current is RegisterSuccess || current is RegisterError,
        listener: (context,state){
          state.whenOrNull(
            loading: () {
              showDialog(
                context: context,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(
                    color: ColorsManager.mainMauve,
                  ),
                ),
              );
            },
            success: (loginResponse) {
              context.pop();
              context.pushNamed(Routes.homeScreen);
            },
            error: (error) {
              setupErrorState(context, error);
            },
          );
        },
        child: const SizedBox.shrink());
  }
  void setupErrorState(BuildContext context, String error) {
    context.pop();
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
          style: TextStyles.font16BlackSemiBold,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              "Got it",
              style: TextStyles.font14BlueSemiBold,
            ),
          ),
        ],
      ),
    );
  }
}
