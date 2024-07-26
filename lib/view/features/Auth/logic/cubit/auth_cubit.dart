import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_flutter/helpers/extensions/print_extention.dart';
import '../../../../../helpers/constants/app_current_lang.dart';
import '../../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import '../reposotiry/auth_reposetory.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthRepo authRepo;
  SaveItCubit saveitCubit;

  AuthCubit({
    required this.authRepo,
    required this.saveitCubit,
  }) : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id;
    }
    return null;
  }

  Future<void> signIn(BuildContext context, Function callback,
      Function errorCallback, phone, password) async {
    await getDeviceId().then(
      (value) async {

        await authRepo.signIn(
          context: context,
          phone: phone,
          password: password,
          deviceId: value,
          callback: callback,
          errorCallback: errorCallback,
        );
      },
    );
  }

//! deleteAccount =====================
  Future<void> deleteAccount(
    BuildContext context,
    Function callback,
    Function errorCallback,
  ) async {
    await authRepo.deleteAccount(
      context: context,
      callback: callback,
      errorCallback: errorCallback,
    );
  }

  // fcm token for notification
  Future<void> FCMtoken(
    BuildContext context,
  ) async {
    await authRepo.FCMtoken(
      context: context,
    );
  }

//!  signUp ====================

  void signUp(
    BuildContext context,
    Function callback,
    Function errorCallback,
    String phone,
    String parentPhone,
    String name,
    String password,
    String conpassword,
    String city,
    String email,
  ) async {
    await authRepo.signUp(
        callback: callback,
        errorCallback: errorCallback,
        context: context,
        password: password,
        parentPhone: parentPhone,
        phone: phone,
        city: city,
        conpassword: conpassword,

        email: email,
        name: name);
  }

//!====================data==========================
  bool checkIfChosen = false;

  List<String> egyCitysList = [];

  void loadEgyCitysJson(BuildContext context) async {
    egyCitysList.clear();
    final String response =
        await rootBundle.loadString('assets/egycitys/citys.json');
    final data = json.decode(response);
    if (AppCurrentLang.isEn(context))
      data.forEach((e) => egyCitysList.add(e['governorate_name_en']));
    else
      data.forEach((e) => egyCitysList.add(e['governorate_name_ar']));

    emit(LoadEgyCitysJsonState());
  }

  getOptionValue(
      {required String value,
      selectedOption,
      required TextEditingController controller}) {
    switch (selectedOption) {
      case 'City':
        controller.text = value;
        break;
      case 'Specialization':
        controller.text = value;
        break;
      case 'Year':
        controller.text = value;
        break;
      default:
    }
    emit(GetTheValueState());
  }

  List<String> specializationList = [
    'math',
    'science',
    'literary',
  ];
  List<String> classRoom = [
    "first",
    "second",
    "third",
  ];
}
