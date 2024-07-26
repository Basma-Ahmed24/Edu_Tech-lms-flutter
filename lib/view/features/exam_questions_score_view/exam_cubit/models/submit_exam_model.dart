class SubmitExamModel {
  int? id;
  int? grade;
  int? numberOfRightAnswers;
  String? status;
  String? startsAt;
  String? expiresAt;
  List<String>? answers;
  int? examId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  Exam? exam;

  SubmitExamModel(
      {this.id,
      this.grade,
      this.numberOfRightAnswers,
      this.status,
      this.startsAt,
      this.expiresAt,
      this.answers,
      this.examId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.exam});

  SubmitExamModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grade = json['grade'];
    numberOfRightAnswers = json['numberOfRightAnswers'];
    status = json['status'];
    startsAt = json['starts_at'];
    expiresAt = json['expires_at'];
    answers = json['answers'].cast<String>();
    examId = json['exam_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    exam = json['exam'] != null ? Exam.fromJson(json['exam']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['grade'] = grade;
    data['numberOfRightAnswers'] = numberOfRightAnswers;
    data['status'] = status;
    data['starts_at'] = startsAt;
    data['expires_at'] = expiresAt;
    data['answers'] = answers;
    data['exam_id'] = examId;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (exam != null) {
      data['exam'] = exam!.toJson();
    }
    return data;
  }
}

class Exam {
  int? id;
  String? title;
  int? examTime;
  String? startsAt;
  int? grade;
  String? endsAt;
  int? userId;
  int? courseId;
  String? createdAt;
  String? updatedAt;
  List<Questions>? questions;

  Exam(
      {this.id,
      this.title,
      this.examTime,
      this.startsAt,
      this.grade,
      this.endsAt,
      this.userId,
      this.courseId,
      this.createdAt,
      this.updatedAt,
      this.questions});

  Exam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    examTime = json['exam_time'];
    startsAt = json['starts_at'];
    grade = json['grade'];
    endsAt = json['ends_at'];
    userId = json['user_id'];
    courseId = json['course_id'];
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
    data['exam_time'] = examTime;
    data['starts_at'] = startsAt;
    data['grade'] = grade;
    data['ends_at'] = endsAt;
    data['user_id'] = userId;
    data['course_id'] = courseId;
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
  List<Answers>? answers;

  Questions(
      {this.id,
      this.title,
      this.grade,
      this.correctAnswer,
      this.examId,
      this.answers});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    grade = json['grade'];
    correctAnswer = json['correctAnswer'];
    examId = json['exam_id'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['grade'] = grade;
    data['correctAnswer'] = correctAnswer;
    data['exam_id'] = examId;
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  int? id;
  String? title;
  int? isCorrect;
  int? questionId;

  Answers({this.id, this.title, this.isCorrect, this.questionId});

  Answers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isCorrect = json['isCorrect'];
    questionId = json['question_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['isCorrect'] = isCorrect;
    data['question_id'] = questionId;
    return data;
  }
}
