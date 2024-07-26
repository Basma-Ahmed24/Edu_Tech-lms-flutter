import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/helpers/extensions/print_extention.dart';
import 'package:lms_flutter/view/features/lessons/logic/webservices/lesson_webservices.dart';

import '../../../../../helpers/extensions/api_error_handler.dart';
import '../../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';

abstract class LessonRepo {
  final SaveItCubit saveitCubit;

  LessonRepo({
    required this.saveitCubit,
  });
  Future<dynamic> getLessonInfo(
      {required BuildContext context, required int id,required String url});


}

class LessonRepoImp extends LessonRepo {
  LessonWebServices lessonWebServices;

  LessonRepoImp({
    required this.lessonWebServices,
    required super.saveitCubit,
  });

  @override
  Future<dynamic> getLessonInfo(
      {required BuildContext context, required int id,required String url}) async {
    var lesson;
    try {
      Response response =
          await lessonWebServices.getLessonInfo(context: context, id: id,url: url);
      lesson = response.data["data"];
    } on DioException catch (e) {
      ApiErrorHandler.getMessage(context, e);
    }
    return lesson;
  }


}
