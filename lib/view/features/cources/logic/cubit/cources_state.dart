abstract class CourcesState {}
class CourcesInitialState extends CourcesState{}
class CourcesLoadingState extends CourcesState{}
class CourcesLoadedState extends CourcesState{}


class CourcesErrorState extends CourcesState{
  dynamic error ;
  CourcesErrorState({required error});
}