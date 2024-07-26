import 'package:dio/dio.dart';
import 'package:lms_flutter/helpers/dio/dio_client.dart';

import '../../../../helpers/constants/app_endpoint.dart';
import '../../../../helpers/constants/app_saved_key.dart';
import '../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';

abstract class ExamWebServices {
  DioClient dioClient;
  SaveItCubit saveitCubit;

  ExamWebServices({
    required this.dioClient,
    required this.saveitCubit,
  });

  Future<Response> getAvailableExams({
    required String courseId,
  });

  Future<Response> getStartExam({
    required String examId,
  });

  Future<Response> submitExam({required Map<String, dynamic> answers});
}

class ExamWebServicesImp extends ExamWebServices {
  ExamWebServicesImp({
    required super.dioClient,
    required super.saveitCubit,
  });

  @override
  Future<Response> getAvailableExams({required String courseId}) async {
    String? token = saveitCubit.getString(AppSavedKey.token);
    return dioClient.get(
      AppEndPoint.getAvailableExams + courseId,
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
  Future<Response> getStartExam({required String examId}) async {
    String? token = saveitCubit.getString(AppSavedKey.token);

    var formData = FormData.fromMap({"id":examId});
    return dioClient.post(
      AppEndPoint.startExam,
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

  @override
  Future<Response> submitExam({required Map<String, dynamic> answers}) async {
    String? token = saveitCubit.getString(AppSavedKey.token);
    var formData = FormData.fromMap(answers);
    return dioClient.post(
      AppEndPoint.submitExam,
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
