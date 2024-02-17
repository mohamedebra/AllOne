import 'package:all_one/core/helper/extensions.dart';
import 'package:all_one/core/routing/routes.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theming/styles.dart';


class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
          'Already have an account?',
            style: TextStyles.font13DarkBlueRegular,
          ),
          InkWell(
            onTap: (){
              context.pushNamed(Routes.loginScreen);
            },
            child: Text(
               ' Sign Up',
              style: TextStyles.font13BlueSemiBold,
            ),
          ),
        ],
      );

  }
}
