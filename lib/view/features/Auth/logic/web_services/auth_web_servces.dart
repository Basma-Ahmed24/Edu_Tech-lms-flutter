import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_user_agentx/flutter_user_agent.dart';

import '../../../../../helpers/constants/app_endpoint.dart';
import '../../../../../helpers/constants/app_saved_key.dart';
import '../../../../../helpers/dio/dio_client.dart';
import '../../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';

abstract class AuthWebServices {
  DioClient dioClient;
  AuthWebServices({
    required this.dioClient,
  });
  Future<Response> signUp(
      {required String phone,
      required String parentPhone,
      required String name,
      required String password,
      required String conpassword,
      required String city,
      required String email,
      context});

  Future<Response> signIn(
      {String? phone, String? password, var deviceId, context});

  Future<Response> deleteAccount({context});
  Future<Response> FCMtoken({context});
}

class AuthWebServicesImp extends AuthWebServices {
  AuthWebServicesImp({required super.dioClient});

  @override
  Future<Response> signIn(
      {String? phone, String? password, var deviceId, context}) async {
    String userAgent = await FlutterUserAgent.getPropertyAsync('userAgent');
    print(userAgent);
    FormData data = FormData.fromMap({
      "phone": phone,
      "password": password,
      "deviceId": deviceId,
    });
    return dioClient.post(
      AppEndPoint.login,
      data: data,
      options: Options(
        method: "POST",
        contentType: 'application/json',
        headers: {
          'Accept': 'application/json',
          'User-Agent': userAgent.toLowerCase(),
        },
      ),
    );
  }

  @override
  @override
  Future<Response> signUp(
      {required String phone,
      required String parentPhone,
      required String name,

      required String password,
      required String conpassword,
      required String city,
      required String email,
      context}) async {
    return await dioClient.post(
      AppEndPoint.register,
      data: FormData.fromMap({
        "phone": phone,
        "parent_phone": parentPhone,
        "name": name,
        "email": email,
        "city": city,
        "password": password,
        "password_confirmation": conpassword
      }),
      options: Options(
        method: "POST",
      ),
    );
  }

  Future<Response> FCMtoken({context}) async {
    var fcmtoken = await FirebaseMessaging.instance.getToken();

    return await dioClient.post(
      "/users/addFCM",
      data: FormData.fromMap({"fcm_token": fcmtoken}),
      options: Options(method: "POST", headers: {
        "Authorization":
            "Bearer ${SaveItCubit.get(context).getString(AppSavedKey.token)}",
      }),
    );
  }

  Future<Response> deleteAccount({context}) async {

    return await dioClient.post(
      "/v1/logout",

      options: Options(method: "POST", headers: {
        "Authorization":
            "Bearer ${SaveItCubit.get(context).getString(AppSavedKey.token)}",
      }),
    );
  }
}
