import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:lms_flutter/helpers/extensions/print_extention.dart';
import '../../../../../helpers/extensions/api_error_handler.dart';
import '../../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import '../webservices/home_webservices.dart';

abstract class HomeRepo {
  final SaveItCubit saveitCubit;

  HomeRepo({
    required this.saveitCubit,
  });
  Future<dynamic> getAllCourses(
      {required BuildContext context, required int page});
  Future<dynamic> getAllBars(
      {required BuildContext context});
}

class HomeRepoImp extends HomeRepo {
  HomeWebServices homeWebServices;

  HomeRepoImp({
    required this.homeWebServices,
    required super.saveitCubit,
  });

  @override
  Future<dynamic> getAllCourses(
      {required BuildContext context, required int page}) async {
    var allCourses;
    try {
      Response response =
          await homeWebServices.getAllCourses(context: context, page: page);
      response.data.toString().dePrint;

      allCourses = response.data["data"];
    } on DioException catch (e) {

      ApiErrorHandler.getMessage(context, e);
    }
    return allCourses;
  }
  Future<dynamic> getAllBars(
      {required BuildContext context})async{
    var allBars;
    try {
      Response response =
      await homeWebServices.getAllBanners(context: context);
      response.data.toString().dePrint;

      allBars = response.data["data"];
    } on DioException catch (e) {

      ApiErrorHandler.getMessage(context, e);
    }
    return allBars;
  }
}
