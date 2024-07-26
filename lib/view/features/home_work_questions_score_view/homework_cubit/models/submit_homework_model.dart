class SubmitHomeworkModel {
  bool? success;
  String? message;
  HomeworData? data;

  SubmitHomeworkModel({
    this.success,
    this.message,
    this.data,
  });

  SubmitHomeworkModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? HomeworData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class HomeworData {
  int? submissionId;
  int? userGrade;
  int? numberOfRightAnswers;
  bool? isDraft;
  String? status;
  String? startsAt;
  String? expiresAt;
  HomeWordId? homeWordId;
  HomeWordId? homeWork;

  HomeworData(
      {this.submissionId,
      this.userGrade,
      this.numberOfRightAnswers,
      this.isDraft,
      this.status,
      this.startsAt,
      this.expiresAt,
      this.homeWordId,
      this.homeWork});

  HomeworData.fromJson(Map<String, dynamic> json) {
    submissionId = json['id'];
    userGrade = json['grade'];
    numberOfRightAnswers = json['numberOfRightAnswers'];
    if (json['isDraft'] != null) {
      isDraft = json['isDraft'];
    }
    status = json['status'];
    startsAt = json['starts_at'];
    expiresAt = json['expires_at'];
    homeWordId = json['homeWord_id'] != null
        ? HomeWordId.fromJson(json['homeWord_id'])
        : null;
    homeWork =
        json['homeWork'] != null ? HomeWordId.fromJson(json['homeWork']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = submissionId;
    data['grade'] = userGrade;
    data['numberOfRightAnswers'] = numberOfRightAnswers;
    data['isDraft'] = isDraft;
    data['status'] = status;
    data['starts_at'] = startsAt;
    data['expires_at'] = expiresAt;
    if (homeWordId != null) {
      data['exam_id'] = homeWordId!.toJson();
    }
    if (homeWork != null) {
      data['homeWork'] = homeWork!.toJson();
    }
    return data;
  }
}

class HomeWordId {
  int? id;
  String? title;
  String? type;
  int? grade;
  String? startsAt;
  String? endsAt;
  int? userId;
  int? lessonId;
  String? createdAt;
  String? updatedAt;
  List<Questions>? questions;

  HomeWordId(
      {this.id,
      this.title,
      this.type,
      this.grade,
      this.startsAt,
      this.endsAt,
      this.userId,
      this.lessonId,
      this.createdAt,
      this.updatedAt,
      this.questions});

  HomeWordId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    grade = json['grade'];
    startsAt = json['starts_at'];
    endsAt = json['ends_at'];
    userId = json['user_id'];
    lessonId = json['lesson_modules_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['type'] = type;
    data['grade'] = grade;
    data['starts_at'] = startsAt;
    data['ends_at'] = endsAt;
    data['user_id'] = userId;
    data['lesson_modules_id'] = lessonId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  int? id;
  String? title;
  int? grade;
  int? correctAnswer;
  int? examId;

  Questions({this.id, this.title, this.grade, this.correctAnswer, this.examId});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    grade = json['grade'];
    correctAnswer = json['correctAnswer'];
    examId = json['exam_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['grade'] = grade;
    data['correctAnswer'] = correctAnswer;
    data['exam_id'] = examId;
    return data;
  }
}
