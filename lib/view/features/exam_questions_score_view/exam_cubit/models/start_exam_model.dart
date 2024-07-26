class StartExamModel {
  int? id;
  String? title;
  int? examTime;
  String? starts_at;
  String?type;
  int?lesson_modules_id;
  int?course_id;
  String? endsAt;
  RemainingTime? remainingTime;
  List<Questions>? questions;

  StartExamModel(
      {this.id,
      this.title,
      this.examTime,
      this.endsAt,
      this.remainingTime,
      this.questions,
      this.type,
      this.course_id,this.lesson_modules_id,
      this.starts_at});

  StartExamModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    examTime = json['exam_time'];
    endsAt = json['ends_at'];
    starts_at=json["starts_at"];
    type=json["type"];
    lesson_modules_id=json["lesson_modules_id"];
    course_id=json["course_id"];
    remainingTime = json['remainingTime'] != null
        ? RemainingTime.fromJson(json['remainingTime'])
        : null;
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
    data['ends_at'] = endsAt;
    data["starts_at"]=starts_at;
    data["type"]=type;
    data["lesson_modules_id"]=lesson_modules_id;
    data["course_id"]=course_id;
    if (remainingTime != null) {
      data['remainingTime'] = remainingTime!.toJson();
    }
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RemainingTime {
  int? years;
  int? months;
  int? days;
  int? hours;
  int? minutes;
  int? seconds;

  RemainingTime(
      {this.years,
      this.months,
      this.days,
      this.hours,
      this.minutes,
      this.seconds});

  RemainingTime.fromJson(Map<String, dynamic> json) {
    years = json['years'];
    months = json['months'];
    days = json['days'];
    hours = json['hours'];
    minutes = json['minutes'];
    seconds = json['seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['years'] = years;
    data['months'] = months;
    data['days'] = days;
    data['hours'] = hours;
    data['minutes'] = minutes;
    data['seconds'] = seconds;
    return data;
  }
}

class Questions {
  int? id;
  int? examId;
  String? title;
  int? grade;
 String?image;
  List<Answers>? answers;

  Questions({
    this.id,
    this.examId,
    this.title,
    this.grade,
    this.answers,
    this.image
  });

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    examId = json['exam_id'];
    title = json['title'];
    grade = json['grade'];
    image=json["image"];
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
    data['exam_id'] = examId;
    data['title'] = title;
    data['grade'] = grade;
    data["image"]=image;
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  int? id;
  int? questionId;
  String? title;

  Answers({this.id, this.questionId, this.title});

  Answers.fromJson(Map<String, dynamic> json) {
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
