import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/constants/app_colors.dart';
import 'package:lms_flutter/helpers/extensions/navigation_extension.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/features/Auth/widgets/button.dart';
import 'package:lms_flutter/view/features/Auth/widgets/drop_down_menu.dart';
import 'package:lms_flutter/view/features/Auth/widgets/text_field.dart';
import '../../../../../helpers/constants/app_sizes.dart';
import '../../../../../helpers/router/app_name_route.dart';
import '../../logic/cubit/auth_cubit.dart';
import '../../logic/cubit/auth_state.dart';
import '../../widgets/fields.dart';
import '../../widgets/states_handeling.dart';
import '../../widgets/validation_status.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  bool _isTapped = false;

  List<String> cities = [];

  bool check = false;

  TextEditingController phoneStudentNumber = TextEditingController();

  TextEditingController phoneParentNumber = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController conPassword = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController name = TextEditingController();


  TextEditingController city = TextEditingController();
  var cubit;
  void initState() {
    var cubit = AuthCubit.get(context);
    cubit.loadEgyCitysJson(context);
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.mainAppColor,
        body: SizedBox(
          width: AppSize.width(context),
          height: AppSize.height(context),
          child: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              SizedBox(
                height: 15.sp,
              ),
              SizedBox(
                  height: AppSize.height(context) * .17,
                  child: Image.asset(
                    "assets/images/app_icon.png",
                    height: AppSize.height(context) * .15,
                  )),
              Text(
                "Mark",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Container(
                height: AppSize.height(context) / 1.2,
                width: AppSize.width(context),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(50)),
                    color: Colors.white),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: BlocBuilder<AuthCubit, AuthStates>(
                        builder: (context, state) {
                      var cubit = AuthCubit.get(context);
                      return Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.sp,
                            ),
                            Text(
                              'sign_up'.tr(context),
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.bold),
                            ),
                            field(
                                label: 'students_name'.tr(context),
                                controller: name,
                                hinttext: 'students_name'.tr(context),
                                context: context,
                                isuser: true,
                                isemail: false,
                                ispassword: false),
                            field(
                                label: 'Email'.tr(context),
                                controller: email,
                                hinttext: 'Email'.tr(context),
                                context: context,
                                isuser: false,
                                isemail: true,
                                ispassword: false),
                            field(
                                label: 'student_number'.tr(context),
                                controller: phoneStudentNumber,
                                hinttext: '01234567890',
                                context: context,
                                isuser: false,
                                isemail: false,
                                ispassword: false),
                            field(
                                label: 'parent_number'.tr(context),
                                controller: phoneParentNumber,
                                hinttext: 'parent_number'.tr(context),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(children: [
                                    Text('re_password'.tr(context))
                                  ]),
                                ]),
                            CustomTextField(
                              controller: conPassword,
                              isPassword: true,
                              hintText: 're_password'.tr(context),
                              validator: (v) {
                                return ValidationState.confirmPassword(
                                  v!,
                                  password.text,
                                  conPassword.text,
                                  context,
                                );
                              },
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),


                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(children: [Text('city'.tr(context))]),
                                ]),
                            CustomDropDownBtn(
                              selectedOption: 'City',
                              listOptions: cubit.egyCitysList,
                              hint: 'chose_city'.tr(context),
                              isCity: true,
                              controller: city,
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            CustomButton(
                                _onSignUpPressed,
                                context,
                                Text(
                                  'sign_up'.tr(context),
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
                                    'already_have_an_account'.tr(context),
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        AppNameRoute.signInScreen
                                            .goAndReplaceAll(context);
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
                      );
                    }),
                  ),
                ),
              )
            ]),
          ),
        ));
  }

  String? City;
  List? egyCitysList;

  List egyCitysListE = [];
  Future<void> chooseCity() async {
    egyCitysList = AuthCubit.get(context).egyCitysList;

    egyCitysListE.clear();
    final String response =
        await rootBundle.loadString('assets/egycitys/citys.json');
    final data = json.decode(response);
    data.forEach((e) => egyCitysListE.add(e['governorate_name_en']));
    for (int i = 0; i < egyCitysListE.length; i++) {
      if (city.text == egyCitysList?[i]) {
        City = egyCitysListE[i];
      }
    }
  }

  callback() {
    CustomToast("signed_up_successfully".tr(context), Colors.green);

    AppNameRoute.signInScreen.goAndReplaceAll(context);
  }

  errorCallback() {
    Navigator.pop(context);
  }

  Future<void> _onSignUpPressed(BuildContext context) async {
    await chooseCity();
    if (City == null) CustomToast("اختر محافظتك", Colors.red);
    if (formKey.currentState!.validate() &&
        City != null
      ) {
      AuthCubit.get(context).signUp(
        context,
        callback,
        errorCallback,
        phoneStudentNumber.text,
        phoneParentNumber.text,
        name.text,
        password.text,
        password.text,
        City!,
        email.text,
      );
    }
  }
}
