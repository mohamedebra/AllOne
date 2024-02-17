import 'package:all_one/features/auth/register/data/models/register_request_body.dart';
import 'package:all_one/features/auth/register/data/repo/register_repo.dart';
import 'package:all_one/features/auth/register/logic/register_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/helper/chache_helper.dart';


class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepo registerRepo;

  RegisterCubit(this.registerRepo) : super(const RegisterState.initial());

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();


  void emitRegisterStates() async{
    emit(const RegisterState.loading());
    final response =await registerRepo.register(
        RegisterRequestBody(
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text,)
    );
    response.when(success: (loginResponse){
      CacheHelper.savedata(key: 'loginEmail', value: loginResponse.userData!.email);
      CacheHelper.savedata(key: 'loginName', value: loginResponse.userData!.name);
      emit(RegisterState.success(loginResponse));
    }, failure: (error){
      emit(RegisterState.error(error: error.apiErrorModel.message ?? ''));
    }
    );
  // try{
  //   emit(RegisterState.success(response.data));
  //
  // }catch(e){
  //   emit(RegisterState.error(error: response.error!.apiErrorModel.message ?? ''));
  //
  // }
  }
}
