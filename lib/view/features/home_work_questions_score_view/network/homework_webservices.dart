import 'package:dio/dio.dart';
import 'package:lms_flutter/helpers/dio/dio_client.dart';
import '../../../../helpers/constants/app_endpoint.dart';
import '../../../../helpers/constants/app_saved_key.dart';
import '../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';

abstract class HomeworkWebServices {
  DioClient dioClient;
  SaveItCubit saveitCubit;

  HomeworkWebServices({
    required this.dioClient,
    required this.saveitCubit,
  });

  Future<Response> getHomeworkAvailable({
    required String lessonId,
  });

  Future<Response> getStartHomework({
    required String lessonId,
  });

  Future<Response> submitHomework({required Map<String, dynamic> answers});
}

class HomeworkWebServicesImp extends HomeworkWebServices {
  HomeworkWebServicesImp({
    required super.dioClient,
    required super.saveitCubit,
  });

  @override
  Future<Response> getHomeworkAvailable({required String lessonId}) async {
    String? token = saveitCubit.getString(AppSavedKey.token);
    return dioClient.get(
      AppEndPoint.getHomeworkAvailable + lessonId,
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

  @override
  Future<Response> getStartHomework({required String lessonId}) async {
    String? token = saveitCubit.getString(AppSavedKey.token);
    return dioClient.get(
      AppEndPoint.startHomework,
      queryParameters: {"homework_id":lessonId},
      options: Options(
        method: "POST",
        contentType: 'application/json',
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );
  }

  @override
  Future<Response> submitHomework({
    required Map<String, dynamic> answers,
  }) async {
    String? token = saveitCubit.getString(AppSavedKey.token);
    var formData = FormData.fromMap(answers);
    return dioClient.post(
      AppEndPoint.submitHomework,
      data: formData,
      options: Options(
        method: "POST",
        contentType: 'application/json',
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );
  }
}
