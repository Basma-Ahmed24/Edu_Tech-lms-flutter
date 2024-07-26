import 'package:get_it/get_it.dart';
import 'package:lms_flutter/helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import 'package:lms_flutter/view/features/cources/logic/repository/courses_repo.dart';
import 'package:lms_flutter/view/features/cources/logic/web_services/courses_web_services.dart';
import 'package:lms_flutter/view/features/exam_questions_score_view/exam_cubit/exam_cubit.dart';
import 'package:lms_flutter/view/features/lessons/logic/cubit/cubit.dart';
import 'package:lms_flutter/view/features/lessons/logic/repository/lesson_repo.dart';
import 'package:lms_flutter/view/features/module/cubit/cubit.dart';
import 'package:lms_flutter/view/features/module/network/repo.dart';
import 'package:lms_flutter/view/features/module/network/webservices.dart';
import 'package:lms_flutter/view/features/statistics/my_statistics_cubit/mystatistics_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view/features/Auth/logic/cubit/auth_cubit.dart';
import '../../view/features/Auth/logic/reposotiry/auth_reposetory.dart';
import '../../view/features/Auth/logic/web_services/auth_web_servces.dart';
import '../../view/features/cources/logic/cubit/cources_cubit.dart';
import '../../view/features/exam_questions_score_view/network/exam_repo.dart';
import '../../view/features/exam_questions_score_view/network/exam_web_services.dart';
import '../../view/features/home/logic/cubit/home_cubit.dart';
import '../../view/features/home/logic/repository/home_repo.dart';
import '../../view/features/home/logic/webservices/home_webservices.dart';
import '../../view/features/home_work_questions_score_view/homework_cubit/homework_cubit.dart';
import '../../view/features/home_work_questions_score_view/network/homework_repo.dart';
import '../../view/features/home_work_questions_score_view/network/homework_webservices.dart';
import '../../view/features/lessons/logic/webservices/lesson_webservices.dart';
import '../../view/features/profile/logic/cubit/profile_cubit.dart';
import '../../view/features/profile/logic/repository/profile_repo.dart';
import '../../view/features/profile/logic/webservices/profile_webservices.dart';
import '../../view/features/search/logic/cubit/search_cubit.dart';
import '../../view/features/search/logic/repository/search_repo.dart';
import '../../view/features/search/logic/web_services/search_webservices.dart';
import '../../view/features/statistics/network/my_statistics_repo.dart';
import '../../view/features/statistics/network/my_statistics_web_services.dart';
import '../../view/features/subscriptions/logic/cubit/subscriptions_cubit.dart';
import '../../view/features/subscriptions/logic/repository/subscription_repo.dart';
import '../../view/features/subscriptions/logic/webservices/subscription_web_services.dart';
import '../dio/dio_client.dart';


GetIt sl = GetIt.instance;

Future<void> initGetIt() async {
  sl.registerLazySingleton(() => DioClient());
  sl.registerLazySingleton<SaveItCubit>(() => SaveItCubit(
        sharedPreferences: sl(),
      ));
  sl.registerLazySingleton<AuthCubit>(
          () => AuthCubit(authRepo: sl(), saveitCubit: sl()));
  sl.registerLazySingleton<AuthRepo>(
          () => AuthRepoImp(authWebServices: sl(), saveitCubit: sl()));
  sl.registerLazySingleton<AuthWebServices>(
          () => AuthWebServicesImp(dioClient: sl()));
  sl.registerLazySingleton<HomeRepo>(() => HomeRepoImp(homeWebServices: sl(),saveitCubit: sl()));
  sl.registerLazySingleton<HomeWebServices>(
          () => HomeWebServicesImp(dioClient: sl(), saveitCubit: sl()));
  sl.registerLazySingleton<HomeCubit>(
          () => HomeCubit(homerepo: sl()));

  sl.registerLazySingleton<ModuleRepo>(() => ModuleRepoImp(moduleWebServices: sl()));
  sl.registerLazySingleton<ModuleWebServices>(
          () => ModuleWebServicesImp(dioClient: sl()));
  sl.registerLazySingleton<ModuleCubit>(
          () => ModuleCubit(moduleRepo: sl()));

  sl.registerLazySingleton<LessonRepo>(() => LessonRepoImp(lessonWebServices: sl(),saveitCubit: sl()));
  sl.registerLazySingleton<LessonWebServices>(
          () => LessonWebServicesImp(dioClient: sl(), saveitCubit: sl()));
  sl.registerLazySingleton<LessonCubit>(
          () => LessonCubit(lessonrepo: sl()));
  sl.registerLazySingleton<ProfileRepo>(() => ProfileRepoImp(profileWebServices: sl(),saveitCubit: sl()));
  sl.registerLazySingleton<ProfileWebServices>(
          () => ProfileWebServicesImp(dioClient: sl(), saveitCubit: sl()));
  sl.registerLazySingleton<ProfileCubit>(
          () => ProfileCubit(profilerepo: sl()));

  sl.registerLazySingleton<SubscriptionsCubit>(
          () => SubscriptionsCubit(repo: sl()));
  sl.registerLazySingleton<SubscriptionRepo>(() => SubscriptionRepoImp(subscriptionsWebServices: sl(),saveitCubit: sl()));
  sl.registerLazySingleton<SubscriptionsWebServices>(
          () => SubscriptionsWebServicesImp(dioClient: sl(), saveitCubit: sl()));
  sl.registerLazySingleton<SearchRepo>(() => SearchRepoImp(searchWebServices: sl(),saveitCubit: sl()));
  sl.registerLazySingleton<SearchWebServices>(
          () => SearchWebServicesImp(dioClient: sl(), saveitCubit: sl()));
  sl.registerLazySingleton<SearchCubit>(
          () => SearchCubit(searchRepo: sl()));
  sl.registerLazySingleton<CourcesCubit>(
          () => CourcesCubit(coursesRepo: sl()));
  sl.registerLazySingleton<ExamWebServices>(
          () => ExamWebServicesImp(dioClient: sl(), saveitCubit: sl()));
  sl.registerLazySingleton<CourseWebServices>(
          () => CourseWebServiceImp(dioClient: sl()));
  sl.registerLazySingleton<CourseRepo>(() => CourseRepoImp(courseWebServices: sl()));

  sl.registerLazySingleton<ExamRepo>(() => ExamRepoImp(examWebServices: sl()));
  var sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<ExamCubit>(() => ExamCubit(examRepo: sl()));
  sl.registerLazySingleton<HomeworkCubit>(
          () => HomeworkCubit(homeworkRepo: sl()));
  sl.registerLazySingleton<HomeworkRepo>(
          () => HomeworkRepoImp(homeworkWebServices: sl()));
  sl.registerLazySingleton<HomeworkWebServices>(() => HomeworkWebServicesImp(
    dioClient: sl(),
    saveitCubit: sl(),
  ));
  sl.registerLazySingleton<MyStatisticsCubit>(
          () => MyStatisticsCubit(mystatisticsRepo: sl()));
  sl.registerLazySingleton<MystatisticsRepo>(
          () => MystatisticsRepoImp(myStatisticsWebServices: sl()));
  sl.registerLazySingleton<MyStatisticsWebServices>(
          () => MyStatisticsWebServicesImp(dioClient: sl(), saveitCubit: sl()));
  sl.registerLazySingleton(() => sharedPreferences);
}
