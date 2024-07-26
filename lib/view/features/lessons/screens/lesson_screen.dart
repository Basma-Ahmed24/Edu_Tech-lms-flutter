import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/features/lessons/widgets/shimmer_lesson_details.dart';
import 'package:video_viewer_updated/video_viewer.dart';

import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_sizes.dart';
import '../../../widgets/custom_text.dart';
import '../../home/widgets/app_bar.dart';
import '../logic/cubit/cubit.dart';
import '../logic/cubit/state.dart';

class LessonScreen extends StatefulWidget {
  @override
  int? index;
  String? url;

  LessonScreen(int index, String url) {
    this.index = index;
    this.url = url;
  }

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  void initState() {
    LessonCubit.get(context)
        .getLessonInfo(context: context, id: widget.index!, url: widget.url!);

    super.initState();
  }

  void dispose() {
    controller.dispose(); // Stop the video when the app is closed
    super.dispose();
  }

  final controller = VideoViewerController();
  String isdraft = "false";
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: SizedBox(
                width: AppSize.width(context),
                height: AppSize.height(context),
                child: SingleChildScrollView(
                    child: Column(children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      LessonCubit.get(context).getLessonInfo(
                          context: context,
                          id: widget.index!,
                          url: widget.url!);
                    },
                    child: Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: BlocBuilder<LessonCubit, LessonState>(
                            builder: (context, state) {
                          dynamic lesson;
                          if (state is LessonLoadingState) {
                            return ShimmerLessonDetails();
                          } else if (state is LessonLoadedState) {
                            lesson = context.read<LessonCubit>().lesson;
                            if (lesson.length == 0) {
                              lesson = null;
                            }
                            dynamic quality = [];

                            if (lesson.length != 0) {
                              for (int i = 0;
                                  i < lesson["encrypted"].length;
                                  i++) {
                                var value =
                                    lesson["encrypted"][i]["format_note"];
                                quality.add(value);
                              }
                            }
                            DateTime currentDate = DateTime.now();
                            DateTime givenDate =
                                DateTime.parse(lesson["created_at"]);
                            Duration period = currentDate.difference(givenDate);
                            int days = period.inDays;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomAppBar(
                                    isText: true,
                                    title: "${"lesson_details".tr(context)}"),
                                Container(
                                  height: AppSize.height(context) / 4,
                                  width: AppSize.width(context),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:BorderRadius.only(bottomRight: Radius.circular(20),topLeft: Radius.circular(20)),
                                    border: Border.all(
                                      color: Colors.white60,
                                      width: 2,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      topLeft: Radius.circular(25),
                                    ),
                                    child: Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: VideoViewer(
                                        language: VideoViewerLanguage.en,
                                        controller: controller,
                                        source: {
                                          quality[1]: VideoSource(
                                              video:
                                                  VideoPlayerController.network(
                                                      lesson["encrypted"][1]
                                                          ["url"])),
                                          quality[2]: VideoSource(
                                              video:
                                                  VideoPlayerController.network(
                                                      lesson["encrypted"][2]
                                                          ["url"])),
                                        },
                                        autoPlay: false,
                                        style: VideoViewerStyle(
                                          playAndPauseStyle:
                                              PlayAndPauseWidgetStyle(
                                                  background:
                                                      AppColors.mainAppColor),
                                          progressBarStyle: ProgressBarStyle(
                                            bar: BarStyle.progress(
                                                color: AppColors.mainAppColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.sp),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: lesson["name"],
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.sp,
                                ),
                                SizedBox(
                                  width: 25.sp,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                        height: 45,
                                        width: AppSize.width(context),
                                        decoration: BoxDecoration(
                                          image:
                                          DecorationImage(image: AssetImage("assets/images/WhatsApp Image 2023-11-03 at 22.29.27_23a73831.jpg"),
                                            fit: BoxFit.fill, // Set the BoxFit.fill property
                                          ),
                                          border: Border.all(
                                            color: AppColors.mainAppColor,
                                          ),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20)),
                                        ),
                                        child: Center(
                                            child: CustomText(
                                          text: "go_to_remained_lessons"
                                              .tr(context),
                                          color: Colors.white,
                                              fontWeight: FontWeight.w600,fontSize: 14.sp,
                                        ))))
                              ],
                            );
                          } else {
                            return CustomText(
                              text: "wrong".tr(context),
                            );
                          }
                        })),
                  )
                ])))));
  }
}
