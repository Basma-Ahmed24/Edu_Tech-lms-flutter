import 'package:dio/dio.dart';
import '../../../../helpers/constants/app_saved_key.dart';
import '../../../../helpers/dio/dio_client.dart';
import '../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';

abstract class ModuleWebServices {
  DioClient dioClient;

  ModuleWebServices({required this.dioClient});

   Future<Response> getModuleInfo({context, required int id});
   Future<Response> getHomeworkInfo({context, required int id});
  Future<Response> getFiles({context, required int id});
  Future<Response> getExamInfo({context, required int id});

}

class ModuleWebServicesImp extends ModuleWebServices {
  ModuleWebServicesImp({required super.dioClient});

  Future<Response> getModuleInfo({context, required int id}) async {
    String? token = SaveItCubit.get(context).getString(AppSavedKey.token);
    return await dioClient.get(
      "/module",
      queryParameters: {"id":id},
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

  Future<Response> getHomeworkInfo({context, required int id}) async {
    String? token = SaveItCubit.get(context).getString(AppSavedKey.token);

    return await dioClient.get(
      "/homeWork/getHomeWork",
      queryParameters: {
        "lesson_module_id": id,
      },
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
  Future<Response> getExamInfo({context, required int id}) async {
    String? token = SaveItCubit.get(context).getString(AppSavedKey.token);

    return await dioClient.get(
      "/exam/getExam",
      queryParameters: {
        "lesson_module_id": id,
      },
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
  Future<Response> getFiles({context, required int id}) async {
    String? token = SaveItCubit.get(context).getString(AppSavedKey.token);

    return await dioClient.post(
     "/v1/files",
      data: FormData.fromMap({
        "id": id,
        "type":"Module"
        })
        ,
      options: Options(
        method: "Post",
        contentType: 'application/json',
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );
  }
}