import 'package:admob_flutter/admob_flutter.dart';
import 'package:all_one/core/helper/chache_helper.dart';
import 'package:all_one/core/routing/app_router.dart';
import 'package:all_one/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'core/DI/dependency_injection.dart';
import 'core/fanction/fanction.dart';
import 'core/services/services.dart';
import 'firebase_options.dart';

void main() async {
  // dart run build_runner build --delete-conflicting-outputs

  // fireBase init

  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();





  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

//  final GoogleMapsFlutterPlatform mapsImplementation =
//       GoogleMapsFlutterPlatform.instance;
//   if (mapsImplementation is GoogleMapsFlutterAndroid) {
//     // Force Hybrid Composition mode.
//     mapsImplementation.useAndroidViewSurface = true;
//   }
//
//   Completer<AndroidMapRenderer?>? _initializedRendererCompleter;
//   Future<AndroidMapRenderer?> initializeMapRenderer() async {
//     if (_initializedRendererCompleter != null) {
//       return _initializedRendererCompleter!.future;
//     }
//
//     final Completer<AndroidMapRenderer?> completer =
//     Completer<AndroidMapRenderer?>();
//     _initializedRendererCompleter = completer;
//
//     WidgetsFlutterBinding.ensureInitialized();
//
//     final GoogleMapsFlutterPlatform mapsImplementation =
//         GoogleMapsFlutterPlatform.instance;
//     if (mapsImplementation is GoogleMapsFlutterAndroid) {
//       unawaited(mapsImplementation
//           .initializeWithRenderer(AndroidMapRenderer.latest)
//           .then((AndroidMapRenderer initializedRenderer) =>
//           completer.complete(initializedRenderer)));
//     } else {
//       completer.complete(null);
//     }
//
//     return completer.future;
//   }
