import 'package:all_one/core/helper/chache_helper.dart';

class LocalizationController{
  // static changeLocal(BuildContext context){
  //   Locale? currentLocale = EasyLocalization.of(context)!.currentLocale;
  //   if(currentLocale == const Locale('en' , 'US')){
  //     EasyLocalization.of(context)!.setLocale(const Locale('ar', 'AE'));
  //   }
  //   else {
  //     EasyLocalization.of(context)!.setLocale(const Locale('en' , 'US'));
  //   }
  // }

  Future<void> cacheLangCode(String lang) async{
    // final sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.setString('Locale', lang);
    CacheHelper.savedata(key: 'Locale', value: lang);
  }

  Future<String> getCachedLangCode() async{
    // final sharedPreferences = await SharedPreferences.getInstance();
    final cachedLangCode =      CacheHelper.getData(key: 'Locale');
    if(cachedLangCode != null){
      return cachedLangCode;
    }else{
      return "en";
    }

  }
}