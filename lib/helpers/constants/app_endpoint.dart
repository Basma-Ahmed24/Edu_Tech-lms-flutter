class AppEndPoint {
  static const String baseUrl = 'https://mark2.faheemacademy.online';
  static const String apiBaseUrl = 'https://mark2.faheemacademy.online/api';
  // static const String baseUrl = 'https://firststep.aisevenp.com/api';
  static const String register = '/register';
  static const String checkPhoneOTPRegister = '/checkPhoneOTPRegister';
  static const String checkPhoneOTPForget = '/checkPhoneOTPForget';
  static const String resetPassword = '/resetPassword';
  static const String login = '/login';
  static const String deleteAccount = '/users/delete';
  static const String forgetPassword = '/forgetPassword';

  //!courses
  static const String allCourses = '/course/all?page=';
  static const String searchCourses = '/course/search?query=';
  static const String course = '/course/';

  //!Exam
  static const String getAvailableExams = '/exam/getAvailableExams?course_id=';
  static const String startExam = '/v1/exam/startExam';
  static const String submitExam = '/exam/submitExam';

  //!homework
  static const String getHomeworkAvailable = '/homeWork/getHomeWork?lesson_id=';
  static const String startHomework = '/homeWork/startHomeWork?lesson_id=';
  static const String submitHomework = '/homeWork/submitHomeWork';

  //!lessons
  static const String allLessons = '/lesson/';
  static const String lesson = '/lesson/';
  static const String searchAdditionLesson = '/additionLesson/search?query=';
  static const String additionLesson = '/additionLesson/all?page=';
  static const String theAdditionLesson = '/additionLesson/';
  static const String files = '/files';

  //!payments code
  static const String createInvoice = '/payment/createInvoice';
  static const String paymentMethods = '/payment/getMethods';
  static const String useCode = '/subscription/useCode';
  static const String getUserSubscriptions =
      '/subscription/getUserSubscriptions?type=';

//! profile
  static const String getCurrentUser = '/users/getCurrent';
  static const String updateCurrentUser = '/users/updateCurrent';
  static const String updatePassword = '/users/updatePassword';
  static const String userStatus = '/stats';

//! bar message
  static const String getAllBarMessage = '/bar/getAll';
}
