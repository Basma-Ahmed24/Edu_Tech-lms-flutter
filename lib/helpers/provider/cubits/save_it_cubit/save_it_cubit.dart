import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/app_saved_key.dart';

part 'save_it_state.dart';

class SaveItCubit extends Cubit<SaveItState> {
  final SharedPreferences sharedPreferences;

  SaveItCubit({
    required this.sharedPreferences,
  }) : super(SaveItInitial());

  static SaveItCubit get(context) => BlocProvider.of(context);

//! bool
  Future saveBool(String key, bool value) async {
    await sharedPreferences.setBool(key, value);
    emit(GetBoolState());
  }
  Future saveList(String key, List<String> value) async {
    await sharedPreferences.setStringList(key, value);
    //emit(GetBoolState());
  }
  List<String>? getList(String key) {
    return sharedPreferences.getStringList(key);
  }
  bool getBool(String key) {
    return sharedPreferences.getBool(key) ?? false;
  }
  void delete(String key){
    sharedPreferences.remove(key);
  }
//! int
  Future saveInt(String key, int value) async {
    await sharedPreferences.setInt(key, value);
    emit(GetIntState());
  }

  int getInt(String key) {
    return sharedPreferences.getInt(key) ?? 1;
  }

//! string
  Future saveString(String key, String value) async {
    await sharedPreferences.setString(key, value);
    emit(GetBoolState());
  }

  String? getString(String key) {
    return sharedPreferences.getString(key);
  }

//! global
  String getLang() {
    var lang = sharedPreferences.getString(AppSavedKey.currentLang);
    if (lang == null || lang.isEmpty) {
      return 'ar';
    } else {
      return sharedPreferences.getString(AppSavedKey.currentLang)!;
    }
  }

  String isLoggedIn() {
    return sharedPreferences.getString(AppSavedKey.isDarkMode) ?? '';
  }

  String getUserId() {
    return sharedPreferences.getString(AppSavedKey.userId) ?? '';
  }

  bool getShowCaseValue() {
    return sharedPreferences.getBool(AppSavedKey.showCase) ?? true;
  }

  Future reload() async {
    emit(ReloadState());
  }

  //! for notification
  Future subscribeToTopic() async {
    await FirebaseMessaging.instance.subscribeToTopic(
      AppSavedKey.notiTopic,
    );
    await FirebaseMessaging.instance.subscribeToTopic(
      AppSavedKey.notiTopic + getUserId(),
    );
  }

  Future unsubscribeFromTopic() async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(
      AppSavedKey.notiTopic,
    );
    await FirebaseMessaging.instance.unsubscribeFromTopic(
      AppSavedKey.notiTopic + getUserId(),
    );
  }
}
