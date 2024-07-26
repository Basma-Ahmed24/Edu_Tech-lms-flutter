import 'package:dio/dio.dart';

import '../../../../helpers/constants/app_endpoint.dart';
import '../../../../helpers/constants/app_saved_key.dart';
import '../../../../helpers/dio/dio_client.dart';
import '../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';

abstract class MyStatisticsWebServices {
  DioClient dioClient;
  SaveItCubit saveitCubit;

  MyStatisticsWebServices({
    required this.dioClient,
    required this.saveitCubit,
  });

  Future<Response> getUserStatus();
}

class MyStatisticsWebServicesImp extends MyStatisticsWebServices {
  MyStatisticsWebServicesImp({
    required super.dioClient,
    required super.saveitCubit,
  });

  @override
  Future<Response> getUserStatus() async {
    String? token = saveitCubit.getString(AppSavedKey.token);
    return dioClient.get(
      AppEndPoint.userStatus,
      options: Options(
        method: "GET",
        contentType: 'application/json',
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );
  }
}
