
import 'package:all_one/features/auth/login/data/repo/login_repo.dart';
import 'package:all_one/features/auth/login/logic/login_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/chache_helper.dart';
import '../data/models/login_request_body.dart';


class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;
  LoginCubit(this.loginRepo) : super(LoginInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();


  // void emitLoginStates(LoginRequestBody loginRequestBody) async{
  //    emit(const LoginState.loading());
  //    final response =await loginRepo.login(loginRequestBody);
  //    try{
  //      if(response.data != null){
  //        emit(LoginState.success(response.data));
  //      }
  //    }catch(e){
  //      emit(LoginState.error(error: response.error?.apiErrorModel.message ?? ''));
  //    }
  //
  // }
  void emitLoginStates(LoginRequestBody loginRequestBody) async{
    emit(LoginLoading());
    final response =await loginRepo.login(loginRequestBody);
    response.when(success: (loginResponse){
      CacheHelper.savedata(key: 'loginEmail', value: loginResponse.userData!.email);
      CacheHelper.savedata(key: 'loginName', value: loginResponse.userData!.name);
      FirebaseMessaging.instance.subscribeToTopic('Users');
      emit(LoginSuccess(loginResponse));
    }, failure: (error){
      emit(LoginError(error.apiErrorModel.message ?? ''));
    }
    );}

}
//     response.when(success: (loginResponse){
//
//      }, failure: (error){
//        emit(LoginState.error(error: error.apiErrorModel.message ?? ''));
//      }
//   );