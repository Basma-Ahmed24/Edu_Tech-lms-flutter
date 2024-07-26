import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/features/lessons/screens/lesson_screen.dart';
import 'package:lms_flutter/view/widgets/custom_btn.dart';
import 'package:lms_flutter/view/widgets/custom_bullet.dart';
import '../../../../helpers/constants/app_color_theme.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_sizes.dart';
import '../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import '../../../widgets/custom_text.dart';
import '../../cources/screens/cource_content_screen.dart';
import '../../home/widgets/app_bar.dart';
import '../../module/screens/modules_screen.dart';
import '../homework_cubit/homework_cubit.dart';

class HomeWorkScoreView extends StatelessWidget {
   HomeWorkScoreView({
    Key? key,
  }) : super(key: key);

  @override
  List<String> submit=[];

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SizedBox(
          width: AppSize.width(context),
          height: AppSize.height(context),
          child: BlocBuilder<HomeworkCubit, HomeworkState>(
            builder: (context, state) {
              var cubit = HomeworkCubit.get(context);

              var data = cubit.submitHomeworkModel.data!;

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: AppSize.width(context),
                    height: AppSize.height(context) * .64,
                    child: Stack(
                      children: [
                        Container(
                          width: AppSize.width(context),
                          height: AppSize.height(context) * .55,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              stops: const [
                                0.1,
                                0.4,
                                0.6,
                                0.9,
                              ],
                              colors: [
                                AppColors.darkMainAppColor,
                                AppColors.darkMainAppColor.withOpacity(1),
                                AppColors.darkMainAppColor.withOpacity(0.8),
                                AppColors.darkMainAppColor.withOpacity(0.5),
                              ],
                            ),
                          ),
                        ),
                        SafeArea(
                          child: CustomAppBar(
                            isNotLeading: true,
                            isWhite: true,
                            isText: true,
                            title: "exam_grade".tr(context),
                          ),
                        ),
                        Positioned(
                          top: AppSize.height(context) * .5 / 3,
                          right: 0,
                          left: 0,
                          child: CustomScoreContainer(
                            color: data.userGrade! < (data.homeWork!.grade! / 2)
                                ? Colors.red
                                : Theme.of(context).primaryColor,
                            mainGrade: '${data.homeWork!.grade}',
                            userGrade: data.userGrade.toString(),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            margin: const EdgeInsets.only(left: 40, right: 40),
                            padding: const EdgeInsets.all(20),
                            width: AppSize.width(context),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColorTheme.scaffoldTheme(context),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColorTheme.shadowTheme(context),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomScoreText(
                                      title: "Status",
                                      score: '${data.status}',
                                      color: data.homeWork!.grade! <
                                              (data.homeWork!.grade! / 2)
                                          ? Colors.red
                                          : Theme.of(context).primaryColor,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.sp),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomScoreText(
                                          title: "all_questions".tr(context),
                                          score: data
                                              .homeWork!.questions!.length
                                              .toString(),
                                          color: AppColors.yellow,
                                        ),
                                        SizedBox(height: 10.sp),
                                        CustomScoreText(
                                          title: 'mistake'.tr(context),
                                          score:
                                              '${data.homeWork!.questions!.length - data.numberOfRightAnswers!}',
                                          color: AppColors.red,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomScoreText(
                                          title: "exam_solution".tr(context),
                                          score: data.numberOfRightAnswers! ==
                                                  data.homeWork!.questions!
                                                      .length
                                              ? '100%'
                                              : '${' ${((data.numberOfRightAnswers! / data.homeWork!.questions!.length) * 100)}'.split('.').first}%',
                                          color: data.status == 'Success'
                                              ? data.userGrade! >
                                                      (data.homeWork!.grade! /
                                                              5 +
                                                          data.homeWork!
                                                                  .grade! /
                                                              2)
                                                  ? Colors.green
                                                  : Colors.amber
                                              : Colors.red,
                                        ),
                                        SizedBox(height: 10.sp),
                                        CustomScoreText(
                                          title: 'correct'.tr(context),
                                          score: data.numberOfRightAnswers!
                                              .toString(),
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomBtn(
                    height: 35.sp,
                    width: AppSize.width(context) * .7,
                    fontSize: 14.sp,
                    title: "back_to_lesson".tr(context),
                    onTap: () {
                     //int submit=1;
                      submit.add(data.homeWork!.lessonId.toString());
                      submit.add("true");

                      print(submit);


                      SaveItCubit.get(context).saveList("is_submitted", submit);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ModuleContent(data.homeWork!.lessonId!,"true",SaveItCubit.get(context).getList("draft"))
                        ),
                     );
                    },
                  ),
                  Container()
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class CustomScoreContainer extends StatelessWidget {
  final String mainGrade;
  final String userGrade;
  final Color color;

  const CustomScoreContainer({
    Key? key,
    required this.mainGrade,
    required this.userGrade,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColorTheme.shadowTheme(context),
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ]),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                text: 'your_grade'.tr(context),
                fontSize: 14.sp,
                color: Theme.of(context).primaryColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: mainGrade,
                    fontSize: 16.sp,
                    color: Theme.of(context).primaryColor,
                  ),
                  CustomText(
                    text: '/$userGrade',
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomScoreText extends StatelessWidget {
  final String title;
  final String score;
  final Color color;

  const CustomScoreText({
    Key? key,
    required this.title,
    required this.score,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyBullet(
          circleSized: 7.sp,
          fontSize: 16.sp,
          widthBetween: 5.sp,
          text: score,
          color: color,
        ),
        CustomText(
          text: title,
          fontSize: 12.sp,
        ),
      ],
    );
  }
}
