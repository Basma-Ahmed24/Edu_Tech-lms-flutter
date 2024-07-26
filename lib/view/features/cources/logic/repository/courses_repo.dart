import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:lms_flutter/view/features/cources/logic/web_services/courses_web_services.dart';
import '../../../../../helpers/extensions/api_error_handler.dart';

abstract class CourseRepo {

  Future<dynamic> getLessons({required BuildContext context, required int id});
  Future<dynamic> getExams({required BuildContext context, required int id});
  Future<dynamic> getFiles({required BuildContext context, required int id});
}

class CourseRepoImp extends CourseRepo {
  CourseWebServices courseWebServices;

  CourseRepoImp({
    required this.courseWebServices,
  });

  @override

  @override
  Future<dynamic> getExams(
      {required BuildContext context, required int id}) async {
    var exams;
    try {
      Response response =
          await courseWebServices.getExams(context: context, id: id);


      exams = response.data["data"]["data"];
    } on DioException catch (e) {

      ApiErrorHandler.getMessage(context, e);
    }
    return exams;
  }

  @override
  Future<dynamic> getFiles(
      {required BuildContext context, required int id}) async {
    var files;
    try {
      Response response =
          await courseWebServices.getFiles(context: context, id: id);

      files = response.data["data"];

    } on DioException catch (e) {
if(e.response!.data["message"]=="No files found")
  files=[];
else
      ApiErrorHandler.getMessage(context, e);
    }
    return files;
  }

  @override
  Future<List> getLessons(
      {required BuildContext context, required int id}) async {
    var lessons, courseContent;
    try {
      Response response =
          await courseWebServices.getLessons(context: context, id: id);
      lessons = response.data["modules"];
      courseContent = response.data;
    } on DioException catch (e) {

      ApiErrorHandler.getMessage(context, e);
    }


    return [lessons, courseContent];
  }
}
