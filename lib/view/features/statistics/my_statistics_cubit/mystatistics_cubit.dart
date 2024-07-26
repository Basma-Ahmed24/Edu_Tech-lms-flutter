import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../network/my_statistics_repo.dart';
import '../models/user_status.dart';

part 'mystatistics_state.dart';

class MyStatisticsCubit extends Cubit<MyStatisticsState> {
  MystatisticsRepo mystatisticsRepo;

  MyStatisticsCubit({
    required this.mystatisticsRepo,
  }) : super(MyStatisticsInitial());

  static MyStatisticsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 1;

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeIndexState());
  }

  int currentTapPie = -1;

  void getCurrentTapPie(int value) {
    currentTapPie = value;
    emit(GetCurrentTapPieState());
  }

  //! data
  UserStatus userStatus = UserStatus();

  //!loading
  bool isLoadingUserStatus = true;

  //! logic
  getUserStatus({required BuildContext context, bool isRefresh = false}) async {
    if (isRefresh) {
      userStatus = UserStatus();
      emit(GetProfileState());
    }
    if (userStatus.exams == null && userStatus.notifications == null) {
      userStatus = UserStatus();
      isLoadingUserStatus = true;
      emit(GetProfileState());
      var data = await mystatisticsRepo.getUserStatus(
        context: context,
      );
      isLoadingUserStatus = false;
      userStatus = data;

      emit(GetProfileState());
    }
    isLoadingUserStatus = false;
    emit(GetProfileState());
  }
}
