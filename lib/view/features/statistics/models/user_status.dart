class UserStatus {
  List<TheData>? theData;
  List<Exams>? exams;
  List<Notifications>? notifications;

  UserStatus({this.theData, this.exams, this.notifications});

  UserStatus.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      theData = <TheData>[];
      json['data'].forEach((v) {
        theData!.add(TheData.fromJson(v));
      });
    }
    if (json['exams'] != null) {
      exams = <Exams>[];
      json['exams'].forEach((v) {
        exams!.add(Exams.fromJson(v));
      });
    }
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (theData != null) {
      data['data'] = theData!.map((v) => v.toJson()).toList();
    }
    if (exams != null) {
      data['exams'] = exams!.map((v) => v.toJson()).toList();
    }
    if (notifications != null) {
      data['notifications'] = notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TheData {
  int? id;
  String? name;
  int? progressPercentage;
  int? examsCount;

  TheData({this.id, this.name, this.progressPercentage, this.examsCount});

  TheData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    progressPercentage = json['progress_percentage'];
    examsCount = json['exams_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['progress_percentage'] = progressPercentage;
    data['exams_count'] = examsCount;
    return data;
  }
}

class Exams {
  int? id;
  int? userGrade;
  int? numberOfRightAnswers;
  String? status;
  String? startsAt;
  String? expiresAt;
  int? examId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  Exam? exam;

  Exams(
      {this.id,
      this.userGrade,
      this.numberOfRightAnswers,
      this.status,
      this.startsAt,
      this.expiresAt,
      this.examId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.exam});

  Exams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userGrade = json['user_grade'];
    numberOfRightAnswers = json['numberOfRightAnswers'];
    status = json['status'];
    startsAt = json['starts_at'];
    expiresAt = json['expires_at'];
    examId = json['exam_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    exam = json['exam'] != null ? Exam.fromJson(json['exam']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_grade'] = userGrade;
    data['numberOfRightAnswers'] = numberOfRightAnswers;
    data['status'] = status;
    data['starts_at'] = startsAt;
    data['expires_at'] = expiresAt;
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
  String? type;

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
      this.type});

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
    type=json["type"];
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
    data["type"]=type;
    return data;
  }
}

class Notifications {
  int? id;
  DateTime? createdAt;
  String? updatedAt;
  String? body;
  String? title;

  Notifications(
      {this.id, this.createdAt, this.updatedAt, this.body, this.title});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = json['updated_at'];
    body = json['body'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['body'] = body;
    data['title'] = title;
    return data;
  }
}
