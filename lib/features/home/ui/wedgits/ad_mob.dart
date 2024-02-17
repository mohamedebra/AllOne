// import 'package:admob_flutter/admob_flutter.dart';
// import 'package:all_one/core/helper/ads_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:native_ads_flutter/native_ads.dart';
//
// class AdsMob extends StatefulWidget {
//   const AdsMob({super.key});
//
//   @override
//   State<AdsMob> createState() => _AdsMobState();
// }
//
// class _AdsMobState extends State<AdsMob> {
//   final _nativeApp = NativeAdmobController();
//   AdmobBanner? admobBanner;
//   // AdmobInterstitial? admobInterstitial;
//   // @override
//   // void initState() {
//   //   admobInterstitial = AdmobInterstitial(
//   //       adUnitId: AdsManager.interstitialId,
//   //     listener: (AdmobAdEvent event, Map<String,dynamic>? args){
//   //         if(event == AdmobAdEvent.closed){
//   //           admobInterstitial!.load();
//   //         }
//   //     }
//   //
//   //   );
//   //   admobInterstitial!.load();
//   //   _nativeApp.reloadAd(forceRefresh: true);
//   //
//   //   super.initState();
//   // }
//   //
//   //
//   // @override
//   // void dispose() {
//   //   admobInterstitial!.dispose();
//   //   _nativeApp.dispose();
//   //   super.dispose();
//   // }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.sizeOf(context).width /1.2;
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 10),
//           child: AdmobBanner(
//               adUnitId: AdsManager.bannerId,
//               adSize: AdmobBannerSize.ADAPTIVE_BANNER(width: width.toInt())),
//         )
//       ],
//     );
//   }
// }
