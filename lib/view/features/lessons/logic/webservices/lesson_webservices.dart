import 'package:dio/dio.dart';
import '../../../../../helpers/constants/app_saved_key.dart';
import '../../../../../helpers/dio/dio_client.dart';
import '../../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';

abstract class LessonWebServices {
  DioClient dioClient;
  SaveItCubit saveitCubit;

  LessonWebServices({required this.dioClient, required this.saveitCubit});

  Future<Response> getLessonInfo({context, required int id,required String url});

}

class LessonWebServicesImp extends LessonWebServices {
  LessonWebServicesImp({required super.dioClient, required super.saveitCubit});

  Future<Response> getLessonInfo({context, required int id,required String url}) async {
    String? token = SaveItCubit.get(context).getString(AppSavedKey.token);
    return await dioClient.post(
     url ,
      data:  FormData.fromMap({
        "lesson_id":id
      }),
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
