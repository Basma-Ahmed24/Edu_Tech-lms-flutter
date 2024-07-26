import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/helpers/utils/snack_bar_messege.dart';
import '../../../../helpers/extensions/api_error_handler.dart';
import '../../../widgets/loading.dart';
import '../homework_cubit/models/get_homework_model.dart';
import '../homework_cubit/models/homework_model.dart';
import '../homework_cubit/models/submit_homework_model.dart';
import 'homework_webservices.dart';

abstract class HomeworkRepo {
  Future<GetHomeworkModel> getHomeworkAvailable({
    required BuildContext context,
    required String lessonId,
  });

  Future<HomeworkModel> getStartHomework({
    required BuildContext context,
    required String lessonId,
    required Function callback,
    required Function errorCallback,
  });

  Future<SubmitHomeworkModel> submitHomework({
    required BuildContext context,
    required Map<String, dynamic> answers,
    required Function callback,
    required Function errorCallback,
  });
}

class HomeworkRepoImp extends HomeworkRepo {
  HomeworkWebServices homeworkWebServices;

  HomeworkRepoImp({
    required this.homeworkWebServices,
  });

  @override
  Future<GetHomeworkModel> getHomeworkAvailable({
    required BuildContext context,
    required String lessonId,
  }) async {
    GetHomeworkModel getHomeworkModel = GetHomeworkModel();
    try {
      Response response =
          await homeworkWebServices.getHomeworkAvailable(lessonId: lessonId);

      getHomeworkModel = GetHomeworkModel.fromJson(response.data);
    } on DioException catch (e) {
      ApiErrorHandler.getMessage(context, e);
    }
    return getHomeworkModel;
  }

  @override
  Future<HomeworkModel> getStartHomework({
    required BuildContext context,
    required String lessonId,
    required Function callback,
    required Function errorCallback,
  }) async {
    HomeworkModel homeworks = HomeworkModel();
    try {
      Response response =
          await homeworkWebServices.getStartHomework(lessonId: lessonId);
      homeworks = HomeworkModel.fromJson(response.data);
      callback();
    } on DioException catch (e) {
      errorCallback();
      ApiErrorHandler.getMessage(context, e);
    }
    return homeworks;
  }

  @override
  Future<SubmitHomeworkModel> submitHomework({
    required BuildContext context,
    required Map<String, dynamic> answers,
    required Function callback,
    required Function errorCallback,
  }) async {
    SubmitHomeworkModel submitHomeworkModel = SubmitHomeworkModel();

    try {
      AppLoading.loading(context, changeLoading: true);
      await homeworkWebServices.submitHomework(answers: answers).then((value) {
        if (value.data['data'] == null && value.data['success'] == true) {
          Navigator.pop(context);
          SnackBarMessage.get(context, value.data['message'], isSuccess: true);
        } else {
          submitHomeworkModel = SubmitHomeworkModel.fromJson(value.data);
          callback();
        }
      });
    } on DioException catch (e) {
      errorCallback();
      ApiErrorHandler.getMessage(context, e);
    }
    return submitHomeworkModel;
  }
}
