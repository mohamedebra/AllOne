import 'package:all_one/core/helper/chache_helper.dart';
import 'package:all_one/features/setting/data/setting_state.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../../../core/helper/lang_cache_helper.dart';


class LocaleCubit extends Cubit<ChangeLocaleState> {
  LocaleCubit() : super(ChangeLocaleState(locale: const Locale('en')));

  Future<void> getSavedLanguage() async {
    final String cachedLanguageCode =
    await LocalizationController().getCachedLangCode();

    emit(ChangeLocaleState(locale: Locale(cachedLanguageCode)));
  }

  Future<void> changeLanguage(String languageCode) async {
    await LocalizationController().cacheLangCode(languageCode);
    emit(ChangeLocaleState(locale: Locale(languageCode)));
  }

  void logout(){

    FirebaseMessaging.instance.unsubscribeFromTopic('users');
    CacheHelper.sharedPreferences!.clear();
  }

}