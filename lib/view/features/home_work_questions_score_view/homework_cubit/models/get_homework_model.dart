class GetHomeworkModel {
  bool? success;
  String? message;
  Data? data;

  GetHomeworkModel({this.success, this.message, this.data});

  GetHomeworkModel.fromJson(Map<String, dynamic> json) {
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
  int? homeWorkId;
  String? startsAt;
  String? endsAt;
  int? lessonId;
  String? createdAt;

  Data(
      {this.homeWorkId,
      this.startsAt,
      this.endsAt,
      this.lessonId,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    homeWorkId = json['homeWork_id'];
    startsAt = json['starts_at'];
    endsAt = json['ends_at'];
    lessonId = json['lesson_modules_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['homeWork_id'] = homeWorkId;

    data['starts_at'] = startsAt;
    data['ends_at'] = endsAt;
    data['lesson_modules_id'] = lessonId;
    data['created_at'] = createdAt;
    return data;
  }
}
