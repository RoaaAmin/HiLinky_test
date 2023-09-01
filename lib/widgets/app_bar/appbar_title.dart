import 'package:flutter/material.dart';

import '../../core/utils/size_utils.dart';
import '../../theme/app_decoration.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';

// ignore: must_be_immutable
class AppbarTitle extends StatelessWidget {
  AppbarTitle({
    Key? key,
    required this.text,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String text;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Container(
          padding: getPadding(
            left: 10,
            top: 5,
            right: 10,
            bottom: 5,
          ),
          decoration: AppDecoration.outlineWhiteA700.copyWith(
            borderRadius: BorderRadiusStyle.circleBorder16,
          ),
          child: Text(
            text,
            style: CustomTextStyles.titleMediumMedium.copyWith(
              color: appTheme.teal300,
            ),
          ),
        ),
      ),
    );
  }
}
