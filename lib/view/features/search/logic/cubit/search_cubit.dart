import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_flutter/view/features/search/logic/cubit/search_state.dart';
import 'package:lms_flutter/view/features/search/logic/repository/search_repo.dart';
class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.searchRepo}) : super( SearchInitialState());
  SearchRepo searchRepo;
 dynamic data;
  static SearchCubit get(context) => BlocProvider.of(context);
  void searchCourse(context,TextEditingController name) async {
      emit(SearchLoadingState());
      data=await searchRepo.Search(name: name.text,context: context);
        emit(SearchLoadedState());


  }

}