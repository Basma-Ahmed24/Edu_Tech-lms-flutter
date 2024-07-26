import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:lms_flutter/view/features/statistics/models/user_status.dart';

import '../../../../helpers/extensions/api_error_handler.dart';
import 'my_statistics_web_services.dart';

abstract class MystatisticsRepo {
  Future<UserStatus> getUserStatus({
    required BuildContext context,
  });
}

class MystatisticsRepoImp extends MystatisticsRepo {
  MyStatisticsWebServices myStatisticsWebServices;

  MystatisticsRepoImp({
    required this.myStatisticsWebServices,
  });

  @override
  Future<UserStatus> getUserStatus({required BuildContext context}) async {
    UserStatus userStatus = UserStatus();
    try {
      Response response = await myStatisticsWebServices.getUserStatus();
      userStatus = UserStatus.fromJson(response.data);
    } on DioException catch (e) {
      ApiErrorHandler.getMessage(context, e);
    }
    return userStatus;
  }
}
