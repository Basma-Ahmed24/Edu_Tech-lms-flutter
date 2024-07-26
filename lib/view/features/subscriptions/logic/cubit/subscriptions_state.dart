abstract class  SubscriptionsState {}
class SubscriptionsInitialState extends SubscriptionsState{}
class SubscriptionsLoadingState extends SubscriptionsState{}
class SubscriptionsLoadedState extends SubscriptionsState{}
class SubscriptionsErrorState extends SubscriptionsState{
  dynamic error ;
  SubscriptionsErrorState({required error});
}
class CodeLoadingState extends SubscriptionsState{}
class CodeLoadedState extends SubscriptionsState{}
class CodeErrorState extends SubscriptionsState{
  dynamic error ;
  CodeErrorState({required error});
}
