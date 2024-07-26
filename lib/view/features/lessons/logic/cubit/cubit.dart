import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_flutter/view/features/lessons/logic/cubit/state.dart';
import 'package:lms_flutter/view/features/lessons/logic/repository/lesson_repo.dart';

import '../../../../../helpers/dio/dio_client.dart';

class LessonCubit extends Cubit<LessonState> {
  LessonCubit({required this.lessonrepo}) : super(LessonInitialState());
  LessonRepo lessonrepo;
  dynamic lesson ;


  static LessonCubit get(context) => BlocProvider.of(context);

  void getLessonInfo({required BuildContext context, required int id,required String url}) async {
    emit(LessonLoadingState());

    lesson = await lessonrepo.getLessonInfo(context: context, id: id,url: url);

    emit(LessonLoadedState());
  }


}
