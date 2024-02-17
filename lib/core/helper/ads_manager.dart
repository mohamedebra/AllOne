
import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
//
class AdsManager{
  static bool _testAds = true;

  static String get appId{
    if(Platform.isAndroid){
      return 'ca-app-pub-9515552448239394~3105140484';
    }
    else if(Platform.isIOS){
      return '';
    }
    else{
      throw UnsupportedError('message');
    }
  }

  static String get bannerId{
    if(_testAds == true){
      return AdmobBanner.testAdUnitId;
    }
    else if(Platform.isAndroid){
      return 'ca-app-pub-9515552448239394/1034307072';
    }
    else if(Platform.isIOS){
      return '';
    }
    else{
      throw UnsupportedError('AdmobBanner.testAdUnitId');
    }
  }

  static String get interstitialId{
    if(_testAds == true){
      return AdmobInterstitial.testAdUnitId;
    }
    else if(Platform.isAndroid){
      return 'ca-app-pub-9515552448239394/9871473785';
    }
    else if(Platform.isIOS){
      return '';
    }
    else{
      throw UnsupportedError('AdmobInterstitial.testAdUnitId');
    }
  }

  static String get nativeId{

     if(Platform.isAndroid){
      return 'ca-app-pub-9515552448239394/1713782165';
    }
    else if(Platform.isIOS){
      return '';
    }
    else{
      throw UnsupportedError('AdmobInterstitial.testAdUnitId');
    }
  }

}

//        Container(
//           color: Colors.white,
//           height: 1,
//           padding: EdgeInsets.only(bottom: 20),
//           child: NativeAdmob(
//             adUnitID: AdsManager.nativeId,
//             options: NativeAdmobOptions(
//                 callToActionStyle: NativeTextStyle(
//                     fontSize: 18,
//                     color: Colors.black,
//                     backgroundColor: Colors.white)),
//             loading: Container(
//               color: Colors.red,
//               height: 20,
//             ),
//             error: Container(
//               child: Center(
//                 child: Text('Error'),
//               ),
//             ),
//             controller: _nativeApp,
//           ),
//         ),
//  final _nativeApp = NativeAdmobController();
//  AdmobInterstitial? admobInterstitial;
//   @override
//   void initState() {
//     admobInterstitial = AdmobInterstitial(
//         adUnitId: AdsManager.interstitialId,
//         listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
//           if (event == AdmobAdEvent.closed) {
//             admobInterstitial!.load();
//           }
//         });
//     admobInterstitial!.load();
//     _nativeApp.reloadAd(forceRefresh: true);
//
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     admobInterstitial!.dispose();
//     _nativeApp.dispose();
//     super.dispose();
//   }