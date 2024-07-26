import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';

import '../../../../../helpers/constants/app_saved_key.dart';
import '../../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import '../../../../widgets/loading.dart';
import '../../widgets/states_handeling.dart';
import '../web_services/auth_web_servces.dart';

abstract class AuthRepo {
  final SaveItCubit saveitCubit;

  AuthRepo({
    required this.saveitCubit,
  });

  Future signUp({
    required BuildContext context,
    required Function callback,
    required Function errorCallback,
    required String phone,
    required String parentPhone,
    required String name,

    required String password,
    required String conpassword,
    required String city,
    required String email,
  });

  Future signIn(
      {required BuildContext context,
      required Function callback,
      required Function errorCallback,
      String? phone,
      String? password,
      var deviceId});

  Future deleteAccount({
    required BuildContext context,
    required Function callback,
    required Function errorCallback,
  });

  Future FCMtoken({
    required BuildContext context,
  });
}

class AuthRepoImp extends AuthRepo {
  AuthWebServices authWebServices;

  AuthRepoImp({
    required this.authWebServices,
    required super.saveitCubit,
  });
  var token;
  @override
  Future signIn(
      {required BuildContext context,
      required Function callback,
      required Function errorCallback,
      String? phone,
      String? password,
      var deviceId}) async {
    try {
      AppLoading.loading(context);
      Response response = await authWebServices.signIn(
          phone: phone, password: password, deviceId: deviceId);

      if (response.statusCode == 201 && response.data['data'] != null) {
        print(response.data);
        var user = response.data['data']['user'];
        var studentPhone = response.data['data']['user']['phone'];
        token = response.data['data']['user']['token'];
        var id = response.data['data']['user']['id'];

        await saveitCubit.saveString(AppSavedKey.token, token);
        await saveitCubit.saveString(AppSavedKey.studentPhone, studentPhone);
        await saveitCubit.saveString(AppSavedKey.userId, id.toString());
        await saveitCubit.subscribeToTopic();
        callback();
      }
    } on DioException catch (e) {
      errorCallback();
      if (e.response!.data["message"].toString().contains("Bad credentials."))
        CustomToast("siign_in_error1".tr(context), Colors.red);
      if (e.response!.data["message"]
          .toString()
          .contains("It's not allowed to sign-in with this device"))
        CustomToast("siign_in_error2".tr(context), Colors.red);
      else
        CustomToast("siign_in_error3".tr(context), Colors.red);


    }
  }

  @override
  @override
  Future signUp({
    required BuildContext context,
    required Function callback,
    required Function errorCallback,
    required String phone,
    required String parentPhone,
    required String name,
    required String password,
    required String conpassword,
    required String city,
    required String email,
  }) async {
    try {
      AppLoading.loading(context);
      Response response = await authWebServices.signUp(
          phone: phone,
          parentPhone: parentPhone,
          name: name,
          password: password,
          conpassword: conpassword,
          city: city,
          email: email,
         );

      if (response.statusCode == 201) {
        callback();
      }
    } on DioException catch (e) {

      errorCallback();
      if (e.response!.data["errors"]
          .toString()
          .contains("The phone has already been taken."))
        CustomToast("signup_error_1".tr(context), Colors.red);
      if (e.response!.data["errors"]
          .toString()
          .contains("The parent phone field and phone must be different."))
        CustomToast("signup_error_2".tr(context), Colors.red);

      if (e.response!.data["errors"]
          .toString()
          .contains("The email has already been taken."))
        CustomToast("signup_error_3".tr(context), Colors.red);
      else
        CustomToast("signup_error_4".tr(context), Colors.red);
    }

  }

  Future FCMtoken({required BuildContext context}) async {
    try {
      Response response = await authWebServices.FCMtoken(context: context);
    } on DioException catch (e) {
      CustomToast("FCM token did not token", Colors.red);
      // ('Deleted Account Id: $id').dePrint;
    }
  }

  Future deleteAccount({
    required BuildContext context,
    required Function callback,
    required Function errorCallback,
  }) async {
    try {
      AppLoading.loading(context);
      Response response = await authWebServices.deleteAccount(context: context);
      print(response.statusCode);
      if(response.statusCode==200) {
        await saveitCubit.saveString(AppSavedKey.token, '');
        await saveitCubit.unsubscribeFromTopic();
        await saveitCubit.sharedPreferences.clear();
      }
        callback();

    } on DioException catch (e) {
      CustomToast("Account did not deleted",
          Colors.red); //('Deleted Account Id: $id').dePrint;
      errorCallback();
    }
  }
}
