import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/helpers/constants/app_colors.dart';
import 'package:lms_flutter/helpers/extensions/print_extention.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/features/subscriptions/logic/webservices/subscription_web_services.dart';

import '../../../../../helpers/extensions/api_error_handler.dart';
import '../../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import '../../../Auth/widgets/states_handeling.dart';

abstract class SubscriptionRepo {
  final SaveItCubit saveitCubit;

  SubscriptionRepo({
    required this.saveitCubit,
  });
  Future<dynamic> getSubscriptions({context, required String type});
  Future sendCode({
    context,
    required String code,
    required Function callback,
    required Function errorCallback,
  });
}

class SubscriptionRepoImp extends SubscriptionRepo {
  SubscriptionsWebServices subscriptionsWebServices;

  SubscriptionRepoImp({
    required this.subscriptionsWebServices,
    required super.saveitCubit,
  });

  @override
  Future<dynamic> getSubscriptions({context, required String type}) async {
    List<String> ids = [];
    List<String> exp = [];
    var cources;
    try {
      Response response = await subscriptionsWebServices.getSubscriptions(
          context: context, type: type);
      response.data.toString().dePrint;
      // if (response.data['message'] == null && response.data != null) {
      cources = response.data["data"]["data"];
      //  }
      if (cources.length != 0) {
         for (int i = 0; i < cources.length; i++) {
           dynamic expire_Date = cources[i]["expires_at"];
          // Duration duration = Duration(
          //     days: expire_Date["days"]!.toInt(),
          //     hours: expire_Date["hours"]!.toInt(),
          //     minutes: expire_Date["minutes"]!.toInt(),
          //     seconds: expire_Date["seconds"]!.toInt());
          //DateTime expiryDate = DateTime.now().add(expire_Date);
          print(expire_Date);
          exp.add(expire_Date.toString());

          ids.add(cources[i]["course_id"].toString());
        }
        SaveItCubit.get(context).saveList("subscribeCourse", ids);
        SaveItCubit.get(context).saveList("exp", exp);


      }
    } on DioException catch (e) {
      print("faild"); //('Deleted Account Id: $id').dePrint;

      ApiErrorHandler.getMessage(context, e);
    }
    return cources;
  }

  Future sendCode({
    context,
    required String code,
    required Function callback,
    required Function errorCallback,
  }) async {
    try {
      CustomToast("loading", AppColors.mainAppColor);
      Response response =
          await subscriptionsWebServices.sendCode(context: context, code: code);
      response.data.toString().dePrint;
      if (response.statusCode == 200) {
        CustomToast("purchased".tr(context), Colors.green);
        callback();
      }
    } on DioException catch (e) {

      errorCallback();
      if (e.response!.data["message"]
          .toString()
          .contains("Already subscribed to this course"))
        CustomToast("alrdysubscribe".tr(context), Colors.red);
      else {
        CustomToast("code_wrong".tr(context), Colors.red);
      }
    }
  }
}
