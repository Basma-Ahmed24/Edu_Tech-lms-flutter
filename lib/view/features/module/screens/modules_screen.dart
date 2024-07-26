import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/features/cources/widgets/custom_file_content.dart';
import 'package:lms_flutter/view/features/module/cubit/cubit.dart';
import 'package:lms_flutter/view/widgets/custom_text.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_sizes.dart';
import '../../cources/widgets/course_content_button.dart';
import '../../cources/widgets/show_exam_alert_dialog.dart';
import '../../home_work_questions_score_view/screens/home_work_questions_view.dart';
import '../cubit/state.dart';

class ModuleContent extends StatefulWidget {
  int? id;
  String issubmit = "false";
  dynamic draft;
  ModuleContent(int id, String issubmit, dynamic draft) {
    this.id = id;
    this.issubmit = issubmit;
    this.draft = draft;
  }

  @override
  State<ModuleContent> createState() => _ModuleContentState(id!);
}

class _ModuleContentState extends State<ModuleContent> {
  @override
  int? id;
  _ModuleContentState(int id) {
    this.id = id;
  }

  int _selectedContainerIndex = 0;
  dynamic exams, moduleContent;
  dynamic lessons, homework;
  dynamic files;
  bool openexam = false;
  @override
  String isdraft = "false";
  void initState() {
    ModuleCubit.get(context).getModuleInfo(context: context, id: id!);
    ModuleCubit.get(context).getExams(context: context, id: id!);
    ModuleCubit.get(context).getHomework(context: context, id: id!);
  }

  Widget build(BuildContext context) {
    print(widget.draft);
    if (widget.draft != null) {
      for (int i = 0; i < widget.draft.length; i++) {
        if (widget.draft[i] == widget.id.toString())
          isdraft = widget.draft[i + 1];
      }
    }
    return BlocBuilder<ModuleCubit, ModuleState>(builder: (context, state) {
      moduleContent = ModuleCubit.get(context).moduleDetails;
      lessons = ModuleCubit.get(context).lessons;
      exams = ModuleCubit.get(context).exams;
      homework = ModuleCubit.get(context).homeworkInfo;

      if (state is ModuleLoadingState)
        return Scaffold(
            body: Center(
                child: CircularProgressIndicator(
          color: AppColors.mainAppColor,
        )));
      else
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
              child: SizedBox(
            width: AppSize.width(context),
            height: AppSize.height(context),
            child: SingleChildScrollView(
                child: Column(children: [
              Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(children: [
                          CustomText(
                            text: "module".tr(context),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          CustomText(text: moduleContent["name"]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: moduleContent["overview"],
                                fontSize: 14,
                              ),
                            ],
                          ),
                          Row(children: [
                            CustomText(
                              text: "${"price".tr(context)}: ",
                              fontSize: 14.sp,
                            ),
                            CustomText(text: moduleContent["price"]),
                            CustomText(
                              text: " ${"pound".tr(context)}",
                              fontSize: 14.sp,
                            ),
                          ]),
                          Column(children: [
                            Divider(),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CourseContentButton(
                                      selectedContainerIndex:
                                          _selectedContainerIndex,
                                      title: "lessons".tr(context),
                                      context: context,
                                      function: changeIndex0,
                                      value: 0,
                                      height: 30,
                                      width: 4.5),
                                  CourseContentButton(
                                      selectedContainerIndex:
                                          _selectedContainerIndex,
                                      title: "exam".tr(context),
                                      context: context,
                                      function: changeIndex1,
                                      value: 1,
                                      height: 30,
                                      width: 4.5),
                                  CourseContentButton(
                                      selectedContainerIndex:
                                          _selectedContainerIndex,
                                      title: "homework".tr(context),
                                      context: context,
                                      function: changeIndex2,
                                      value: 2,
                                      height: 30,
                                      width: 4.5),
                                  CourseContentButton(
                                      selectedContainerIndex:
                                          _selectedContainerIndex,
                                      title: "files".tr(context),
                                      context: context,
                                      function: changeIndex3,
                                      value: 3,
                                      height: 30,
                                      width: 4.5),
                                ]),
                            _selectedContainerIndex == 1 && exams != null
                                ? Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),topLeft: Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10.sp,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Container(
                                                    height: 35,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: AppColors.subMainAppColor,
                                                    ),
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.task,
                                                      color: AppColors
                                                          .mainAppColor,
                                                    )),
                                                  ),
                                                ),
                                                CustomText(
                                                    text: exams["title"]),
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (exams["examAnswer"] == null)
                                                  showExamAlertDialog(
                                                      examid: exams["id"],
                                                      courseid: widget.id!,
                                                      context: context);
                                              },
                                              child: CustomText(
                                                text: exams["examAnswer"] !=
                                                        null
                                                    ? exams["examAnswer"]
                                                                ["grade"] ==
                                                            null
                                                        ? "0/"
                                                            "${exams["grade"]}"
                                                        : exams["examAnswer"]
                                                                    ["grade"] !=
                                                                0
                                                            ? "${exams["examAnswer"]["grade"]}/"
                                                                "${exams["grade"]}"
                                                            : "open_exam"
                                                                .tr(context)
                                                    : "open_exam".tr(context),
                                                fontSize: 14.sp,
                                                color: exams["examAnswer"] !=
                                                        null
                                                    ? exams["examAnswer"]
                                                                    ["grade"] ==
                                                                null ||
                                                            exams["examAnswer"]
                                                                    ["grade"] <
                                                                exams["grade"] /
                                                                    2
                                                        ? Colors.red
                                                        : exams["examAnswer"]
                                                                    ["grade"] >
                                                                exams["grade"] /
                                                                    2
                                                            ? Colors.green
                                                            : AppColors
                                                                .mainAppColor
                                                    : AppColors.mainAppColor,
                                                isUserLine: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : _selectedContainerIndex == 1 && exams == null
                                    ? Column(children: [
                                        // Image.asset("assets/images/no_cources.png"),
                                        SizedBox(height: 10.sp),
                                        CustomText(
                                          text: "no-exams".tr(context),
                                          fontSize: 16.sp,
                                        ),
                                      ])
                                    : _selectedContainerIndex == 2 &&
                                            homework != null
                                        ? Card(
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.only(bottomRight: Radius.circular(20),topLeft: Radius.circular(20)),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 10.sp,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Container(
                                                            height: 40,
                                                            width: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: AppColors.subMainAppColor,
                                                            ),
                                                            child: Center(
                                                                child: Icon(
                                                              Icons.task,
                                                              color: AppColors
                                                                  .mainAppColor,
                                                            )),
                                                          ),
                                                        ),
                                                        CustomText(
                                                            text: homework[
                                                                "title"]),
                                                      ],
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        if (ModuleCubit.get(
                                                                        context)
                                                                    .homework ==
                                                                "available" ||
                                                            isdraft == "true") {
                                                          if (widget.issubmit ==
                                                              "false") {
                                                            Navigator
                                                                .pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            HomeWorkQuestionsView(
                                                                              lessonId: homework["id"]!,
                                                                            )));
                                                          }
                                                        }
                                                      },
                                                      child: Center(
                                                        child: CustomText(
                                                          isUserLine: true,
                                                          text: ModuleCubit.get(
                                                                              context)
                                                                          .homework ==
                                                                      "available" &&
                                                                  isdraft ==
                                                                      "false"
                                                              ? "go_to_homework"
                                                                  .tr(context)
                                                              : widget.issubmit ==
                                                                          "true" &&
                                                                      ModuleCubit.get(context)
                                                                              .homework ==
                                                                          "available"
                                                                  ? "you_submitted"
                                                                      .tr(
                                                                          context)
                                                                  : isdraft ==
                                                                              "true" &&
                                                                          ModuleCubit.get(context).homework ==
                                                                              "available"
                                                                      ? "continue_homework".tr(
                                                                          context)
                                                                      : "homework_finished"
                                                                          .tr(context),
                                                          color: ModuleCubit.get(
                                                                              context)
                                                                          .homework ==
                                                                      "available" &&
                                                                  isdraft ==
                                                                      "false"
                                                              ? AppColors
                                                                  .mainAppColor
                                                              : widget.issubmit ==
                                                                          "true" &&
                                                                      ModuleCubit.get(context)
                                                                              .homework ==
                                                                          "available"
                                                                  ? Colors.grey
                                                                  : isdraft ==
                                                                              "true" &&
                                                                          ModuleCubit.get(context).homework ==
                                                                              "available"
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .grey,
                                                          fontSize: 15.sp,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        : _selectedContainerIndex == 2 &&
                                                homework == null
                                            ? CustomText(
                                                text: "no_homework".tr(context),
                                                fontSize: 16.sp,
                                              )
                                            : _selectedContainerIndex == 3 &&
                                                    files != null
                                                ? ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount: files.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return CustomFileHomeWork(
                                                          fileNumber:
                                                              "${"file_num".tr(context)} ${index + 1}",
                                                          name: files[index]
                                                              ["name"],
                                                          file_url: files[index]
                                                              ["url"],
                                                          context: context,
                                                          index: index + 1);
                                                    },
                                                  )
                                                : _selectedContainerIndex ==
                                                            3 &&
                                                        files == null
                                                    ? Column(children: [
                                                        //  Image.asset("assets/images/no_cources.png"),
                                                        SizedBox(height: 10.sp),
                                                        CustomText(
                                                          text: "no-files"
                                                              .tr(context),
                                                          fontSize: 16.sp,
                                                        ),
                                                      ])
                                                    : _selectedContainerIndex ==
                                                                0 &&
                                                            lessons != null
                                                        ? ListView.builder(
                                                            shrinkWrap: true,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            itemCount:
                                                                lessons.length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return CustomLesson(
                                                                  url: moduleContent[
                                                                      "lesson_api_link"],
                                                                  title: lessons[
                                                                          index]
                                                                      ["name"],
                                                                  overview: lessons[
                                                                          index]
                                                                      [
                                                                      "duration"],

                                                                  // duration:
                                                                  //     "(00.00/${lessons[index]["duration"]})",
                                                                  num1:
                                                                      "${index + 1}",
                                                                  index: lessons[
                                                                          index]
                                                                      ["id"],
                                                                  context:
                                                                      context,
                                                                  purched:
                                                                      true);
                                                            },
                                                          )
                                                        : Column(children: [
                                                            //Image.asset("assets/images/no_cources.png"),
                                                            SizedBox(
                                                                height: 10.sp),
                                                            CustomText(
                                                              text: "no-lessons"
                                                                  .tr(context),
                                                              fontSize: 16.sp,
                                                            ),
                                                          ])
                          ])
                        ])
                      ]))
            ])),
          )),
        );
    });
  }

  void changeIndex0() {
    setState(() {
      _selectedContainerIndex = 0;
    });
  }

  void changeIndex1() {
    setState(() {
      _selectedContainerIndex = 1;
    });
  }

  void changeIndex2() {
    setState(() {
      _selectedContainerIndex = 2;
    });
  }

  Future<void> changeIndex3() async {
    ModuleCubit.get(context).getFiles(context: context, id: id!);
    files = ModuleCubit.get(context).files;
    setState(() {
      _selectedContainerIndex = 3;
    });
  }
}
