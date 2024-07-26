import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/extensions/navigation_extension.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/features/cources/screens/cource_content_screen.dart';
import 'package:lms_flutter/view/features/home/screens/home_screen.dart';
import 'package:lms_flutter/view/features/navigation_bar/navigation_bar_screen.dart';
import '../../../../helpers/constants/app_color_theme.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_sizes.dart';
import '../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import '../../../../helpers/router/app_name_route.dart';
import '../../../../models/screen_argument.dart';
import '../../../widgets/custom_btn.dart';
import '../../../widgets/custom_bullet.dart';
import '../../../widgets/custom_text.dart';
import '../../home/widgets/app_bar.dart';
import '../exam_cubit/exam_cubit.dart';

class ExamScoreView extends StatelessWidget {
  const ExamScoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SizedBox(
          width: AppSize.width(context),
          height: AppSize.height(context),
          child:
          BlocBuilder<ExamCubit, ExamState>(
            builder: (context, state) {
              var cubit = ExamCubit.get(context);
              var data = cubit.submitExamDta;
              return
                Column(
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
                            color:
                          data.grade! < (data.exam!.grade! / 2)
                                ? Colors.red
                                : Theme.of(context).primaryColor,
                           mainGrade:
   '${data.exam!.grade}'
             ,userGrade:
    data.grade.toString(),
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
                                      score:
    '${data.status}',
                                      color:Colors.red
                                          // data.grade! < (data.exam!.grade! / 2)
                                          //     ? Colors.red
                                          //     : Theme.of(context).primaryColor,
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
                                          score:
                                          data.exam!.questions!.length
                                              .toString(),
                                          color: AppColors.yellow,
                                        ),
                                        SizedBox(height: 10.sp),
                                        CustomScoreText(
                                          title: 'mistake'.tr(context),
                                          score:
                                              '${data.exam!.questions!.length - data.numberOfRightAnswers!}',
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
                                                  data.exam!.questions!.length
                                              ? '100%'
                                              : '${' ${((data.numberOfRightAnswers! / data.exam!.questions!.length) * 100)}'.split('.').first}%',
                                          color: data.status == 'Success'
                                              ? data.grade! >
                                                      (data.exam!.grade! / 5 +
                                                          data.exam!.grade! / 2)
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
                    title: "go_to_courses".tr(context),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>CourseContent(SaveItCubit.get(context).getInt("course_id"))),
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
