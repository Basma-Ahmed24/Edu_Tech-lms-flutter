import 'package:flutter/material.dart';
import 'package:lms_flutter/view/features/home/screens/home_screen.dart';
import 'package:lms_flutter/view/features/navigation_bar/navigation_bar_screen.dart';
import '../../view/features/Auth/screens/forget_password/forget_password_screen.dart';
import '../../view/features/Auth/screens/login/login_screen.dart';
import '../../view/features/Auth/screens/register/register_screen.dart';
import '../../view/features/cources/screens/cource_content_screen.dart';
import '../../view/features/cources/screens/all_courses.dart';
import '../../view/features/exam_questions_score_view/screens/exam_questions_view.dart';
import '../../view/features/exam_questions_score_view/screens/exam_score_view.dart';
import '../../view/features/home_work_questions_score_view/screens/home_work_questions_view.dart';
import '../../view/features/home_work_questions_score_view/screens/home_work_score_view.dart';
import '../../view/features/profile/screens/edit_profile_screen.dart';
import '../../view/features/profile/screens/profile_screen.dart';
import '../../view/features/search/search_screen.dart';
import '../../view/features/splash_view/splash_view.dart';
import '../../view/features/statistics/screens/my_statistics_view.dart';
import '../../view/features/subscriptions/screens/subscription_Screen.dart';
import '../router/app_name_route.dart';
import '../../models/screen_argument.dart';
// import '../../view/screens/auth_view/sign_in_view.dart';
// import '../../view/screens/buy_course_view/screens/purchase_invoice_view.dart';
// import '../../view/screens/init_screens/temp_spalsh_screen.dart';
// import '../../view/screens/lesson_details_view/lesson_details_view.dart';
// import '../../view/screens/lesson_details_view/the_lesson_view.dart';
// import '../../view/screens/splash_view/splash_view.dart';

class AppRouter {
  static Route<dynamic> generatorRoutes(RouteSettings settings) {
    var argument = settings.arguments as ScreenArgument?;

    switch (settings.name) {
      case AppNameRoute.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
        );

      case AppNameRoute.homeScreen:
        return MaterialPageRoute(
          builder: (context) =>  HomeScreen(),
        );
      case AppNameRoute.signUpScreen:
        return MaterialPageRoute(
          builder: (context) =>  Register(),
        );
      case AppNameRoute.signInScreen:
        return MaterialPageRoute(
          builder: (context) =>  Login(),
        );
      case AppNameRoute.forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (context) =>  ForgetPassword(),
        );
    //   case AppNameRoute.changePasswordScreen:
    //     return MaterialPageRoute(
    //       builder: (context) => const ChangePasswordView(),
    //     );
    //   case AppNameRoute.otpScreen:
    //     String phoneNumber = argument!.arguments['phoneNumber'] as String;
    //     bool isChagePassword = argument.arguments['isForgetPassword'] as bool;
    //     return MaterialPageRoute(
    //       builder: (context) => OtpView(
    //         phoneNumber: phoneNumber,
    //         isForgetPassword: isChagePassword,
    //       ),
    //     );
      case AppNameRoute.controllerScreen:
        return MaterialPageRoute(
          builder: (context) =>  MyNavigationBar(),
        );
    //   case AppNameRoute.courseDetailsScreen:
    //     int courseId = argument!.arguments['courseId'] as int;
    //     return MaterialPageRoute(
    //       builder: (context) => CourseDetailsView(courseId: courseId),
    //     );
    //   case AppNameRoute.chatScreen:
    //     return MaterialPageRoute(
    //       builder: (context) => const ChatView(),
    //     );
    //   case AppNameRoute.searchScreen:
    //     return MaterialPageRoute(
    //       builder: (context) =>  SearchView(),
    //     );
      case AppNameRoute.allCoursesScreen:
        return MaterialPageRoute(
          builder: (context) =>  AllCources(),
        );
    //   case AppNameRoute.buyCourseScreen:
    //     return MaterialPageRoute(
    //       builder: (context) => BuyCourseView(
    //         courseId: argument!.arguments['courseId'] ?? -1,
    //         isAdditionLesson: argument.arguments['isAdditionLesson'] ?? false,
    //         lessonId: argument.arguments['lessonId'] ?? -1,
    //       ),
    //     );
      case AppNameRoute.courseContentScreen:
        int courseId = argument!.arguments['courseId'] as int;

        return MaterialPageRoute(
          builder: (context) => CourseContent( courseId),);
      case AppNameRoute.homeWorkQuestionsScreen:
        int lessonId = argument!.arguments['lessonId'] as int;
        return MaterialPageRoute(
          builder: (context) => HomeWorkQuestionsView(
            lessonId: lessonId,
          ),
        );
      case AppNameRoute.homeWorkScoreScreen:
        return MaterialPageRoute(
          builder: (context) =>  HomeWorkScoreView(),
        );
      case AppNameRoute.examQuestionsScreen:
        int examId = argument!.arguments['examId'] as int;
        int courseId = argument.arguments['courseId'] as int;
        return MaterialPageRoute(
          builder: (context) => ExamQuestionsView(
            examId: examId,
            courseId: courseId,
          ),
        );
      case AppNameRoute.examScoreScreen:
        return MaterialPageRoute(
          builder: (context) => const ExamScoreView(),
        );
    //   case AppNameRoute.purchaseInvoiceScreen:
    //     return MaterialPageRoute(
    //       builder: (context) => PurchaseInvoiceView(
    //         isAdditionLesson: argument!.arguments['isAdditionLesson'] ?? false,
    //       ),
    //     );
    //   case AppNameRoute.lessonDetailsScreen:
    //     int lessonId = argument!.arguments['lessonId'] as int;
    //     return MaterialPageRoute(
    //       builder: (context) => LessonDetailsView(
    //         lessonId: lessonId,
    //         isAdditionLesson: argument.arguments['isAdditionLesson'] ?? true,
    //       ),
    //     );
    //   case AppNameRoute.theLessonScreen:
    //     int lessonId = argument!.arguments['lessonId'] as int;
    //     return MaterialPageRoute(
    //       builder: (context) => TheLessonView(
    //         lessonId: lessonId,
    //         index: argument.arguments['index'] ?? -1,
    //         isAdditionLesson: argument.arguments['isAdditionLesson'] ?? false,
    //       ),
    //     );
      case AppNameRoute.mySubscriptionScreen:
        return MaterialPageRoute(
          builder: (context) =>  Subscriptions(),
        );
    //   case AppNameRoute.tempSpalshScreen:
    //     return MaterialPageRoute(
    //       builder: (context) => TempSplashScreen(
    //         isVpn: argument!.arguments['isVpn'] ?? false,
    //       ),
    //     );
      case AppNameRoute.myStatisticsScreen:
        return MaterialPageRoute(
          builder: (context) =>  MyStatisticsView(),
        );
      case AppNameRoute.profileScreen:
        return MaterialPageRoute(
          builder: (context) =>  ProfileScreen(),
        );
      case AppNameRoute.profileEditScreen:
        return MaterialPageRoute(
          builder: (context) =>  EditView(),
        );

    //   case AppNameRoute.homeScreen:
    //     return MaterialPageRoute(
    //       builder: (context) => const HomeScreen(),
    //     );
    // // case Routes.testScreen:
    // //   var arg1 = argument!.arguments['arg1'] as String;
    // //   var arg2 = argument.arguments['arg2'] as arg2 Type;
    // //   return MaterialPageRoute(
    // //     builder: (context) => testScreen(arg1: arg1, arg2: arg2,),
    // //   );
      case AppNameRoute.errorScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: SafeArea(
                child: Center(child: Text('Route Error')),
              ),
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: SafeArea(
              child: Text('Route Error'),
            ),
          ),
        );
    }
  }
}