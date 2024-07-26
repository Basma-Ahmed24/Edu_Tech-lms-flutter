import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/extensions/navigation_extension.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/helpers/router/app_name_route.dart';

import 'package:lms_flutter/view/widgets/custom_btn.dart';
import 'package:lms_flutter/view/widgets/custom_text.dart';
import 'package:shimmer/shimmer.dart';
import 'package:slide_countdown/slide_countdown.dart';
import '../../../../helpers/constants/app_color_theme.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_sizes.dart';
import '../../../../helpers/utils/error_message_dialog.dart';
import '../../../../models/screen_argument.dart';
import '../../cources/widgets/shimmer_text_widget.dart';
import '../../home/widgets/app_bar.dart';
import '../exam_cubit/exam_cubit.dart';
import '../exam_cubit/models/start_exam_model.dart';

class ExamQuestionsView extends StatefulWidget {
  final int examId;
  final int courseId;

  const ExamQuestionsView({
    Key? key,
    required this.examId,
    required this.courseId,
  }) : super(key: key);

  @override
  State<ExamQuestionsView> createState() => _ExamQuestionsViewState();
}

class _ExamQuestionsViewState extends State<ExamQuestionsView> {
  @override
  void initState() {
    ExamCubit.get(context).getStartExam(
      context: context,
      examId: widget.examId.toString(),
      callback: callback,
      errorCallback: errorCallback,
    );
    ExamCubit.get(context).resetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          ErrorMessageDialog.show(
            context,
            'you_cant_go_out_before_finishing_the_exam'.tr(context),
            isOkDialog: true,
          );
          return false;
        },
        child: SizedBox(
          width: AppSize.width(context),
          height: AppSize.height(context),
          child: BlocBuilder<ExamCubit, ExamState>(
            builder: (context, state) {
              var cubit = ExamCubit.get(context);
              var question = Questions();
              List<StartExamModel> examData = [];
              List<Answers> answers = [];
              var currentQuestion = cubit.currentIndex;
              if (cubit.examData.isNotEmpty &&
                  currentQuestion <= cubit.examData[0].questions!.length) {
                examData = cubit.examData;
                question = cubit.examData[0].questions![currentQuestion];
                answers =
                    cubit.examData[0].questions![currentQuestion].answers!;
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.sp),
                    child: CustomTopQuestionContentWidget(
                      question: question,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: CustomChoseAnswer(
                        theAnswers: answers,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.sp, bottom: 45.sp),
                    child: CustomForwardAndBackbtns(examData: examData),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  callback() {}

  errorCallback() {
    AppNameRoute.courseContentScreen.goAndReplace(
      context,
      arguments: ScreenArgument(
        {
          'courseId': widget.courseId,
        },
      ),
    );
  }
}

class CustomTopQuestionContentWidget extends StatelessWidget {
  final Questions? question;

  const CustomTopQuestionContentWidget({
    super.key,
    this.question,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.width(context),
      height: AppSize.height(context) * .5,
      child: Stack(
        children: [
          Container(
            width: AppSize.width(context),
            height: AppSize.height(context) * .4,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
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
              title: "Exam_questions".tr(context),
            ),
          ),
          Positioned(
            top: AppSize.height(context) * .25,
            left: 0,
            right: 0,
            child: CustomQuestionContainer(
              question: question!.title,
            ),
          ),
          Positioned(
            left: AppSize.width(context) * .2,
            right: AppSize.width(context) * .2,
            top: AppSize.height(context) * .2,
            child: const CustomTimerContainer(),
          ),
        ],
      ),
    );
  }
}

class CustomTimerContainer extends StatefulWidget {
  const CustomTimerContainer({
    super.key,
  });

  @override
  State<CustomTimerContainer> createState() => _CustomTimerContainerState();
}

class _CustomTimerContainerState extends State<CustomTimerContainer> {
  bool isCloseFinish = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      height: AppSize.height(context) * .1,
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
      child: BlocBuilder<ExamCubit, ExamState>(
        builder: (context, state) {
          var cubit = ExamCubit.get(context);

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              cubit.isLoadingStartExam
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey.shade400,
                      highlightColor: Colors.grey.shade200,
                      child: ShimmerTextWidget(
                        width: AppSize.width(context) * .2,
                      ),
                    )
                  : Expanded(
                      child: CustomText(
                        text: "time_left".tr(context),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: isCloseFinish
                            ? Colors.red
                            : AppColorTheme.blackAndWhiteSwitchTheme(context),
                      ),
                    ),
              SizedBox(width: 10.sp),
              cubit.isLoadingStartExam
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey.shade400,
                      highlightColor: Colors.grey.shade200,
                      child: ShimmerTextWidget(
                        width: AppSize.width(context) * .2,
                      ),
                    )
                  : SlideCountdownSeparated(
                      duration:
                          Duration(seconds: cubit.examData[0].examTime! * 60),
                      showZeroValue: true,
                      curve: Curves.easeIn,
                      separator: ':',
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isCloseFinish
                            ? Colors.red
                            : AppColorTheme.blackAndWhiteSwitchTheme(context),
                      ),
                      separatorStyle: TextStyle(
                        color: AppColorTheme.blackAndWhiteSwitchTheme(context),
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      shouldShowDays: (p0) {
                        return false;
                      },
                      onDone: () {},
                      onChanged: (v) {
                        if (v.inSeconds == 10) {
                          setState(() {
                            isCloseFinish = true;
                          });
                        }
                        if (v.inSeconds == 0) {
                          cubit.submitExam(
                            examId: cubit.examData[0].id.toString(),
                            context: context,
                            callback: callback,
                            errorCallback: errorCallback,
                          );
                        }
                      },
                    ),
            ],
          );
        },
      ),
    );
  }

  callback() {
    Navigator.pop(context);
    AppNameRoute.examScoreScreen.goAndReplace(context);
  }

  errorCallback() {
    Navigator.pop(context);
  }
}

class CustomQuestionContainer extends StatelessWidget {
  final String? question;

  const CustomQuestionContainer({
    Key? key,
    this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      padding: const EdgeInsets.all(20),
      height: AppSize.height(context) * .25,
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
      child: SingleChildScrollView(
        child: BlocBuilder<ExamCubit, ExamState>(
          builder: (context, state) {
            var cubit = ExamCubit.get(context);
            int allQ = 0;
            if (cubit.examData.isNotEmpty) {
              allQ = cubit.examData[0].questions!.length;
            }
            var currentQuestion = cubit.currentIndex;
            return Column(
              children: [
                SizedBox(
                  height: AppSize.height(context) * .1 / 2,
                ),
                cubit.isLoadingStartExam
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey.shade400,
                        highlightColor: Colors.grey.shade200,
                        child: ShimmerTextWidget(
                          width: AppSize.width(context) * .35,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: '$allQ/',
                            fontSize: 16.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                          CustomText(
                            text: '${currentQuestion + 1}',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                          CustomText(
                            text: 'question'.tr(context),
                            fontSize: 16.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                SizedBox(height: 20.sp),
                cubit.isLoadingStartExam
                    ? Column(
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade400,
                            highlightColor: Colors.grey.shade200,
                            child: ShimmerTextWidget(
                              width: AppSize.width(context) * .5,
                            ),
                          ),
                          SizedBox(height: 10.sp),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade400,
                            highlightColor: Colors.grey.shade200,
                            child: ShimmerTextWidget(
                              width: AppSize.width(context) * .5,
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        width: AppSize.width(context) * .6,
                        child: CustomText(
                          text: question ?? "",
                          isMultiLines: true,
                          fontSize: 18.sp,
                          textAlign: TextAlign.center,
                        ),
                      )
              ],
            );
          },
        ),
      ),
    );
  }
}

class CustomChoseAnswer extends StatelessWidget {
  final List<Answers>? theAnswers;

  const CustomChoseAnswer({super.key, this.theAnswers});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamCubit, ExamState>(
      builder: (context, state) {
        var cubit = ExamCubit.get(context);
        return SizedBox(
          width: AppSize.width(context) * .75,
          child: cubit.isLoadingStartExam
              ? const ExamAnswersShimmerListView()
              : ListView.separated(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(height: 20.sp),
                  itemCount: theAnswers!.length,
                  itemBuilder: (context, index) {
                    var data = theAnswers![index];
                    //! this logic for get the user  answer
                    if (cubit.currentPressedIndex == -1) {
                      if (cubit.userAnswersList.isNotEmpty) {
                        if (cubit.userAnswersList.length - 1 >=
                            cubit.currentIndex) {
                          if (cubit.userAnswersList[cubit.currentIndex]
                                  .toString() ==
                              data.id.toString()) {
                            cubit.currentPressed(index);
                          }
                        }
                      }
                    }
                    return CustomChoseAnswerRowCard(
                      answer: data.title,
                      index: index,
                      answerId: data.id.toString(),
                    );
                  },
                ),
        );
      },
    );
  }
}

class CustomChoseAnswerRowCard extends StatelessWidget {
  final String? answer;
  final String? answerId;
  final int? index;

  const CustomChoseAnswerRowCard({
    Key? key,
    this.answer,
    this.index,
    this.answerId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamCubit, ExamState>(builder: (context, state) {
      var cubit = ExamCubit.get(context);
      return GestureDetector(
        onTap: () {
          //! update with the user answer
          if (cubit.userAnswersList.isEmpty) {
            cubit.userAnswersList.add(answerId.toString());
          } else if (cubit.userAnswersList.length - 1 >= cubit.currentIndex) {
            cubit.userAnswersList[cubit.currentIndex] = answerId.toString();
          } else {
            cubit.userAnswersList.add(answerId.toString());
          }
          //!get index
          cubit.currentPressed(index!);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: cubit.currentPressedIndex == index
                    ? Colors.lightBlue
                    : AppColorTheme.blackAndWhiteSwitchTheme(context),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: answer ?? "",
                fontSize: 14.sp,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class CheckCircleWidget extends StatelessWidget {
  final bool isTrue;
  final bool isNothing;

  const CheckCircleWidget({
    Key? key,
    this.isTrue = false,
    this.isNothing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColorTheme.blackAndWhiteSwitchTheme(context),
        ),
        color: isNothing
            ? Colors.white
            : isTrue
                ? Colors.green
                : Colors.red,
        shape: BoxShape.circle,
      ),
      child: Icon(
        isTrue ? Icons.check : Icons.close,
        color: isNothing ? Colors.transparent : Colors.white,
        size: 16.sp,
      ),
    );
  }
}

class CustomForwardAndBackbtns extends StatefulWidget {
  final List<StartExamModel> examData;

  const CustomForwardAndBackbtns({super.key, required this.examData});

  @override
  State<CustomForwardAndBackbtns> createState() =>
      _CustomForwardAndBackbtnsState();
}

class _CustomForwardAndBackbtnsState extends State<CustomForwardAndBackbtns> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.width(context) * .75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomBtn(
              title: 'next_question'.tr(context),
              height: 35.sp,
              onTap: () {
                ExamCubit.get(context).nextQuestionFunction(
                  context: context,
                  callback: callback,
                  errorCallback: errorCallback,
                  theExamData: widget.examData,
                );
                // ExamCubit.get(context).controller(callback);
                // AppNameRoute.examScoreScreen.go(context);
              },
            ),
          ),
          SizedBox(width: 22.sp),
          Expanded(
            child: CustomBtn(
              title: 'previous_question'.tr(context),
              height: 35.sp,
              borderColor: AppColorTheme.mainColorAndWhiteTextTheme(context),
              btnColor: Colors.transparent,
              textColor: AppColorTheme.mainColorAndWhiteTextTheme(context),
              onTap: () {
                ExamCubit.get(context).previousQuestionFunction();
              },
            ),
          ),
        ],
      ),
    );
  }

  callback() {
    Navigator.pop(context);
    AppNameRoute.examScoreScreen.goAndReplace(context);
  }

  errorCallback() {
    Navigator.pop(context);
  }
}

class ExamAnswersShimmerListView extends StatelessWidget {
  final int? itemCount;

  const ExamAnswersShimmerListView({
    super.key,
    this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      separatorBuilder: (context, index) => SizedBox(height: 12.sp),
      itemCount: itemCount ?? 4,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return const ShimmerExamAnswerItem();
        //const ShimmerTeacherSmallCardWidget();
      },
    );
  }
}

class ShimmerExamAnswerItem extends StatelessWidget {
  const ShimmerExamAnswerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade200,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerTextWidget(
              width: AppSize.width(context) * .4,
              height: 5.sp,
            ),
            SizedBox(height: 8.sp),
            ShimmerTextWidget(
              width: AppSize.width(context) * .3,
              height: 5.sp,
            ),
          ],
        ),
      ),
    );
  }
}
