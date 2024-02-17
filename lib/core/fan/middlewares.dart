import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/chache_helper.dart';
import '../routing/routes.dart';


class Middlewares extends GetMiddleware{
   @override
  RouteSettings? redirect(String? route) {
    if (CacheHelper.getData(key: 'id') != null) {
      return const RouteSettings(name: Routes.homeScreen);
    }
    if (CacheHelper.getData(key: 'id') == null) {
      return const RouteSettings(name: Routes.loginScreen);
    }

    return null;
  }
}
