abstract class SearchState {}
class SearchInitialState extends SearchState{}
class SearchLoadingState extends SearchState{}
class SearchLoadedState extends SearchState{}
class SearchErrorState extends SearchState{
  dynamic error ;
  SearchErrorState({required error});
}