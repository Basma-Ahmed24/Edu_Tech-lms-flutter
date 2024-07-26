import 'package:dio/dio.dart';

import '../../../../../helpers/constants/app_endpoint.dart';
import '../../../../../helpers/constants/app_saved_key.dart';
import '../../../../../helpers/dio/dio_client.dart';
import '../../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';

abstract class SearchWebServices {
  DioClient dioClient;
  SaveItCubit saveitCubit;

  SearchWebServices({
    required this.dioClient,
    required this.saveitCubit
  });

  Future<Response>Search({context,required String name});

}
class SearchWebServicesImp extends SearchWebServices {
  SearchWebServicesImp({required super.dioClient, required super.saveitCubit});

  Future<Response> Search({context, required String name}) async {
    String? token = SaveItCubit.get(context).getString(AppSavedKey.token);

   return await DioClient().get(
      AppEndPoint.searchCourses,queryParameters: {"query":name
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
  }}
