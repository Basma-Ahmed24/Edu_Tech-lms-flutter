part of 'exam_cubit.dart';

abstract class ExamState {}

class ExamInitial extends ExamState {}

class NextQuestionState extends ExamState {}

class PreviousQuestionState extends ExamState {}

class CurrentPressedState extends ExamState {}

class ResetDataState extends ExamState {}

class PlayWrongAudioState extends ExamState {}

class PlayRightAudioState extends ExamState {}

class GetAvailableExamsState extends ExamState {}

class UpdateTimerState extends ExamState {}

class SubmitExamState extends ExamState {}

class StatrTimerState extends ExamState {}
