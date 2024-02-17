import 'dart:io';
import 'dart:ui';

import 'package:all_one/core/helper/extensions.dart';
import 'package:all_one/core/wedgits/app_localization.dart';
import 'package:all_one/core/helper/spacing.dart';
import 'package:all_one/core/theming/colors.dart';
import 'package:all_one/core/theming/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../../core/helper/chache_helper.dart';
import '../../../../../core/routing/routes.dart';
import 'package:http/http.dart' as http;

class ConnectMediaRegister extends StatefulWidget {
  const ConnectMediaRegister({super.key});

  @override
  State<ConnectMediaRegister> createState() => _ConnectMediaRegisterState();
}

class _ConnectMediaRegisterState extends State<ConnectMediaRegister> {
  Future signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return;
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print(credential.idToken);

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    CacheHelper.savedata(key: 'loginEmail', value: googleUser.email);
    CacheHelper.savedata(key: 'loginName', value: googleUser.displayName);
    CacheHelper.savedata(key: 'Image', value: googleUser.photoUrl);
    context.pushAndRemoveUntil(Routes.homeScreen, predicate: (route) => false);
    print(googleUser.email);
    print(googleUser.displayName);
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Map<String, dynamic>? _userData;

  _performLogin(BuildContext context) async {
    FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]).then((value) {
      FacebookAuth.instance.getUserData().then((result) {
        setState(() {
          _userData = result;
        });
        print(
            '//////////////////////////////////////////////////////////////////${result["picture"]["data"]["url"]}');
        print(
            '//////////////////////////////////////////////////////////////////${_userData!["name"]}');
        print(result);
        CacheHelper.savedata(key: 'loginEmail', value: _userData!["email"]);
        CacheHelper.savedata(key: 'loginName', value: _userData!["name"]);
        CacheHelper.savedata(
            key: 'Image', value: _userData!["picture"]["data"]["url"]);
        // Navigator.of(context).pushNamed(Routes.homeScreen,);
        context.pushAndRemoveUntil(Routes.homeScreen,
            predicate: (route) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(30.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 1.h,
              width: MediaQuery.sizeOf(context).width / 8,
              color: ColorsManager.lightGray,
            ),
            Text(
              "or_sign_in_with".tr,
              style: TextStyles.font14GrayRegular,
            ),
            Container(
              height: 1.h,
              width: MediaQuery.sizeOf(context).width / 8,
              color: ColorsManager.lightGray,
            ),
          ],
        ),
        verticalSpace(30.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: ColorsManager.moreLightGray,
              child: IconButton(
                  onPressed: () async {
                    await signInWithGoogle(context);
                  },
                  icon: SvgPicture.asset('asstes/svgs/icons8-google.svg')),
            ),
            CircleAvatar(
              radius: 24,
              backgroundColor: ColorsManager.moreLightGray,
              child: IconButton(
                  onPressed: () async {
                    await _performLogin(context);
                  },
                  icon: SvgPicture.asset('asstes/svgs/icons8-facebook.svg')),
            ),
            CircleAvatar(
              radius: 24,
              backgroundColor: ColorsManager.moreLightGray,
              child: IconButton(
                  onPressed: () async {
                    final credential =
                        await SignInWithApple.getAppleIDCredential(
                      scopes: [
                        AppleIDAuthorizationScopes.email,
                        AppleIDAuthorizationScopes.fullName,
                      ],
                      webAuthenticationOptions: WebAuthenticationOptions(
                        // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
                        clientId:
                            'de.lunaone.flutter.signinwithappleexample.service',

                        redirectUri:
                            // For web your redirect URI needs to be the host of the "current page",
                            // while for Android you will be using the API server that redirects back into your app via a deep link
                            kIsWeb
                                ? Uri.parse(
                                    'https://${window.platformDispatcher.locale}/')
                                : Uri.parse(
                                    'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
                                  ),
                      ),
                      // TODO: Remove these if you have no need for them
                      nonce: 'example-nonce',
                      state: 'example-state',
                    );
                    CacheHelper.savedata(
                        key: 'loginEmail',
                        value: AppleIDAuthorizationScopes.email);
                    CacheHelper.savedata(
                        key: 'loginName',
                        value: AppleIDAuthorizationScopes.fullName);
                    context.pushAndRemoveUntil(Routes.homeScreen,
                        predicate: (route) => false);

                    // ignore: avoid_print
                    print(credential);

                    // This is the endpoint that will convert an authorization code obtained
                    // via Sign in with Apple into a session in your system
                    final signInWithAppleEndpoint = Uri(
                      scheme: 'https',
                      host: 'flutter-sign-in-with-apple-example.glitch.me',
                      path: '/sign_in_with_apple',
                      queryParameters: <String, String>{
                        'code': credential.authorizationCode,
                        if (credential.givenName != null)
                          'firstName': credential.givenName!,
                        if (credential.familyName != null)
                          'lastName': credential.familyName!,
                        'useBundleId':
                            !kIsWeb && (Platform.isIOS || Platform.isMacOS)
                                ? 'true'
                                : 'false',
                        if (credential.state != null)
                          'state': credential.state!,
                      },
                    );

                    final session = await http.Client().post(
                      signInWithAppleEndpoint,
                    );

                    // If we got this far, a session based on the Apple ID credential has been created in your system,
                    // and you can now set this as the app's session
                    // ignore: avoid_print
                    print(session);
                  },
                  icon: SvgPicture.asset(
                      'asstes/svgs/apple-logo-svgrepo-com.svg')),
            ),
          ],
        ),
        verticalSpace(20.h),
      ],
    );
  }
}
