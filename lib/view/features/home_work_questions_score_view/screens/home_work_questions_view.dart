// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/extensions/navigation_extension.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:shimmer/shimmer.dart';

import 'package:lms_flutter/helpers/router/app_name_route.dart';
import 'package:lms_flutter/view/widgets/custom_btn.dart';
import 'package:lms_flutter/view/widgets/custom_text.dart';

import '../../../../helpers/constants/app_color_theme.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_sizes.dart';
import '../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import '../../cources/widgets/shimmer_text_widget.dart';
import '../../home/widgets/app_bar.dart';
import '../homework_cubit/homework_cubit.dart';
import '../homework_cubit/models/homework_model.dart';

class HomeWorkQuestionsView extends StatefulWidget {
  final int lessonId;

  const HomeWorkQuestionsView({
    Key? key,
    required this.lessonId,
  }) : super(key: key);

  @override
  State<HomeWorkQuestionsView> createState() => _HomeWorkQuestionsViewState();
}

class _HomeWorkQuestionsViewState extends State<HomeWorkQuestionsView> {
  @override
  List<String>draftt=[];
  void initState() {
    HomeworkCubit.get(context).getStartHomework(
      context: context,
      lessonId: widget.lessonId.toString(),
      callback: callback,
      errorCallback: errorCallback,
    );
    HomeworkCubit.get(context).resetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          //! to submit to the daft
          HomeworkCubit.get(context).submitHomework(
              context: context,
              callback: callback,
              errorCallback: errorCallback,
              isDraft: 1,
              submissionId: HomeworkCubit.get(context)
                  .homeWorkData
                  .data!
                  .submissionId
                  .toString(),
              homeworkId: HomeworkCubit.get(context)
                  .homeWorkData
                  .data!
                  .homeWork!.id!.toInt(),
              onWillPop: () {
                Navigator.pop(context);
              });
          return true;
        },
        child: SizedBox(
          width: AppSize.width(context),
          height: AppSize.height(context),
          child: BlocBuilder<HomeworkCubit, HomeworkState>(
            builder: (context, state) {
              var cubit = HomeworkCubit.get(context);
              var question = HomeworkQuestions();
              HomeworkModel homeWorkData = HomeworkModel();
              List<HomeworkAnswers> answers = [];
              List<String> drafts = [];

              var currentQuestion = cubit.currentIndex;
              if (cubit.homeWorkData.data != null &&
                  currentQuestion <=
                      cubit.homeWorkData.data!.homeWork!.questions!.length) {
                homeWorkData = cubit.homeWorkData;
                question = cubit
                    .homeWorkData.data!.homeWork!.questions![currentQuestion];
                answers = cubit.homeWorkData.data!.homeWork!
                    .questions![currentQuestion].answers!;
                drafts = cubit.homeWorkData.data!.drafts ?? [];
                print(cubit.homeWorkData.data!.homeWork!.lessonId.toString());
                draftt.add(cubit.homeWorkData.data!.homeWork!.lessonId.toString());
                draftt.add("true");
                SaveItCubit.get(context).saveList("draft", draftt);

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
                        drafts: drafts,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.sp, bottom: 45.sp),
                    child: CustomForwardAndBackbtns(
                      homeWorkData: homeWorkData,
                    ),
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
    Navigator.pop(context);
    // AppNameRoute.courseContentScreen.goAndReplace(
    //   context,
    //   arguments: ScreenArgument(
    //     {
    //       'courseId': widget.courseId,
    //     },
    //   ),
    // );
  }
}

class CustomTopQuestionContentWidget extends StatelessWidget {
  final HomeworkQuestions? question;

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
              title: "homework_questions".tr(context),
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
            child: Container(),
          ),
        ],
      ),
    );
  }
}

// class CustomTimerContainer extends StatefulWidget {
//   const CustomTimerContainer({
//     super.key,
//   });

//   @override
//   State<CustomTimerContainer> createState() => _CustomTimerContainerState();
// }

// class _CustomTimerContainerState extends State<CustomTimerContainer> {
//   bool isCloseFinish = false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       padding: const EdgeInsets.all(10),
//       height: AppSize.height(context) * .1,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         color: AppColorTheme.scaffoldTheme(context),
//         boxShadow: [
//           BoxShadow(
//             color: AppColorTheme.shadowTheme(context),
//             spreadRadius: 1,
//             blurRadius: 5,
//           )
//         ],
//       ),
//       child: BlocBuilder<ExamCubit, ExamState>(
//         builder: (context, state) {
//           var cubit = ExamCubit.get(context);

//           return Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               cubit.isLoadingStartExam
//                   ? Shimmer.fromColors(
//                       baseColor: Colors.grey.shade400,
//                       highlightColor: Colors.grey.shade200,
//                       child: ShimmerTextWidget(
//                         width: AppSize.width(context) * .2,
//                       ),
//                     )
//                   : Expanded(
//                       child: CustomText(
//                         text: "time_left".tr(context),
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.bold,
//                         color: isCloseFinish
//                             ? Colors.red
//                             : AppColorTheme.blackAndWhiteSwitchTheme(context),
//                       ),
//                     ),
//               SizedBox(width: 10.sp),
//               cubit.isLoadingStartExam
//                   ? Shimmer.fromColors(
//                       baseColor: Colors.grey.shade400,
//                       highlightColor: Colors.grey.shade200,
//                       child: ShimmerTextWidget(
//                         width: AppSize.width(context) * .2,
//                       ),
//                     )
//                   : SlideCountdownSeparated(
//                       duration:
//                           Duration(seconds: cubit.examData[0].examTime! * 60),
//                       showZeroValue: true,
//                       curve: Curves.easeIn,
//                       separator: ':',
//                       textStyle: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: isCloseFinish
//                             ? Colors.red
//                             : AppColorTheme.blackAndWhiteSwitchTheme(context),
//                       ),
//                       separatorStyle: TextStyle(
//                         color: AppColorTheme.blackAndWhiteSwitchTheme(context),
//                         fontWeight: FontWeight.bold,
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       shouldShowDays: (p0) {
//                         return false;
//                       },
//                       onDone: () {},
//                       onChanged: (v) {
//                         if (v.inSeconds == 10) {
//                           setState(() {
//                             isCloseFinish = true;
//                           });
//                         }
//                         if (v.inSeconds == 0) {
//                           cubit.submitExam(
//                             examId: cubit.examData[0].id.toString(),
//                             context: context,
//                             callback: callback,
//                             errorCallback: errorCallback,
//                           );
//                         }
//                       },
//                     ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   callback() {
//     Navigator.pop(context);
//     AppNameRoute.examScoreScreen.goAndReplace(context);
//   }

//   errorCallback() {
//     Navigator.pop(context);
//   }
// }

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
        child: BlocBuilder<HomeworkCubit, HomeworkState>(
          builder: (context, state) {
            var cubit = HomeworkCubit.get(context);
            int allQ = 0;
            if (cubit.homeWorkData.data != null) {
              allQ = cubit.homeWorkData.data!.homeWork!.questions!.length;
            }
            var currentQuestion = cubit.currentIndex;
            return Column(
              children: [
                SizedBox(
                  height: AppSize.height(context) * .1 / 2,
                ),
                cubit.isLoadingHomeworkStart
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
                cubit.isLoadingHomeworkStart
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
  final List<HomeworkAnswers>? theAnswers;
  final List<String>? drafts;

  const CustomChoseAnswer({
    Key? key,
    this.theAnswers,
    this.drafts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeworkCubit, HomeworkState>(
      builder: (context, state) {
        var cubit = HomeworkCubit.get(context);
        return SizedBox(
          width: AppSize.width(context) * .75,
          child: cubit.isLoadingHomeworkStart
              ? const ExamAnswersShimmerListView()
              : ListView.separated(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => SizedBox(height: 20.sp),
            itemCount: theAnswers!.length,
            itemBuilder: (context, index) {
              var data = theAnswers![index];

              //! this logic for get the user draft answer (defualt)
              if (cubit.currentPressedIndex == -1) {
                if (drafts != null) {
                  if (cubit.drafList.length - 1 >= cubit.currentIndex) {
                    if (cubit.drafList[cubit.currentIndex].toString() ==
                        data.id.toString()) {
                      cubit.currentPressed(index: index);
                    }
                  }
                }
              }

              return CustomChoseAnswerRowCard(
                answer: data.title,
                answerId: data.id.toString(),
                index: index,
                drafs: drafts ?? [],
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
  final List<String> drafs;
  final int? index;

  const CustomChoseAnswerRowCard({
    Key? key,
    this.answer,
    this.answerId,
    this.index,
    required this.drafs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeworkCubit, HomeworkState>(builder: (context, state) {
      var cubit = HomeworkCubit.get(context);
      return GestureDetector(
        onTap: () {
          //! update with the user answer
          if (cubit.drafList.isEmpty) {
            cubit.drafList.add(answerId.toString());
          } else if (cubit.drafList.length - 1 >= cubit.currentIndex) {
            cubit.drafList[cubit.currentIndex] = answerId.toString();
          } else {
            cubit.drafList.add(answerId.toString());
          }

          //!get index
          cubit.currentPressed(index: index!);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: cubit.currentPressedIndex == index
                    ? Colors.lightBlue
                    : cubit.currentPressedIndex == -1 &&
                    drafs.length - 1 >= cubit.currentIndex &&
                    drafs[cubit.currentIndex].toString() == answerId
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
  final HomeworkModel homeWorkData;

  const CustomForwardAndBackbtns({
    super.key,
    required this.homeWorkData,
  });

  @override
  State<CustomForwardAndBackbtns> createState() =>
      _CustomForwardAndBackbtnsState();
}

class _CustomForwardAndBackbtnsState extends State<CustomForwardAndBackbtns> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.width(context) * .75,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomBtn(
                  title: 'next_question'.tr(context),
                  height: 35.sp,
                  onTap: () {
                    HomeworkCubit.get(context).nextQuestionFunction(
                      context: context,
                      callback: callback,
                      errorCallback: errorCallback,
                      theHomeworkData: widget.homeWorkData,
                    );
                  },
                ),
              ),
              SizedBox(width: 22.sp),
              Expanded(
                child: CustomBtn(
                  title: 'previous_question'.tr(context),
                  height: 35.sp,
                  borderColor:
                  AppColorTheme.mainColorAndWhiteTextTheme(context),
                  btnColor: Colors.transparent,
                  textColor: AppColorTheme.mainColorAndWhiteTextTheme(context),
                  onTap: () {
                    HomeworkCubit.get(context).previousQuestionFunction();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  callback() {
    Navigator.pop(context);
    AppNameRoute.homeWorkScoreScreen.goAndReplace(
      context,
    );
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
