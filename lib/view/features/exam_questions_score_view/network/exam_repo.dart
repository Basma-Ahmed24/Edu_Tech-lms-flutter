import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:lms_flutter/view/features/exam_questions_score_view/exam_cubit/models/start_exam_model.dart';
import 'package:lms_flutter/view/features/exam_questions_score_view/exam_cubit/models/submit_exam_model.dart';
import '../../../../helpers/extensions/api_error_handler.dart';
import '../../../widgets/loading.dart';
import '../exam_cubit/models/exam_list_model.dart';
import 'exam_web_services.dart';

abstract class ExamRepo {
  Future<List<ExamListModel>> getAvailableExams({
    required BuildContext context,
    required String courseId,
  });

  Future<List<StartExamModel>> getStartExam({
    required BuildContext context,
    required String examId,
    required Function callback,
    required Function errorCallback,
  });

  Future<SubmitExamModel> submitExam({
    required BuildContext context,
    required Map<String, dynamic> answers,
    required Function callback,
    required Function errorCallback,
  });
}

class ExamRepoImp extends ExamRepo {
  ExamWebServices examWebServices;

  ExamRepoImp({
    required this.examWebServices,
  });

  @override
  Future<List<ExamListModel>> getAvailableExams({
    required BuildContext context,
    required String courseId,
  }) async {
    List<ExamListModel> examList = [];
    try {
      Response response =
          await examWebServices.getAvailableExams(courseId: courseId);
      response.data['data'][0]
          .forEach((e) => examList.add(ExamListModel.fromJson(e)));
    } on DioException catch (e) {
      ApiErrorHandler.getMessage(context, e);
    }
    return examList;
  }

  @override
  Future<List<StartExamModel>> getStartExam({
    required BuildContext context,
    required String examId,
    required Function callback,
    required Function errorCallback,
  }) async {
    List<StartExamModel> examData = [];
    try {
      Response response = await examWebServices.getStartExam(examId: examId);
     var data = response.data['data'];
      data.remove("course"); // Remove this line

     examData.add(StartExamModel.fromJson(data));
      callback();
    } on DioException catch (e) {
      errorCallback();
      ApiErrorHandler.getMessage(context, e, isQuickAlert: true);
    }
    return examData;
  }

  @override
  Future<SubmitExamModel> submitExam({
    required BuildContext context,
    required Map<String, dynamic> answers,
    required Function callback,
    required Function errorCallback,
  }) async {
    SubmitExamModel submitExamModel = SubmitExamModel();

    try {
      AppLoading.loading(context, changeLoading: true);
      Response response = await examWebServices.submitExam(answers: answers);
      submitExamModel = SubmitExamModel.fromJson(response.data['data']);

      callback();
    } on DioException catch (e) {
      errorCallback();
      ApiErrorHandler.getMessage(context, e);
    }
    return submitExamModel;
  }
}
