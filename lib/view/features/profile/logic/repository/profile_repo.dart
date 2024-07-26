import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/helpers/extensions/print_extention.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/features/profile/logic/webservices/profile_webservices.dart';

import '../../../../../helpers/extensions/api_error_handler.dart';
import '../../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import '../../../../widgets/loading.dart';
import '../../../Auth/widgets/states_handeling.dart';

abstract class ProfileRepo {
  final SaveItCubit saveitCubit;

  ProfileRepo({
    required this.saveitCubit,
  });
  Future<dynamic> getProfileInfo({context});
  Future<dynamic> updateInfo(
      {required String name,
      required String password,
      required String conpassword,
      required String city,
      required String email,
      required Function callback,
      required Function errorCallback,
      required BuildContext context});

  Future<dynamic> updatePassword(
      {required String password,
      required String newpassword,
      required Function callback,
      required Function errorCallback,
      required BuildContext context});
}

class ProfileRepoImp extends ProfileRepo {
  ProfileWebServices profileWebServices;

  ProfileRepoImp({
    required this.profileWebServices,
    required super.saveitCubit,
  });

  @override
  Future<dynamic> getProfileInfo({context}) async {
    var user;

    try {
      Response response =
          await profileWebServices.getProfileInfo(context: context);
      response.data.toString().dePrint;
      // if (response.data['message'] == null && response.data != null) {
      if (response.statusCode == 200) {
        user = response.data["data"];
        //SaveItCubit.get(context).saveString("phone", user["phone"]);
        SaveItCubit.get(context).saveString("email", user["email"]);
        SaveItCubit.get(context).saveString("name", user["name"]);
        print(user["name"]);
        SaveItCubit.get(context).saveString("city", user["city"]);
        SaveItCubit.get(context).saveInt("id", user["id"]);

        //  }
      }
    } on DioException catch (e) {
      ApiErrorHandler.getMessage(context, e);
    }
    return user;
  }

  @override
  Future updateInfo(
      {required String name,
      required String password,
      required String conpassword,
      required String city,
      required String email,
      required Function callback,
      required Function errorCallback,
      required BuildContext context}) async {
    try {
      AppLoading.loading(context);
      Response response = await profileWebServices.updateProfileInfo(
          name: name,
          password: password,
          conpassword: conpassword,
          city: city,
          context: context,
          email: email,
         );
      print(response.statusCode);
      if (response.statusCode == 200) {
        callback();
      }
    } on DioException catch (e) {
      errorCallback();
      CustomToast("edit_failed".tr(context), Colors.red);
    }
  }

  @override
  Future updatePassword(
      {required String password,
      required String newpassword,
      required Function callback,
      required Function errorCallback,
      required BuildContext context}) async {
    try {
      AppLoading.loading(context);
      Response response = await profileWebServices.updatePasswordInfo(
          password: password, newpassword: newpassword, context: context);
      if (response.statusCode == 200) {
        callback();
      }
    } on DioException catch (e) {
      errorCallback();
      CustomToast("edit_failed".tr(context), Colors.red);
    }
  }
}
