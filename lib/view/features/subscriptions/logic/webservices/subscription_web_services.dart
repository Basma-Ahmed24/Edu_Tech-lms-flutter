import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../helpers/constants/app_endpoint.dart';
import '../../../../../helpers/constants/app_saved_key.dart';
import '../../../../../helpers/dio/dio_client.dart';
import '../../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';

abstract class SubscriptionsWebServices {
  DioClient dioClient;
  SaveItCubit saveitCubit;

  SubscriptionsWebServices({
    required this.dioClient,
    required this.saveitCubit
  });

  Future<Response>getSubscriptions({context,required String type});
  Future<Response> sendCode({required BuildContext context,required String code});

}
class SubscriptionsWebServicesImp extends SubscriptionsWebServices {
  SubscriptionsWebServicesImp({required super.dioClient, required super.saveitCubit});

  Future<Response> getSubscriptions({context, required String type}) async {
    String? token = SaveItCubit.get(context).getString(AppSavedKey.token);

    return await dioClient.get(
      AppEndPoint.getUserSubscriptions,
      queryParameters: {"type": type},
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
  Future<Response> sendCode({required BuildContext context,required String code})async{

    String? token = SaveItCubit.get(context).getString(AppSavedKey.token);

   return await dioClient.post(
      "/v1/subscription/useCode",
      data: FormData.fromMap({
        "code":code
      }),
      options: Options(
        method: "POST",

        headers: {
          "Authorization": "Bearer $token",

        },
      ),
    );
  }
}
