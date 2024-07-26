import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../helpers/constants/app_endpoint.dart';
import '../../../../../helpers/constants/app_saved_key.dart';
import '../../../../../helpers/dio/dio_client.dart';
import '../../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';

abstract class ProfileWebServices {
  DioClient dioClient;
  SaveItCubit saveitCubit;

  ProfileWebServices({required this.dioClient, required this.saveitCubit});

  Future<Response> getProfileInfo({required BuildContext context});
  Future<Response> updateProfileInfo(
      {required String name,

      required String password,
      required String conpassword,
      required String city,
      required String email,
      required BuildContext context});

  Future<Response> updatePasswordInfo(
      {required String password,
      required String newpassword,
      required BuildContext context});
}

class ProfileWebServicesImp extends ProfileWebServices {
  ProfileWebServicesImp({required super.dioClient, required super.saveitCubit});

  Future<Response> getProfileInfo({required BuildContext context}) async {
    String? token = SaveItCubit.get(context).getString(AppSavedKey.token);

    return await dioClient.get(
      AppEndPoint.getCurrentUser,
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

  Future<Response> updateProfileInfo(
      {required String name,

      required String password,
      required String conpassword,
      required String city,
      required String email,
      required BuildContext context}) async {
    String? token = SaveItCubit.get(context).getString(AppSavedKey.token);

    return await dioClient.post(
      AppEndPoint.updateCurrentUser,
      data: FormData.fromMap({
        "name": name,
        "email": email,
        "city": city,
        "password": password,
        "password_confirmation": conpassword
      }),
      options: Options(
        method: "POST",
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );
  }

  Future<Response> updatePasswordInfo(
      {required String password,
      required String newpassword,
      required BuildContext context}) async {
    String? token = SaveItCubit.get(context).getString(AppSavedKey.token);

    return await dioClient.post(
      AppEndPoint.updatePassword,
      data:
          FormData.fromMap({"password": password, "new_password": newpassword}),
      options: Options(
        method: "POST",
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );
  }
}
