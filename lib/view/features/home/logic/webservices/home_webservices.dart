import 'package:dio/dio.dart';
import '../../../../../helpers/constants/app_saved_key.dart';
import '../../../../../helpers/dio/dio_client.dart';
import '../../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';

abstract class HomeWebServices {
  DioClient dioClient;
  SaveItCubit saveitCubit;

  HomeWebServices({required this.dioClient, required this.saveitCubit});

  Future<Response> getAllCourses({context, required int page});
  Future<Response> getAllBanners({context});
}

class HomeWebServicesImp extends HomeWebServices {
  HomeWebServicesImp({required super.dioClient, required super.saveitCubit});

  Future<Response> getAllCourses({context, required int page}) async {
    String? token = SaveItCubit.get(context).getString(AppSavedKey.token);

    return await dioClient.get(
      "/v1/course/all",
      queryParameters: {"page": page},

    );
  }
  Future<Response> getAllBanners({context})async{
    String? token = SaveItCubit.get(context).getString(AppSavedKey.token);

    return await dioClient.get(
      "/bar/getAll",

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
