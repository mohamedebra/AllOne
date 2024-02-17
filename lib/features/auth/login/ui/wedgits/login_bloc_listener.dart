// import 'package:all_one/core/helper/extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../../core/routing/routes.dart';
// import '../../../../../core/theming/colors.dart';
// import '../../logic/login_cubit.dart';
// import '../../logic/login_state.dart';
//
//
//
// class LoginBlocListener extends StatelessWidget {
//   const LoginBlocListener({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return  BlocListener<LoginCubit,LoginState>(
//         listenWhen: (previous, current) =>
//         current is Loading || current is Success || current is Error,
//         listener: (context,state){
//           state.whenOrNull(
//             loading: () {
//               showDialog(
//                 context: context,
//                 builder: (context) => const Center(
//                   child: CircularProgressIndicator(
//                     color: ColorsManager.mainMauve,
//                   ),
//                 ),
//               );
//             },
//             success: (loginResponse) {
//               context.pop();
//               context.pushNamed(Routes.homeScreen);
//             },
//             error: (error) {
//               setupErrorState(context, error);
//             },
//           );
//         },
//         child: const SizedBox.shrink()
//
//     );
//   }
//   void setupErrorState(BuildContext context, String error) {
//     context.pop();
//
//   }
// }
