import 'package:dio/dio.dart';
import 'package:lms_flutter/helpers/extensions/print_extention.dart';
import 'package:lms_flutter/view/features/search/logic/web_services/search_webservices.dart';
import '../../../../../helpers/extensions/api_error_handler.dart';
import '../../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';

abstract class SearchRepo {
  final SaveItCubit saveitCubit;

  SearchRepo({
    required this.saveitCubit,
  });
  Future<dynamic>Search({context,required String name});

}
class SearchRepoImp extends SearchRepo{
  SearchWebServices searchWebServices;

  SearchRepoImp({
    required this.searchWebServices,
    required super.saveitCubit,
  });

  @override
  Future<dynamic>Search({context,required String name})
  async{
    var searchResult;
    try{
      Response response =
      await searchWebServices.Search(context: context,name:name);

      // if (response.data['message'] == null && response.data != null) {
      searchResult=response.data["data"];
      //  }
    } on DioException catch (e) {


      ApiErrorHandler.getMessage(context, e);    }
    return searchResult;
  }}
