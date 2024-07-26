import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/features/module/network/webservices.dart';

import '../../../../helpers/extensions/api_error_handler.dart';
import '../../Auth/widgets/states_handeling.dart';

abstract class ModuleRepo {
  Future<dynamic> getModuleInfo(
      {required BuildContext context, required int id});
  Future<dynamic> getHomeworkInfo(
      {required BuildContext context, required int id});
  Future<dynamic> getExamInfo({required BuildContext context, required int id});
  Future<dynamic> getFiles({required BuildContext context, required int id});
}

class ModuleRepoImp extends ModuleRepo {
  ModuleWebServices moduleWebServices;

  ModuleRepoImp({
    required this.moduleWebServices,
  });

  @override
  Future<dynamic> getExamInfo(
      {required BuildContext context, required int id}) async {
    var exam;
    try {
      Response response =
          await moduleWebServices.getExamInfo(context: context, id: id);

      exam = response.data["data"];
    } on DioException catch (e) {
      ApiErrorHandler.getMessage(context, e);
    }
    return exam;
  }

  @override
  Future getFiles({required BuildContext context, required int id}) async {
    var files;

    try {
      Response response =
          await moduleWebServices.getFiles(context: context, id: id);
      files = response.data["data"];
    } on DioException catch (e) {
      if (e.response!.data["message"] == "No files found")
        files = null;
      else
        ApiErrorHandler.getMessage(context, e);
    }
    return files;
  }

  @override
  Future getHomeworkInfo(
      {required BuildContext context, required int id}) async {
    String homework = "no homework";
    dynamic homeworkinfo;
    try {
      DateTime currentDate = DateTime.now();
      Response response =
          await moduleWebServices.getHomeworkInfo(context: context, id: id);
      homeworkinfo = response.data["data"];
      if (response.data["data"].length != 0) {
        final date = DateTime.parse(response.data["data"]["ends_at"]);
        final diff = date.difference(currentDate).inSeconds;
        print(homeworkinfo);
        if (diff > 0) {
          homework = "available";
        } else {
          homework = "finished";
        }
      }
    } on DioException catch (e) {
      ApiErrorHandler.getMessage(context, e);
    }
    return [homework, homeworkinfo];
  }

  @override
  Future getModuleInfo({required BuildContext context, required int id}) async {
    var module;
    try {
      Response response =
          await moduleWebServices.getModuleInfo(context: context, id: id);
      module = response.data;
    } on DioException catch (e) {
      if (e.response!.data["message"] == "Module has an exam prerequisite.") {
        CustomToast("solve_exam_before".tr(context), Colors.red);
      } else if (e.response!.data["errors"] ==
          "Course has exam prerequisite.") {
        CustomToast("solve_exam_before_course".tr(context), Colors.red);
      } else {
        ApiErrorHandler.getMessage(context, e);
      }
    }
    return module;
  }
}
