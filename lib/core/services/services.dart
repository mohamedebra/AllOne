
import 'package:all_one/core/networks/api_service.dart';
import 'package:all_one/features/home/data/test.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/home/data/repo/repo_types.dart';
import '../../firebase_options.dart';
import '../DI/dependency_injection.dart';
import '../fan/connect_internet.dart';
import '../fanction/fanction.dart';
import '../helper/chache_helper.dart';

class MyServices extends GetxService {
  

  Future<MyServices> init() async {

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Admob initialize
    // Admob.initialize();
    // SharedPreferences init
   await CacheHelper.init();

    await ScreenUtil.ensureScreenSize();

    FirebaseMessaging.instance.subscribeToTopic('users');
    TypesRepo(ApiService(Dio())).getTypes();

    // Notification init
    requestPermissionNotification();
    fanNotification();
    // GetIt init
    setupGetIt();
     await checkInternet();

    return this;
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
