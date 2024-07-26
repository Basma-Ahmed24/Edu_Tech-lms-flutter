import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';

import '../../helpers/constants/app_images.dart';
import 'custom_text.dart';

class EmptyWidget extends StatelessWidget {
  final String? text;

  const EmptyWidget({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        CustomText(
          text: text ?? 'no_courses_available'.tr(context),
        )
      ],
    );
  }
}
