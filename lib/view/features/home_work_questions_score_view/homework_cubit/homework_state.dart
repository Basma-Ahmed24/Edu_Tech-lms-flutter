part of 'homework_cubit.dart';

abstract class HomeworkState {}

class HomeworkInitial extends HomeworkState {}

class NextQuestionState extends HomeworkState {}

class PreviousQuestionState extends HomeworkState {}

class CurrentPressedState extends HomeworkState {}

class ResetDataState extends HomeworkState {}

class PlayWrongAudioState extends HomeworkState {}

class PlayRightAudioState extends HomeworkState {}

class GetAvailableExamsState extends HomeworkState {}

class UpdateTimerState extends HomeworkState {}

class SubmitExamState extends HomeworkState {}

class StatrTimerState extends HomeworkState {}
