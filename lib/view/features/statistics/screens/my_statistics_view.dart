import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/widgets/custom_text.dart';
import 'package:lms_flutter/view/widgets/empty_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../helpers/constants/app_color_theme.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_sizes.dart';

import '../../cources/widgets/shimmer_text_widget.dart';
import '../../home/widgets/app_bar.dart';
import '../my_statistics_cubit/mystatistics_cubit.dart';
import '../widgets/statistics_two_tap_container.dart';
import '../widgets/student_statistics_top_info.dart';

class MyStatisticsView extends StatefulWidget {
  const MyStatisticsView({super.key});

  @override
  State<MyStatisticsView> createState() => _MyStatisticsViewState();
}

class _MyStatisticsViewState extends State<MyStatisticsView> {
  List<PieData> pieData = [];

  @override
  void initState() {
    MyStatisticsCubit.get(context).getUserStatus(context: context);
    pieData = pieDataF();
    super.initState();
  }

  List<PieData> pieDataF() {
    List<PieData>? dataSource = [
      PieData(title: 'phone', persentage: 65),
      PieData(title: 'plane', persentage: 15),
      PieData(title: 'ferhri', persentage: 50),
    ];
    return dataSource;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            width: AppSize.width(context),
            height: AppSize.height(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomAppBar(
                  isTab: true,
                  isNoPadding: true,
                  isGoBack: true,
                  isText: true,
                  title: 'my_statistics'.tr(context),
                ),
                StudentStatisticsTopInfo(pieData: pieData),
                const Divider(thickness: 2),
                SizedBox(height: 16.sp),
                const StatisticsTwoTapContainer(),
                SizedBox(height: 10.sp),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      MyStatisticsCubit.get(context).getUserStatus(
                        context: context,
                        isRefresh: true,
                      );
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: BlocBuilder<MyStatisticsCubit, MyStatisticsState>(
                        builder: (context, state) {
                          var cubit = MyStatisticsCubit.get(context);
                          return cubit.currentIndex == 1
                              ? const StatisticsExamCard()
                              :cubit.currentIndex==2? const NotificationsListView():
                          StatisticsHomeWorkCard();
                          // : ListView.separated(
                          //     padding: const EdgeInsets.only(top: 5),
                          //     shrinkWrap: true,
                          //     physics: const BouncingScrollPhysics(),
                          //     separatorBuilder: (context, index) =>
                          //         SizedBox(height: 10.sp),
                          //     itemCount: 10,
                          //     itemBuilder: (context, index) {
                          //       return SmallCourseCard(index: index + 1);
                          //     },
                          //   );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

    );
  }
}

class PieData {
  final String title;
  final int persentage;

  PieData({
    required this.title,
    required this.persentage,
  });
}

class NotificationsListView extends StatelessWidget {
  const NotificationsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyStatisticsCubit, MyStatisticsState>(
      builder: (context, state) {
        var cubit = MyStatisticsCubit.get(context);

        return cubit.isLoadingUserStatus
            ? const NotificationShimmerListViewLoading(itemCount: 10)
            : cubit.userStatus.notifications == null ||
                    cubit.userStatus.notifications!.isEmpty
                ? Container(
                    height: AppSize.height(context) * .5,
                    alignment: Alignment.center,
                    child: EmptyWidget(
                      text: 'no_notifications_available'.tr(context),
                    ),
                  )
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      left: 5.sp,
                      right: 5.sp,
                      bottom: AppSize.height(context) * .1,
                    ),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 0.sp),
                    itemCount: cubit.userStatus.notifications!.length,
                    itemBuilder: (context, index) {
                      var noty = cubit.userStatus.notifications![index];
                      return Container(
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 5,
                          top: 10,
                          bottom: 10,
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: noty.title ?? "",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(height: 2.sp),
                                CustomText(
                                  text: noty.body ?? "",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      AppColorTheme.grayTextColorTheme(context),
                                ),
                                SizedBox(height: 3.sp),
                                CustomText(
                                  text: DateFormat("MM/dd/yyyy hh:mm a")
                                      .format(noty.createdAt!)
                                      .toString(),
                                  fontSize: 8.sp,
                                  color:
                                      AppColorTheme.grayTextColorTheme(context),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
      },
    );
  }
}

class NotificationShimmerListViewLoading extends StatelessWidget {
  final int itemCount;
  final bool isNoMargin;

  const NotificationShimmerListViewLoading({
    super.key,
    this.itemCount = 2,
    this.isNoMargin = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 10.sp),
      itemCount: itemCount,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return const NotificationShimmerItem();
      },
    );
  }
}

class NotificationShimmerItem extends StatelessWidget {
  const NotificationShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade200,
      child: Container(
        padding: const EdgeInsets.only(
          left: 5,
          right: 5,
          top: 10,
          bottom: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerTextWidget(
              width: AppSize.width(context) * .5,
              height: 7,
            ),
            SizedBox(height: 5.sp),
            ShimmerTextWidget(
              width: AppSize.width(context) * .4,
              height: 6,
            ),
            SizedBox(height: 5.sp),
            ShimmerTextWidget(
              width: AppSize.width(context) * .2,
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}

class StatisticsExamCard extends StatelessWidget {
  const StatisticsExamCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int newindex=0;
    return BlocBuilder<MyStatisticsCubit, MyStatisticsState>(
      builder: (context, state) {
        var cubit = MyStatisticsCubit.get(context);

        return cubit.isLoadingUserStatus
            ? Padding(
          padding: EdgeInsets.only(top: 10.sp),
          child: const CircularProgressIndicator(),
        )
            : cubit.userStatus.exams == null || cubit.userStatus.exams!.isEmpty
            ? Container(
          height: AppSize.height(context) * .5,
          alignment: Alignment.center,
          child: CustomText(
            text: 'no-exams'.tr(context),
          ),
        )
            : ListView.separated(
          padding: EdgeInsets.only(
            top: 10.sp,
            bottom: AppSize.height(context) * .1,
          ),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) =>
              SizedBox(height: 10.sp),
          itemCount: cubit.userStatus.exams!.length,
          itemBuilder: (context, index) {

            var data = cubit.userStatus.exams![index];

            if (data.exam!.type == "HomeWork") {

              return SizedBox.shrink();
            }
newindex=newindex+1;
            return GestureDetector(
              onTap: () {},
              child: Stack(
                children: [
                  Container(
                    width: AppSize.width(context),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20)),
                      color: AppColorTheme.containerTheme(context),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.subMainAppColor,
                                  borderRadius:
                                  BorderRadius.circular(12),
                                ),
                                child: CustomText(
                                  text: newindex >= 10
                                      ? '${newindex}'
                                      : '0${newindex}',
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.mainAppColor,
                                )),
                            SizedBox(width: 8.sp),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: data.exam!.title ?? "",
                                  fontSize: 12.sp,
                                  color: AppColors.grayTextColor,
                                ),
                                SizedBox(height: 5.sp),
                                data.exam!.examTime == null
                                    ? const SizedBox.shrink()
                                    : CustomText(
                                  text:
                                  '${data.exam!.examTime} m',
                                  fontSize: 11.sp,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CustomText(
                              text: 'grade'.tr(context),
                            ),
                            SizedBox(height: 5.sp),
                            CustomText(
                              text:
                              '${data.exam!.grade ?? 0} / ${data.userGrade ?? 0}',
                              color: data.status == 'Success'
                                  ? data.userGrade! >
                                  (data.exam!.grade! / 5 +
                                      data.exam!.grade! / 2)
                                  ? Colors.green
                                  : Colors.amber
                                  : Colors.red,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
class StatisticsHomeWorkCard extends StatelessWidget {
  const StatisticsHomeWorkCard({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyStatisticsCubit, MyStatisticsState>(
      builder: (context, state) {
        var cubit = MyStatisticsCubit.get(context);
        List<dynamic> homeworks = [];

        if (cubit.userStatus.exams != null) {
          for (int i = 0; i < cubit.userStatus.exams!.length; i++) {
            if (cubit.userStatus.exams![i].exam?.type == "HomeWork") {
              Map<String, dynamic> homeworkDetails = {
                'homeworkgrade': cubit.userStatus.exams![i].exam!.grade,
                'homeworkName': cubit.userStatus.exams![i].exam!.title,
                'homeworktime': cubit.userStatus.exams![i].exam!.examTime,
                'homeworkusergrade': cubit.userStatus.exams![i].userGrade,
                'homeworkstatus': cubit.userStatus.exams![i].status
                // Add more details as needed
              };
              homeworks.add(homeworkDetails);
              print(homeworks);
            }
          }
        }
        return cubit.isLoadingUserStatus
            ? Padding(
          padding: EdgeInsets.only(top: 10.sp),
          child: const CircularProgressIndicator(),
        )
            : homeworks.length == 0
            ? Container(
          height: AppSize.height(context) * .5,
          alignment: Alignment.center,
          child: EmptyWidget(
            text: 'no_statistics_available'.tr(context),
          ),
        )
            : ListView.separated(
          padding: EdgeInsets.only(
            top: 10.sp,
            bottom: AppSize.height(context) * .1,
          ),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) =>
              SizedBox(height: 10.sp),
          itemCount: homeworks.length,
          itemBuilder: (context, index) {

            return GestureDetector(
              onTap: () {},
              child: Stack(
                children: [
                  Container(
                    width: AppSize.width(context),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
                      color: AppColorTheme.containerTheme(context),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.subMainAppColor,
                                  borderRadius:
                                  BorderRadius.circular(12),
                                ),
                                child: CustomText(
                                  text: index + 1 >= 10
                                      ? '${index + 1}'
                                      : '0${index + 1}',
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.mainAppColor,
                                )),
                            SizedBox(width: 8.sp),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text:homeworks[index]["homeworkName"] ?? "",
                                  fontSize: 12.sp,
                                  color: AppColors.grayTextColor,
                                ),
                                SizedBox(height: 5.sp),
                                homeworks[index]["homeworktime"] == null
                                    ? const SizedBox.shrink()
                                    : CustomText(
                                  text:
                                  '${homeworks[index]["homeworktime"] } m',
                                  fontSize: 11.sp,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CustomText(
                              text: 'grade'.tr(context),
                            ),
                            SizedBox(height: 5.sp),
                            CustomText(
                              text:
                              '${homeworks[index]["homeworkgrade"]  ?? 0} / ${homeworks[index]["homeworkusergrade"]?? 0}',
                              color: homeworks[index]["homeworkstatus"]== 'Success'
                                  ? homeworks[index]["homeworkusergrade"]! >
                                  (homeworks[index]["homeworkgrade"] ! / 5 +
                                      homeworks[index]["homeworkgrade"] ! / 2)
                                  ? Colors.green
                                  : Colors.amber
                                  : Colors.red,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
