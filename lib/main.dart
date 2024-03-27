
import 'package:all_one/core/routing/app_router.dart';
import 'package:all_one/my_app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/fanction/fanction.dart';
import 'core/services/services.dart';
import 'features/home/data/model/product_offer.dart';

void main() async {
  // dart run build_runner build --delete-conflicting-outputs

  // fireBase init

  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();

  runApp(
    // DevicePreview(
    //   enabled: true,
    //   builder: (context) =>  ;

        MyApp(
        appRouter: AppRouter(),
  ) );
}

