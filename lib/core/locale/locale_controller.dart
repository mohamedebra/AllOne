import 'package:all_one/core/helper/chache_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../fanction/fanction.dart';

class MyLocaleController extends GetxController{
  Locale initLang = CacheHelper.getData(key: 'lang') == null ?  Get.deviceLocale! :  Locale(CacheHelper.getData(key: 'lang'));

  void changeLocale(String codeLang){
    Locale locale = Locale(codeLang);
    CacheHelper.savedata(key: 'lang', value: codeLang);
    Get.updateLocale(locale);
  }



}