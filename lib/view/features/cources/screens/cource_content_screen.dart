import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/features/cources/widgets/custom_file_content.dart';
import 'package:lms_flutter/view/widgets/custom_text.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_sizes.dart';
import '../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import '../../home/widgets/payment_dialog.dart';
import '../../statistics/widgets/card_content.dart';
import '../logic/cubit/cources_cubit.dart';
import '../logic/cubit/cources_state.dart';
import '../widgets/course_content_button.dart';
import '../widgets/course_details.dart';
import '../widgets/shimme_course_content.dart';

class CourseContent extends StatefulWidget {
  int? id;
  CourseContent(int id) {
    this.id = id;
  }

  @override
  State<CourseContent> createState() => _CourseContentState(id!);
}

class _CourseContentState extends State<CourseContent> {
  @override
  int? id;
  _CourseContentState(int id) {
    this.id = id;
  }

  int _selectedContainerIndex = 0;
  dynamic exams;
  dynamic homework;
  dynamic lessons;
  dynamic files;
  dynamic courseContent;
  bool? purched;
  @override
  void initState() {
    List<String>? subscribeList = SaveItCubit.get(context)
        .sharedPreferences
        .getStringList("subscribeCourse");
    CourcesCubit.get(context).checkCourse(context, widget.id!, subscribeList);
    super.initState();
  }

  Widget build(BuildContext context) {
    return BlocBuilder<CourcesCubit, CourcesState>(builder: (context, state) {
      purched = CourcesCubit.get(context).isPurched;
      lessons = CourcesCubit.get(context).lessons;
      if (lessons.length == 0) {
        lessons = null;
      }
      courseContent = CourcesCubit.get(context).courseDetails;
      if (purched != false && CourcesCubit.get(context).exams.length != 0) {
        exams = CourcesCubit.get(context).exams;
        if (exams.length == 0) {
          exams = null;
        }
      }
      if (state is CourcesLoadingState)
        return Scaffold(body: Padding(
            padding: EdgeInsets.all(15), child: ShimmerCourseContent()));
      else
        return Scaffold(
          bottomSheet:purched==false? InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return PaymentDialog();
                  });
            },
            child: Padding(padding: EdgeInsets.all(15),
              child: Container(
                height: 60,
                width: AppSize.width(context) ,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.mainAppColor,
                    width: 1,
                  ),
                  image:   DecorationImage(
                    image: AssetImage("assets/images/WhatsApp Image 2023-11-03 at 22.29.27_23a73831.jpg"),
                    fit: BoxFit.fill, // Set the BoxFit.fill property
                  ),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
                  color: AppColors.mainAppColor,
                ),
                child: Center(
                  child: CustomText(
                    text: "buy_course".tr(context),
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight:FontWeight.w600 ,
                  ),
                ),
              ),
            ),
          ):SizedBox(),
          resizeToAvoidBottomInset: false,
          body: SizedBox(
            width: AppSize.width(context),
            height: AppSize.height(context),
            child: SingleChildScrollView(
            child: Column(children: [
          Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CourseContentDetails(
                        context: context,
                        name: courseContent["name"],
                        modulesCount: "${courseContent["modulesCount"]}",

                        time: courseContent["duration"],
                        description: courseContent["description"],
                        img: courseContent["image"]),
                   purched == false
                        ?  Padding(
                       padding: EdgeInsets.only(left: 15, right: 15),
                          child: Column(children: [


                              Divider(),
                              Container(
                                height: 40,
                                width: AppSize.width(context) / 1.1,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.mainAppColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  color: _selectedContainerIndex == 0
                                      ? Colors.white
                                      : AppColors.mainAppColor,
                                ),
                                child: Center(
                                  child: CustomText(
                                    text: "modules".tr(context),
                                    color: _selectedContainerIndex == 0
                                        ? AppColors.mainAppColor
                                        : Colors.white,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                              _selectedContainerIndex == 0 && lessons != null
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: lessons.length,
                                      itemBuilder: (context, index) {
                                        return CustomModule(
                                            title: lessons[index]["name"],
                                            overview: lessons[index]
                                                ["overview"],

                                            num1: "${index + 1}",
                                            index: lessons[index]["id"],
                                            context: context,
                                            purched: purched);
                                      },
                                    )
                                  : Column(children: [
                                      SizedBox(height: 10.sp),
                                      CustomText(
                                        text: "no-lessons".tr(context),
                                        fontSize: 16.sp,
                                      ),
                                    ])
                            ]),
                        )
                        : Padding(
                     padding: const EdgeInsets.only(left: 15, right: 15),
                     child: Column(children: [
                              Divider(),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CourseContentButton(
                                        selectedContainerIndex:
                                            _selectedContainerIndex,
                                        title: "modules".tr(context),
                                        context: context,
                                        function: changeIndex0,
                                        value: 0,
                                    height: 40,width: 3.5),
                                    CourseContentButton(
                                        selectedContainerIndex:
                                            _selectedContainerIndex,
                                        title: "exams".tr(context),
                                        context: context,
                                        function: changeIndex1,
                                        value: 1,height: 40,width: 3.5),
                                    CourseContentButton(
                                        selectedContainerIndex:
                                            _selectedContainerIndex,
                                        title: "files".tr(context),
                                        context: context,
                                        function: changeIndex2,
                                        value: 2,height: 40,width: 3.5),
                                  ]),
                              _selectedContainerIndex == 1 && exams != null
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: exams.length,
                                      itemBuilder: (context, index) {
                                        return ExamsCardContent(
                                            exams[index]["title"],
                                            "grade".tr(context),
                                            exams[index]["exam_answers"].length !=
                                                    0
                                                ? exams[index]["exam_answers"][0]["grade"] !=
                                                        null
                                                    ? "${exams[index]["exam_answers"][0]["grade"]}/${exams[index]["grade"]}"
                                                    : "0/${exams[index]["grade"]}"
                                                : "",
                                            index + 1,
                                            exams[index]["exam_answers"],
                                            context,
                                            exams[index]["id"],
                                            courseContent["id"],
                                            exams[index]["exam_time"],
                                            exams[index]["exam_answers"].length !=
                                                    0
                                                ? exams[index]["exam_answers"][0]["grade"] !=
                                                        null
                                                    ?  exams[index]["exam_answers"][0]["grade"] ==
                                                            exams[index][
                                                                    "grade"] /
                                                                2
                                                        ? Colors.yellowAccent
                                                        : exams[index][
                                                                    "exam_answers"][0]["grade"] >
                                                                exams[index][
                                                                        "grade"] /
                                                                    2
                                                            ? Colors.green
                                                            : AppColors.red
                                                    : AppColors.red
                                                : AppColors.mainAppColor);
                                      },
                                    )
                                  : _selectedContainerIndex == 1 &&
                                          exams == null
                                      ? Column(children: [
                                          SizedBox(height: 10.sp),
                                          CustomText(
                                            text: "no-exams".tr(context),
                                            fontSize: 16.sp,
                                          ),
                                        ])
                                      : _selectedContainerIndex == 2 &&
                                              files != null
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: files.length,
                                              itemBuilder: (context, index) {
                                                return CustomFileHomeWork(
                                                    fileNumber:
                                                        "${"file_num".tr(context)} ${index + 1}",
                                                    name:
                                                        files[index]["name"],

                                                    file_url: files[index]["url"],
                                                    context: context,
                                                    index: index + 1);
                                              },
                                            )
                                          : _selectedContainerIndex == 2 &&
                                                  files == null
                                              ? Column(children: [
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
                                                          (context, index) {
                                                        return CustomModule(
                                                            title:
                                                                lessons[index]
                                                                    ["name"],
                                                            overview: lessons[
                                                                    index]
                                                                ["overview"],
                                                            num1:
                                                                "${index + 1}",
                                                            index:
                                                                lessons[index]
                                                                    ["id"],
                                                            context: context,
                                                            purched: purched);
                                                      },
                                                    )
                                                  : Column(children: [

                                                      SizedBox(height: 10.sp),
                                                      CustomText(
                                                        text: "no_modules"
                                                            .tr(context),
                                                        fontSize: 16.sp,
                                                      ),
                                                    ])
                            ]),
                        )
                  ])
            ])
            ),
          ),
        );
    });
  }

  void changeIndex0() {
    setState(() {
      _selectedContainerIndex = 0;
    });
  }
  void changeIndex1() {
    SaveItCubit.get(context).saveInt("course_id", widget.id!);
    setState(() {
      _selectedContainerIndex = 1;
    });
  }

  Future<void> changeIndex2() async {
    await   CourcesCubit.get(context).getFiles(context: context, id: widget.id!);
    files = CourcesCubit.get(context).files["data"];
print(files);
    if (files.length == 0) {
      files = null;
    }
    setState(() {
      _selectedContainerIndex = 2;
    });
  }
}
