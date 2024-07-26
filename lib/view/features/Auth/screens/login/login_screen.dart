import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/constants/app_colors.dart';
import 'package:lms_flutter/helpers/extensions/navigation_extension.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/features/Auth/widgets/button.dart';
import 'package:lms_flutter/view/features/Auth/widgets/states_handeling.dart';
import '../../../../../helpers/constants/app_sizes.dart';
import '../../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import '../../../../../helpers/router/app_name_route.dart';
import '../../logic/cubit/auth_cubit.dart';
import '../../widgets/fields.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool check = false;
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainAppColor,
      body: SizedBox(
        width: AppSize.width(context),
        height: AppSize.height(context),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: AppSize.height(context) / 17,
                left: MediaQuery.of(context).size.width / 30,
              ),
              child: Image.asset(
                "assets/images/app_icon.png",
                height: AppSize.height(context) * .17,
              ),
            ),
            Text(
              "Mark",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.sp,
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                width: AppSize.width(context),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(60)),
                    color: Colors.white),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Center(
                    child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.sp,
                            ),
                            Text(
                              'sign_in'.tr(context),
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.bold),
                            ),
                            field(
                                label: 'student_number'.tr(context),
                                controller: phoneNumber,
                                hinttext: '01234567890',
                                context: context,
                                isuser: false,
                                isemail: false,
                                ispassword: false),
                            field(
                                label: 'Password'.tr(context),
                                controller: password,
                                hinttext: '*********',
                                context: context,
                                isuser: false,
                                isemail: false,
                                ispassword: true),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Checkbox(
                                    value: check,
                                    onChanged: (v) {
                                      setState(() {
                                        check =
                                            !check; // Toggle the check variable
                                      });
                                    },
                                    activeColor: AppColors.mainAppColor,
                                  ),
                                  Text('remember_me'.tr(context)),
                                ]),
                                InkWell(
                                    onTap: () {
                                      AppNameRoute.forgotPasswordScreen
                                          .go(context);
                                    },
                                    child: Text('forget_password'.tr(context))),
                              ],
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            CustomButton(
                              _onSignUpPressed,
                              context,
                              Text(
                                'sign_in'.tr(context),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 15.sp,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'do_not_have_an_account'.tr(context),
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                InkWell(
                                  onTap: () {
                                    AppNameRoute.signUpScreen
                                        .goAndReplaceAll(context);
                                  },
                                  child: Text(
                                    'sign_up'.tr(context),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.mainAppColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  callbacklogin() {
    Navigator.pop(context);
    CustomToast("login_success".tr(context), Colors.green);

    AppNameRoute.controllerScreen.goAndReplaceAll(context);
  }

  callbackfcmtoken() {
    print("done");
  }

  errorCallbackfcmtoken() {
    Navigator.pop(context);
  }

  errorCallbacklogin() {
    Navigator.pop(context);
  }

  void _onSignUpPressed(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      AuthCubit cubit = AuthCubit.get(context);
      await cubit.signIn(context, callbacklogin, errorCallbacklogin,
          phoneNumber.text, password.text);


      SaveItCubit.get(context).saveString("password", password.text);
    }
  }
}
