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
import 'package:lms_flutter/view/features/profile/logic/cubit/profile_cubit.dart';
import '../../../../../helpers/constants/app_sizes.dart';
import '../../../../../helpers/router/app_name_route.dart';
import '../../../../helpers/constants/app_images.dart';
import '../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import '../../Auth/logic/cubit/auth_cubit.dart';
import '../../Auth/logic/cubit/auth_state.dart';
import '../../Auth/widgets/fields.dart';
import '../../Auth/widgets/states_handeling.dart';

class EditView extends StatefulWidget {
  @override
  State<EditView> createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  @override
  bool ismale = true;

  List<String> cities = [];
  TextEditingController phoneStudentNumber = TextEditingController();

  TextEditingController phoneParentNumber = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController conPassword = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController name = TextEditingController();
  TextEditingController city = TextEditingController();
  var cubit;
  void initState() {
    cubit = AuthCubit.get(context);
    cubit.loadEgyCitysJson(context);
    name.text = SaveItCubit.get(context).getString("name")!;
    email.text = SaveItCubit.get(context).getString("email")!;
    password.text = SaveItCubit.get(context).getString("password")!;

    city.text = SaveItCubit.get(context).getString("city")!;
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              body: SizedBox(
                width: AppSize.width(context),
                height: AppSize.height(context),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(children: [
                            SizedBox(height: 20.sp),
                            Text(
                              'edit'.tr(context),
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        ismale = true;
                                      });
                                    },
                                    child: Center(
                                      child: Container(
                                          height: AppSize.height(context) / 8,
                                          width: AppSize.width(context) / 4,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            border: Border.all(
                                                width: 2,
                                                color: ismale == true
                                                    ? AppColors.mainAppColor
                                                    : Colors.black),
                                          ),
                                          child: Image.asset(
                                            AppImages.male,
                                            fit: BoxFit.contain,
                                          )),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        ismale = false;
                                      });
                                    },
                                    child: Center(
                                      child: Container(
                                          height: AppSize.height(context) / 8,
                                          width: AppSize.width(context) / 4,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            border: Border.all(
                                                width: 2,
                                                color: ismale == false
                                                    ? AppColors.mainAppColor
                                                    : Colors.black),
                                          ),
                                          child: Image.asset(
                                            AppImages.female,
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                  ),
                                ]),
                          ]),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15.sp,
                                ),
                                field(
                                    label: 'students_name'.tr(context),
                                    controller: name,
                                    hinttext: 'students_name',
                                    context: context,
                                    isuser: true,
                                    isemail: false,
                                    ispassword: false),
                                SizedBox(
                                  height: 15.sp,
                                ),
                                field(
                                    label: 'Email'.tr(context),
                                    controller: email,
                                    hinttext: 'Email',
                                    context: context,
                                    isuser: false,
                                    isemail: true,
                                    ispassword: false),
                                SizedBox(
                                  height: 15.sp,
                                ),
                                field(
                                    label: 'Password'.tr(context),
                                    controller: password,
                                    hinttext: 'Password',
                                    context: context,
                                    isuser: false,
                                    isemail: false,
                                    ispassword: true),
                                SizedBox(
                                  height: 15.sp,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                          children: [Text('city'.tr(context))]),
                                    ]),
                                CustomDropDownBtn(
                                  isFromEdit: true,
                                  selectedOption: 'City',
                                  listOptions: cubit.egyCitysList,
                                  hint: SaveItCubit.get(context)
                                      .getString("city")!,
                                  controller: city,
                                ),
                                SizedBox(
                                  height: 10.sp,
                                ),
                                CustomButton(
                                    _onSignUpPressed,
                                    context,
                                    state is AuthLoadingState
                                        ? CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            'edit'.tr(context),
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                            ),
                                            textAlign: TextAlign.center,
                                          )),
                                SizedBox(
                                  height: 15.sp,
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
              ));
        });
  }

  String? City;
  List? egyCitysList;

  List egyCitysListE = [];
  Future<void> func() async {
    egyCitysList = cubit.egyCitysList;

    egyCitysListE.clear();
    final String response =
        await rootBundle.loadString('assets/egycitys/citys.json');
    final data = json.decode(response);
    data.forEach((e) => egyCitysListE.add(e['governorate_name_en']));
    for (int i = 0; i < egyCitysListE.length; i++) {
      if (city.text == egyCitysList?[i] || city.text == egyCitysListE?[i]) {
        City = egyCitysListE[i];
      }
    }
  }

  callback() {
    CustomToast("edit_success".tr(context), Colors.green);
    if (password.text != SaveItCubit.get(context).getString("password"))
      AppNameRoute.signInScreen.goAndReplaceAll(context);
    else
      AppNameRoute.controllerScreen.goAndReplaceAll(context);
  }

  errorCallback() {
    Navigator.pop(context);
  }

  Future<void> _onSignUpPressed(BuildContext context) async {
    await func();
    if (formKey.currentState!.validate()) {
      if (password.text != SaveItCubit.get(context).getString("password")) {
        ProfileCubit.get(context).updatePassword(
            password: SaveItCubit.get(context).getString("password")!,
            newpassword: password.text,
            context: context,
            errorCallback: errorCallback,
            callback: callback);
      } else {
        ProfileCubit.get(context).updateUserInfo(
          name: name.text,
          password: password.text,
          email: email.text,
          city: City!,
          errorCallback: errorCallback,
          callback: callback,
          conpassword: password.text,
          context: context,
        );
      }
    }
    SaveItCubit.get(context).saveBool("male", ismale);
  }
}
