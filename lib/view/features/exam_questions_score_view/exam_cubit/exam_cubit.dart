import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import '../../../../helpers/utils/error_message_dialog.dart';
import 'models/exam_list_model.dart';
import '../network/exam_repo.dart';
import 'models/start_exam_model.dart';
import 'models/submit_exam_model.dart';
part 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  final ExamRepo examRepo;

  ExamCubit({required this.examRepo}) : super(ExamInitial());

  static ExamCubit get(context) => BlocProvider.of(context);
  List<ExamListModel> examList = [];
  List<StartExamModel> examData = [];
  SubmitExamModel submitExamDta = SubmitExamModel();

  //! Loading
  bool isLoadingAvailableExams = true;
  bool isLoadingStartExam = true;
  //!
  List<String> userAnswersList = [];

  //!Functions
  Map<String, dynamic> mainMap = {};

  getKey(String index) {
    return 'answers[$index]';
  }

  void getUserAnswers({
    required String index,
    required String id,
    required String examId,
  }) {
    Map<String, dynamic> mapAnswersId = {getKey(index): id};
    Map<String, dynamic> mapQuestionId = {'id': examId};
    mainMap.addEntries(mapQuestionId.entries);
    mainMap.addEntries(mapAnswersId.entries);
  }

  Future submitExam({
    required BuildContext context,
    required Function callback,
    required Function errorCallback,
    required String examId,
  }) async {
    submitExamDta = SubmitExamModel();
    var data = await examRepo.submitExam(
      context: context,
      answers: mainMap.isEmpty
          ? {
              'id': examId,
              'answers[0]': '',
            }
          : mainMap,
      callback: callback,
      errorCallback: errorCallback,
    );
    submitExamDta = data;
    emit(SubmitExamState());
  }

  getAvailableExams(BuildContext context, String courseId) async {
    isLoadingAvailableExams = true;
    examList.clear();
    emit(GetAvailableExamsState());
    var data = await examRepo.getAvailableExams(
      context: context,
      courseId: courseId,
    );
    isLoadingAvailableExams = false;
    examList = data;

    emit(GetAvailableExamsState());
  }

  getStartExam({
    required BuildContext context,
    required String examId,
    required Function callback,
    required Function errorCallback,
  }) async {
    examData.clear();
    isLoadingStartExam = true;
    emit(GetAvailableExamsState());
    var data = await examRepo.getStartExam(
      context: context,
      examId: examId,
      callback: callback,
      errorCallback: errorCallback,
    );
    isLoadingStartExam = false;
    examData = data;
    emit(GetAvailableExamsState());
  }

  void nextQuestionFunction({
    required BuildContext context,
    required Function callback,
    required Function errorCallback,
    required List<StartExamModel> theExamData,
  }) async {
    if (currentPressedIndex != -1 &&
        currentIndex < theExamData[0].questions!.length - 1) {
      var examId = theExamData[0].id.toString();
      var answerId = theExamData[0]
          .questions![currentIndex]
          .answers![currentPressedIndex]
          .id
          .toString();
      getUserAnswers(
        examId: examId,
        index: currentIndex.toString(),
        id: answerId,
      );
      currentIndex++;
    } else if (currentPressedIndex != -1 &&
        currentIndex >= theExamData[0].questions!.length - 1) {
      var examId = theExamData[0].id.toString();
      var answerId = theExamData[0]
          .questions![currentIndex]
          .answers![currentPressedIndex]
          .id
          .toString();
      getUserAnswers(
        examId: examId,
        index: currentIndex.toString(),
        id: answerId,
      );
      await submitExam(
        examId: examId,
        context: context,
        callback: callback,
        errorCallback: errorCallback,
      );
    } else if (currentPressedIndex == -1) {
      ErrorMessageDialog.show(
        context,
        'please_select_answer'.tr(context),
        isOkDialog: true,
      );
    }
    currentPressedIndex = -1;
    emit(NextQuestionState());
  }

  void resetData() {
    currentIndex = 0;
    currentPressedIndex = -1;
    mainMap.clear();
    emit(ResetDataState());
  }

  void previousQuestionFunction() {
    if (currentIndex > 0) {
      currentIndex--;
      currentPressedIndex = -1;
    }

    emit(PreviousQuestionState());
  }

  int currentPressedIndex = -1;
  int currentIndex = 0;

  void currentPressed(int index) {
    currentPressedIndex = index;
    emit(CurrentPressedState());
  }
}
