
import 'package:all_one/core/routing/app_router.dart';
import 'package:all_one/my_app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'core/fanction/fanction.dart';
import 'core/services/services.dart';

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
