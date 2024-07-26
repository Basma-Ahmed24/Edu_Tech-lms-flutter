import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_flutter/view/features/exam_questions_score_view/exam_cubit/exam_cubit.dart';
import 'package:lms_flutter/view/features/home_work_questions_score_view/homework_cubit/homework_cubit.dart';
import 'package:lms_flutter/view/features/lessons/logic/cubit/cubit.dart';
import 'package:lms_flutter/view/features/module/cubit/cubit.dart';
import 'package:lms_flutter/view/features/statistics/my_statistics_cubit/mystatistics_cubit.dart';
import '../../view/features/Auth/logic/cubit/auth_cubit.dart';
import '../../view/features/cources/logic/cubit/cources_cubit.dart';
import '../../view/features/home/logic/cubit/home_cubit.dart';
import '../../view/features/profile/logic/cubit/profile_cubit.dart';
import '../../view/features/search/logic/cubit/search_cubit.dart';
import '../../view/features/subscriptions/logic/cubit/subscriptions_cubit.dart';
import 'cubits/save_it_cubit/save_it_cubit.dart';
import 'injection.dart';

List<BlocProvider> appProviders() {
  return [
     BlocProvider<SaveItCubit>(create: (context) => sl<SaveItCubit>()),
     BlocProvider<AuthCubit>(create: (context) => sl<AuthCubit>()),
     BlocProvider<LessonCubit>(create: (context) => sl<LessonCubit>()),

     BlocProvider<CourcesCubit>(create: (context) => sl<CourcesCubit>()),
     BlocProvider<ModuleCubit>(create: (context) => sl<ModuleCubit>()),
     BlocProvider<HomeCubit>(create: (context) => sl<HomeCubit>()),
     BlocProvider<ProfileCubit>(create: (context) => sl<ProfileCubit>()),
     BlocProvider<SubscriptionsCubit>(create: (context) => sl<SubscriptionsCubit>()),
     BlocProvider<MyStatisticsCubit>(create: (context) => sl<MyStatisticsCubit>()),
     BlocProvider<SearchCubit>(create: (context) => sl<SearchCubit>()),
     BlocProvider<ExamCubit>(create: (context) => sl<ExamCubit>()),
     BlocProvider<HomeworkCubit>(create: (context) => sl<HomeworkCubit>()),
  ];
}
