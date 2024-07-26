import 'package:flutter/cupertino.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/features/Auth/widgets/text_field.dart';
import 'package:lms_flutter/view/features/Auth/widgets/validation_status.dart';

Widget field(
        {String? label,
        String? hinttext,
        TextEditingController? controller,
        context,
        bool? isuser,
        bool? isemail,
        bool? ispassword}) =>
    Column(
      children: [
        Row(
          children: [
            Column(children: [Text("$label")]),
          ],
        ),
        CustomTextField(
          controller: controller,
          hintText: hinttext!,
          isUser: isuser!,
          isEmail: isemail!,
          isPassword: ispassword!,
          validator: (v) {
            return label == 'student_number'.tr(context) ||
                    label == 'parent_number'.tr(context)
                ? ValidationState.validatePhoneNumber(v, context)
                : label == "Password".tr(context)
                    ? ValidationState.validatePassword(v, context)
                    : label == 'Email'.tr(context)
                        ? ValidationState.emailChecker(v, context)
                        : ValidationState.validateName(v!, context);
          },
        ),
      ],
    );
