class ExamListModel {
  int? examId;
  String? examTitle;
  int? examTime;
  int? examGrade;
  String? examStartsAt;
  String? examEndsAt;
  bool? isCompleted;
  int? examAnswerId;
  int? userGrade;
  int? numberOfRightAnswers;
  String? status;
  String? examAnswersStartsAt;
  String? examAnswersExpiresAt;

  ExamListModel({
    this.examId,
    this.examTitle,
    this.examTime,
    this.examGrade,
    this.examStartsAt,
    this.examEndsAt,
    this.isCompleted,
    this.examAnswerId,
    this.userGrade,
    this.numberOfRightAnswers,
    this.status,
    this.examAnswersExpiresAt,
    this.examAnswersStartsAt,
  });

  ExamListModel.fromJson(Map<String, dynamic> json) {
    examId = json['exam_id'];
    examTitle = json['exam_title'];
    examTime = json['exam_time'];
    examGrade = json['exam_grade'];
    examStartsAt = json['exam_starts_at'];
    examEndsAt = json['exam_ends_at'];
    isCompleted = json['isCompleted'];
    examAnswerId = json['exam_answer_id'];
    userGrade = json['userGrade'];
    numberOfRightAnswers = json['numberOfRightAnswers'];
    status = json['status'];
    examAnswersStartsAt = json['exam_answers_starts_at'];
    examAnswersExpiresAt = json['exam_answers_expires_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exam_id'] = examId;
    data['exam_title'] = examTitle;
    data['exam_time'] = examTime;
    data['exam_grade'] = examGrade;
    data['exam_starts_at'] = examStartsAt;
    data['exam_ends_at'] = examEndsAt;
    data['isCompleted'] = isCompleted;
    data['exam_answer_id'] = examAnswerId;
    data['userGrade'] = userGrade;
    data['numberOfRightAnswers'] = numberOfRightAnswers;
    data['status'] = status;
    data['exam_answers_starts_at'] = examAnswersStartsAt;
    data['exam_answers_expires_at'] = examAnswersExpiresAt;
    return data;
  }
}
