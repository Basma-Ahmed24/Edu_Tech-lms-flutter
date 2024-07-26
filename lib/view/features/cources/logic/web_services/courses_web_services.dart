import 'package:dio/dio.dart';
import 'package:lms_flutter/helpers/constants/app_saved_key.dart';
import 'package:lms_flutter/helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';

import '../../../../../helpers/dio/dio_client.dart';

abstract class CourseWebServices {
  DioClient dioClient;

  CourseWebServices({
    required this.dioClient,
  });

  Future<Response> getLessons({context, required int id});

  Future<Response> getExams({context, required int id});
  Future<Response> getFiles({context, required int id});
}

class CourseWebServiceImp extends CourseWebServices {
  CourseWebServiceImp({required super.dioClient});

  Future<Response> getLessons({context, required int id}) async {
    String? token = SaveItCubit.get(context).getString(AppSavedKey.token);
    return dioClient.get(
      "/v1/course/$id",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );
  }

  Future<Response> getExams({context, required int id}) async {
    String? token = SaveItCubit.get(context).getString(AppSavedKey.token);

    return dioClient.get(
      "/v1/exam/getCourseExamsStudent",
      queryParameters: {"course_id": id},
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

    return dioClient.post(
      "/v1/files",
      data: FormData.fromMap({"id": id,
      "type":"Course"}),
      options: Options(
        method: "Post",
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }
}
