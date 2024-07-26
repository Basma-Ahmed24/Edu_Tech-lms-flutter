import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/features/home_work_questions_score_view/homework_cubit/models/submit_homework_model.dart';
import '../../../../helpers/utils/error_message_dialog.dart';
import '../network/homework_repo.dart';
import 'models/get_homework_model.dart';
import 'models/homework_model.dart';
part 'homework_state.dart';

class HomeworkCubit extends Cubit<HomeworkState> {
  final HomeworkRepo homeworkRepo;
  HomeworkCubit({
    required this.homeworkRepo,
  }) : super(HomeworkInitial());

  static HomeworkCubit get(context) => BlocProvider.of(context);
  GetHomeworkModel getHomeworkModel = GetHomeworkModel();
  HomeworkModel homeWorkData = HomeworkModel();
  SubmitHomeworkModel submitHomeworkModel = SubmitHomeworkModel();

  //! Loading
  bool isLoadingHomeworkAvailable = true;
  bool isLoadingHomeworkStart = true;

  //!Functions
  Map<String, dynamic> mainMap = {};

  getKey(String index) {
    return 'answers[$index]';
  }

  void getUserAnswers({
    required String index,
    required String id,
    required String submissionId,
    required int homeworkId,

  }) {
    Map<String, dynamic> mapAnswersId = {getKey(index): id};
    Map<String, dynamic> mapQuestionId = {
      'submission_id': submissionId,

    };
    mainMap["homework_id"]=homeworkId;
    mainMap.addEntries(mapQuestionId.entries);
    mainMap.addEntries(mapAnswersId.entries);
  }

  Future submitHomework({
    required BuildContext context,
    required Function callback,
    required Function errorCallback,
    required String submissionId,
    required int homeworkId,
    Function? onWillPop,
    int isDraft = 0,
  }) async {
    submitHomeworkModel = SubmitHomeworkModel();
    if (mainMap.isNotEmpty) {
      Map<String, dynamic> mapDraft = {
        'isDraft': isDraft,
        'homework_id':homeworkId
      };
      mainMap.addEntries(mapDraft.entries);
      var data = await homeworkRepo.submitHomework(
        context: context,
        answers: mainMap,
        callback: callback,
        errorCallback: errorCallback,
      );
      submitHomeworkModel = data;
      onWillPop!();
      emit(SubmitExamState());
    }
  }

//! =======getHomeworkAvailable===========

  getHomeworkAvailable(BuildContext context, String lessonId) async {
    isLoadingHomeworkAvailable = true;
    getHomeworkModel = GetHomeworkModel();
    emit(GetAvailableExamsState());
    var data = await homeworkRepo.getHomeworkAvailable(
      context: context,
      lessonId: lessonId,
    );
    isLoadingHomeworkAvailable = false;
    getHomeworkModel = data;
    emit(GetAvailableExamsState());
  }

//! =======initTheUserPreviousAnswers===========
  List<String> drafList = [];
  var index = 0;
  bool isFinded = false;
  void initTheUserPreviousAnswers(HomeworkModel data) {
    if (data.data != null) {
      if (data.data!.drafts != null) {
        currentIndex = data
            .data!.drafts!.length; //! to got to the first non answered quistion
        mainMap.clear();
        index = -1;
        for (var id in data.data!.drafts!) {
          index++;
          var answers = data.data!.homeWork!.questions![index];
          for (var answer in answers.answers!) {
            if (answer.id.toString() == id.toString()) {
              getUserAnswers(
                index: index.toString(),
                id: answer.id.toString(),
                submissionId: data.data!.submissionId.toString(),
                homeworkId: data.data!.homeWork!.id!.toInt()
              );
              break;
            }
          }
        }
        Set<String> unique = data.data!.drafts!.toSet();
        drafList = unique.toList();
      }
    }
  }

//! =======getStartHomework===========

  getStartHomework({
    required BuildContext context,
    required String lessonId,
    required Function callback,
    required Function errorCallback,
  }) async {
    homeWorkData = HomeworkModel();
    isLoadingHomeworkStart = true;
    emit(GetAvailableExamsState());
    var data = await homeworkRepo.getStartHomework(
      context: context,
      lessonId: lessonId,
      callback: callback,
      errorCallback: errorCallback,
    );
    isLoadingHomeworkStart = false;
    homeWorkData = data;
    initTheUserPreviousAnswers(homeWorkData);
    emit(GetAvailableExamsState());
  }

//! =======nextQuestionFunction===========

  void nextQuestionFunction({
    required BuildContext context,
    required Function callback,
    required Function errorCallback,
    required HomeworkModel theHomeworkData,
  }) async {
    if (currentPressedIndex != -1 &&
        currentIndex < theHomeworkData.data!.homeWork!.questions!.length - 1) {
      var submissionId = theHomeworkData.data!.submissionId.toString();
      var homeworkId=theHomeworkData.data!.homeWork!.id!.toInt();
      var answerId = theHomeworkData.data!.homeWork!.questions![currentIndex]
          .answers![currentPressedIndex].id
          .toString();
      getUserAnswers(
        submissionId: submissionId,
        index: currentIndex.toString(),
        id: answerId,
        homeworkId: homeworkId
      );
      currentIndex++;
    } else if (currentPressedIndex != -1 &&
        currentIndex >= theHomeworkData.data!.homeWork!.questions!.length - 1) {
      var submissionId = theHomeworkData.data!.submissionId.toString();
      var answerId = theHomeworkData.data!.homeWork!.questions![currentIndex]
          .answers![currentPressedIndex].id
          .toString();
      var homeworkId=theHomeworkData.data!.homeWork!.id!.toInt();

      getUserAnswers(
        submissionId: submissionId,
        index: currentIndex.toString(),
        id: answerId,
        homeworkId: homeworkId

      );
      await submitHomework(
        submissionId: submissionId,
        homeworkId: homeworkId,
        context: context,
        callback: callback,
        errorCallback: errorCallback,
      ).then((value) => resetData());
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

  void currentPressed({required int index}) {
    currentPressedIndex = index;
    emit(CurrentPressedState());
  }
}
