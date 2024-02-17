import 'package:flutter/material.dart';

import '../theming/styles.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.errMessage});
  final String errMessage;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errMessage,
        style: TextStyles.font16BlackSemiBold,
        textAlign: TextAlign.center,
      ),
    );
  }
}
