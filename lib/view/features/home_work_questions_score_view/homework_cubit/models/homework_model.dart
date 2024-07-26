class HomeworkModel {
  bool? success;
  String? message;
  Data? data;

  HomeworkModel({
    this.success,
    this.message,
    this.data,
  });

  HomeworkModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  int? submissionId;
  List<String>? drafts;
  HomeWork? homeWork;

  Data({
    this.submissionId,
    this.drafts,
    this.homeWork,
  });

  Data.fromJson(Map<String, dynamic> json) {
    submissionId = json['submission_id'];
    if (json['draft'] != null) {
      // List<String> holdIt = [];
      // holdIt.add(json['draft']);
      // drafts = holdIt;
      drafts = json['draft'].cast<String>();
    }
    homeWork =
        json['homeWork'] != null ? HomeWork.fromJson(json['homeWork']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['submission_id'] = submissionId;
    // data['draft'] = draft;
    if (homeWork != null) {
      data['homeWork'] = homeWork!.toJson();
    }
    return data;
  }
}

class HomeWork {
  int? id;
  String? title;
  int? grade;
  String? startsAt;
  String? endsAt;
  int? lessonId;
  List<HomeworkQuestions>? questions;

  HomeWork(
      {this.id,
      this.title,
      this.grade,
      this.startsAt,
      this.endsAt,
      this.lessonId,
      this.questions});

  HomeWork.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    grade = json['grade'];
    startsAt = json['starts_at'];
    endsAt = json['ends_at'];
    lessonId = json['lesson_modules_id'];
    if (json['questions'] != null) {
      questions = <HomeworkQuestions>[];
      json['questions'].forEach((v) {
        questions!.add(HomeworkQuestions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['grade'] = grade;
    data['starts_at'] = startsAt;
    data['ends_at'] = endsAt;
    data['lesson_modules_id'] = lessonId;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeworkQuestions {
  int? id;
  int? examId;
  String? title;
  int? grade;
  List<HomeworkAnswers>? answers;

  HomeworkQuestions({
    this.id,
    this.examId,
    this.title,
    this.grade,
    this.answers,
  });

  HomeworkQuestions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    examId = json['exam_id'];
    title = json['title'];
    grade = json['grade'];
    if (json['answers'] != null) {
      answers = <HomeworkAnswers>[];
      json['answers'].forEach((v) {
        answers!.add(HomeworkAnswers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['exam_id'] = examId;
    data['title'] = title;
    data['grade'] = grade;
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeworkAnswers {
  int? id;
  int? questionId;
  String? title;

  HomeworkAnswers({this.id, this.questionId, this.title});

  HomeworkAnswers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionId = json['question_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question_id'] = questionId;
    data['title'] = title;
    return data;
  }
}
