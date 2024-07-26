abstract class LessonState {}
class LessonInitialState extends LessonState{}
class LessonLoadingState extends LessonState{}
class LessonLoadedState extends LessonState{}

class LessonErrorState extends LessonState{
  dynamic error ;
  LessonErrorState({required error});
}
class HomeworkLoadedState extends LessonState{}


