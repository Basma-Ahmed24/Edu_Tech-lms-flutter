import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../helpers/dio/dio_client.dart';
import '../repository/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit({required this.homerepo}) : super(InitialState());
  DioClient dioClient = DioClient();
  final HomeRepo homerepo;
  dynamic cources = [];
  dynamic Bars = [];

  static HomeCubit get(context) => BlocProvider.of(context);

  Future getAllCourses(
      {required BuildContext context, required int page}) async {
    emit(LoadingState());

    cources = await homerepo.getAllCourses(context: context, page: page);

    emit(LoadedState());
  }
  Future getAllBars(
      {required BuildContext context}) async {
    emit(LoadingState());

    Bars = await homerepo.getAllBars(context: context);

    emit(LoadedState());
  }
}
