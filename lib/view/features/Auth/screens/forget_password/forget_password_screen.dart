import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/constants/app_colors.dart';
import 'package:lms_flutter/helpers/extensions/navigation_extension.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/features/Auth/widgets/button.dart';
import 'package:lms_flutter/view/features/Auth/widgets/text_field.dart';

import '../../../../../helpers/constants/app_sizes.dart';
import '../../../../../helpers/router/app_name_route.dart';
import '../../../../widgets/custom_text.dart';
import '../../widgets/validation_status.dart';

class ForgetPassword extends StatefulWidget {
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  bool check = false;
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.mainAppColor,
      body: SingleChildScrollView(
        child: SizedBox(
          width: AppSize.width(context),
          height: AppSize.height(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                "assets/images/app_icon.png",
                height: AppSize.height(context) * .15,
              ),
              Text(
                "Mark",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 18.sp,
              ),
              Container(
                height: AppSize.height(context) * .7,
                width: AppSize.width(context),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(60)),
                    color: Colors.white),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.sp,
                          ),
                          Text(
                            'forget_password'.tr(context),
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Please_enter_your_phone_number_to_change_the_password'
                                .tr(context),
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 18.sp,
                          ),
                          Row(children: [
                            CustomText(text: 'student_number'.tr(context)),
                          ]),
                          CustomTextField(
                            controller: phoneNumber,
                            hintText: '+88 01234567890',
                            validator: (v) {
                              return ValidationState.validatePhoneNumber(
                                  v, context);
                            },
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          CustomButton(
                              _onSignUpPressed,
                              context,
                              Text(
                                'sending_a_message'.tr(context),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                ),
                                textAlign: TextAlign.center,
                              )),
                          SizedBox(
                            height: 15.sp,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'back_to'.tr(context),
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                InkWell(
                                    onTap: () {
                                      AppNameRoute.signInScreen.go(context);
                                    },
                                    child: Text(
                                      'sign_in'.tr(context),
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.mainAppColor),
                                    )),
                              ]),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSignUpPressed(BuildContext context) {
    if (formKey.currentState!.validate()) {}
  }
}
