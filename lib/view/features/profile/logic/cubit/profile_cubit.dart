import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_flutter/helpers/dio/dio_client.dart';
import 'package:lms_flutter/view/features/profile/logic/cubit/profile_state.dart';
import 'package:lms_flutter/view/features/profile/logic/repository/profile_repo.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit({required this.profilerepo}) : super(ProfileInitialState());
  ProfileRepo profilerepo;
  DioClient dioClient = DioClient();
  static ProfileCubit get(context) => BlocProvider.of(context);
  dynamic user = [];

  void getUserInfo(BuildContext context) async {
    emit(ProfileLoadingState());
    user = await profilerepo.getProfileInfo(context: context);
    emit(ProfileSucessState());
  }

  void updateUserInfo({
    required BuildContext context,
    required String name,
    required String password,
    required String conpassword,
    required String city,
    required String email,
    required Function callback,
    required Function errorCallback,
  }) async {
    await profilerepo.updateInfo(
        context: context,
        name: name,
        password: password,
        conpassword: conpassword,
        city: city,
        email: email,
        callback: callback,
        errorCallback: errorCallback);
  }

  void updatePassword({
    required Function callback,
    required Function errorCallback,
    required BuildContext context,
    required String password,
    required String newpassword,
  }) async {
    await profilerepo.updatePassword(
        password: password,
        newpassword: newpassword,
        callback: callback,
        errorCallback: errorCallback,
        context: context);
  }
}
