abstract class HomeStates {}
class InitialState extends HomeStates{}
class GetIndexState extends HomeStates{}
class LoadingState extends HomeStates{}
class LoadedState extends HomeStates{}
class ErrorState extends HomeStates{
  dynamic error ;
  ErrorState({required error});
}
