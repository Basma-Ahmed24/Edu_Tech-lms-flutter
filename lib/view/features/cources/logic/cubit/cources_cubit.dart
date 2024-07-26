import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_flutter/view/features/cources/logic/repository/courses_repo.dart';

import '../../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import 'cources_state.dart';

class CourcesCubit extends Cubit<CourcesState> {
  CourcesCubit({required this.coursesRepo}) : super(CourcesInitialState());
  final CourseRepo coursesRepo;
  var content = [];
  var lessons = [];
  var courseDetails;
  var exams = [];
  var files;

  static CourcesCubit get(context) => BlocProvider.of(context);

  Future getlessons({required BuildContext context, required int id}) async {
    emit(CourcesLoadingState());

    content = await coursesRepo.getLessons(context: context, id: id);
    lessons = content[0];
    courseDetails = content[1];
    emit(CourcesLoadedState());
  }

  Future<void> getExams(
      {required BuildContext context, required int id}) async {
    emit(CourcesLoadingState());

    exams = await coursesRepo.getExams(context: context, id: id);

    emit(CourcesLoadedState());
  }

  Future<void> getFiles(
      {required BuildContext context, required int id}) async {
    emit(CourcesLoadingState());

    files = await coursesRepo.getFiles(context: context, id: id);
    emit(CourcesLoadedState());
  }

  bool isPurched = false;

  Future<dynamic> checkCourse(
    BuildContext context,
    int? id,
    subscribeList,
  ) async {
    await getlessons(context: context, id: id!);

    List<dynamic> intList = subscribeList.map((str) => int.parse(str)).toList();
    List<dynamic> DateList = SaveItCubit.get(context)
        .getList("exp")!
        .map((str) => DateTime.parse(str))
        .toList();

    if (intList.isEmpty) {
      return false;
    } else if (intList.isNotEmpty && DateList.isNotEmpty) {
      for (int i = 0; i < intList.length; i++) {
        DateTime courseExpDate = DateList[i];
        if (courseExpDate.difference(DateTime.now()) == Duration.zero) {
          DateList.removeAt(i);
          intList.removeAt(i);
        }
      }

      for (int i = 0; i < intList.length; i++) {

        if (courseDetails["id"] != intList[i]) {
          isPurched = false;

        }
        else{
          isPurched=true;
          break;
        }

      }
      if(isPurched==true){
        await getExams(context: context, id: courseDetails["id"]!);
      }
    }

    return isPurched;
  }
}
