import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_flutter/view/features/cources/logic/repository/courses_repo.dart';
import 'package:lms_flutter/view/features/module/cubit/state.dart';

import '../../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import '../network/repo.dart';

class ModuleCubit extends Cubit<ModuleState> {
  ModuleCubit({required this.moduleRepo}) : super(ModuleInitialState());
  final ModuleRepo moduleRepo;

  var lessons;
  var homework;
  var homeworkInfo;
  var homeworkdetails;
  var moduleDetails;
  var exams;
  var files;

  static ModuleCubit get(context) => BlocProvider.of(context);

  Future getModuleInfo({required BuildContext context, required int id}) async {
    emit(ModuleLoadingState());

    moduleDetails = await moduleRepo.getModuleInfo(context: context, id: id);
    print(moduleDetails);
    lessons = moduleDetails["lessons"];

    emit(ModuleLoadedState());
  }

  Future<void> getExams(
      {required BuildContext context, required int id}) async {
    emit(ModuleLoadingState());

    exams = await moduleRepo.getExamInfo(context: context, id: id);

    emit(ModuleLoadedState());
  }

  Future<void> getFiles(
      {required BuildContext context, required int id}) async {
    emit(ModuleLoadingState());

    files = await moduleRepo.getFiles(context: context, id: id);
    emit(ModuleLoadedState());
  }
  Future<void> getHomework(
      {required BuildContext context, required int id}) async {
    emit(ModuleLoadingState());

    homeworkdetails = await moduleRepo.getHomeworkInfo(context: context, id: id);
    homework=homeworkdetails[0];
    homeworkInfo=homeworkdetails[1];
    emit(ModuleLoadedState());
  }


}
