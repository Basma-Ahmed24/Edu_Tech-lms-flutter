import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_flutter/view/features/subscriptions/logic/cubit/subscriptions_state.dart';

import '../../../../../helpers/dio/dio_client.dart';
import '../repository/subscription_repo.dart';

class SubscriptionsCubit extends Cubit<SubscriptionsState> {
  SubscriptionsCubit({required this.repo}) : super(SubscriptionsInitialState());
  DioClient dioClient = DioClient();
  SubscriptionRepo repo;
  List cources = [];

  static SubscriptionsCubit get(context) => BlocProvider.of(context);
  Future<void> sendCode(
      {context,
      required String code,
      required Function callback,
      required Function errorCallback}) async {
    await repo.sendCode(
        context: context,
        code: code,
        callback: callback,
        errorCallback: errorCallback);
  }

  void getAllSubscriptions({context, type}) async {
    emit(SubscriptionsLoadingState());
    cources = await repo.getSubscriptions(type: type, context: context);
    emit(SubscriptionsLoadedState());
  }
}
