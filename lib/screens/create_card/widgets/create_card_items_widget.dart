import 'package:flutter/material.dart';

import '../../../core/utils/image_constant.dart';
import '../../../core/utils/size_utils.dart';
import '../../../widgets/custom_image_view.dart';

// ignore: must_be_immutable
class CreateCardItemWidget extends StatelessWidget {
  const CreateCardItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return CustomImageView(
      imagePath: ImageConstant.imgFacebook,
      height: getSize(50),
      width: getSize(50),
    );
  }
}
