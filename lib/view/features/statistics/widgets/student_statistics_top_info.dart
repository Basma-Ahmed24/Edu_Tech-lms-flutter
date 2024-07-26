import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../helpers/constants/app_color_theme.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_sizes.dart';
import '../../../widgets/custom_text.dart';
import '../../cources/widgets/shimmer_text_widget.dart';
import '../my_statistics_cubit/mystatistics_cubit.dart';
import '../screens/my_statistics_view.dart';
import 'custom_Liner_widget.dart';

class StudentStatisticsTopInfo extends StatelessWidget {
  const StudentStatisticsTopInfo({
    super.key,
    required this.pieData,
  });

  final List<PieData> pieData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.height(context) * .18,
      child: BlocBuilder<MyStatisticsCubit, MyStatisticsState>(
        builder: (context, state) {
          var cubit = MyStatisticsCubit.get(context);
          var examCount = cubit.userStatus.exams != null
              ? cubit.userStatus.exams!.length
              : 0;
          return cubit.isLoadingUserStatus
              ? const TopStatisticsShimmerLoading()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomText(
                            text: 'my_subscriptions_statistics'.tr(context),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10.sp),
                        CustomText(
                          text: '$examCount ${'number_of_exams'.tr(context)}',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        cubit.userStatus.theData!.isEmpty
                            ? Expanded(
                                flex: 2,
                                child: Center(
                                  child: CustomText(
                                    text: 'no_statistics'.tr(context),
                                  ),
                                ),
                              )
                            : Expanded(
                                flex: 2,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 10.sp),
                                  itemCount:
                                      cubit.userStatus.theData!.take(3).length,
                                  itemBuilder: (context, index) {
                                    var data = cubit
                                        .userStatus.theData!.reversed
                                        .toList()[index];
                                    return CustomLinerWidget(
                                      title: data.name ?? "",
                                      color: data.progressPercentage! >= 75
                                          ? Colors.green
                                          : data.progressPercentage! >= 50
                                              ? Colors.amber
                                              : data.progressPercentage! < 50
                                                  ? Colors.red
                                                  : Colors.green,
                                      percentage:
                                          data.progressPercentage!.toDouble(),
                                    );
                                  },
                                ),
                              ),
                        Expanded(
                          child: SizedBox(
                            height: 100.sp,
                            width: 100.sp,
                            child: PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(
                                  enabled: true,
                                  touchCallback: (
                                    FlTouchEvent event,
                                    pieTouchResponse,
                                  ) {
                                    if (!event.isInterestedForInteractions ||
                                        pieTouchResponse == null ||
                                        pieTouchResponse.touchedSection ==
                                            null) {
                                      cubit.getCurrentTapPie(-1);
                                      return;
                                    }

                                    cubit.getCurrentTapPie(pieTouchResponse
                                        .touchedSection!.touchedSectionIndex);
                                  },
                                ),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 2,
                                centerSpaceRadius: 0,
                                sections: cubit.userStatus.theData!.isEmpty
                                    ? List.generate(
                                        3,
                                        (index) {
                                          return PieChartSectionData(
                                            color:
                                                Theme.of(context).primaryColor,
                                            value: 100,
                                            title: '0%',
                                            radius: 40,
                                            titleStyle: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  AppColors.bestSellerBgColor,
                                              shadows: const [
                                                Shadow(
                                                  color: Colors.black,
                                                  blurRadius: 2,
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                    : List.generate(
                                        cubit.userStatus.theData!.reversed
                                            .take(3)
                                            .length,
                                        (i) {
                                          var num = cubit
                                              .userStatus.theData!.reversed
                                              .take(3)
                                              .toList()[i]
                                              .progressPercentage!
                                              .toDouble();
                                          return PieChartSectionData(
                                            color: num == 0.0
                                                ? AppColorTheme
                                                    .grayTextColorTheme(context)
                                                : num >= 75
                                                    ? Colors.green
                                                    : num >= 50
                                                        ? Colors.amber
                                                        : num < 50
                                                            ? Colors.red
                                                            : Colors.green,
                                            value: num == 0.0 ? 1 : num,
                                            title:
                                                '${num.toString().split('.').first}%',
                                            radius: cubit.currentTapPie == i
                                                ? 50
                                                : 40,
                                            titleStyle: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.bold,
                                              color: num == 0.0
                                                  ? AppColorTheme
                                                      .blackAndWhiteTheme(
                                                          context)
                                                  : AppColors.bestSellerBgColor,
                                              shadows: const [
                                                Shadow(
                                                  color: Colors.black,
                                                  blurRadius: 2,
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ),
                          ),
                        ),
                        // Expanded(
                        //   flex: 1,
                        //   child: SizedBox(
                        //     height: 100,
                        //     width: 100,
                        //     child: SfCircularChart(
                        //       palette: [
                        //         Theme.of(context).primaryColor,
                        //         Colors.red,
                        //         Colors.amber,
                        //       ],
                        //       series: [
                        //         DoughnutSeries<TheData, String>(
                        //           dataSource: cubit.userStatus.theData!.reversed
                        //               .take(3)
                        //               .toList(),
                        //           dataLabelSettings: const DataLabelSettings(
                        //             isVisible: true,
                        //             showCumulativeValues: true,
                        //           ),
                        //           xValueMapper: (TheData p, _) => p.name,
                        //           yValueMapper: (TheData s, _) =>
                        //               s.progressPercentage,
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                );
        },
      ),
    );
  }
}

class TopStatisticsShimmerLoading extends StatelessWidget {
  const TopStatisticsShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade200,
      child: Container(
        padding: const EdgeInsets.only(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerTextWidget(
                  width: AppSize.width(context) * .4,
                ),
                ShimmerTextWidget(
                  width: AppSize.width(context) * .2,
                  height: 7,
                ),
              ],
            ),
            SizedBox(height: 40.sp),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerTextWidget(
                        width: AppSize.width(context) * .25,
                      ),
                      ShimmerTextWidget(
                        width: AppSize.width(context) * .25,
                      ),
                      ShimmerTextWidget(
                        width: AppSize.width(context) * .25,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerTextWidget(
                        width: AppSize.width(context) * .1,
                      ),
                      ShimmerTextWidget(
                        width: AppSize.width(context) * .1,
                      ),
                      ShimmerTextWidget(
                        width: AppSize.width(context) * .1,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerTextWidget(
                        width: AppSize.width(context) * .2,
                        height: 7,
                      ),
                      ShimmerTextWidget(
                        width: AppSize.width(context) * .2,
                      ),
                      ShimmerTextWidget(
                        width: AppSize.width(context) * .2,
                      ),
                    ],
                  ),
                  SizedBox(width: 20.sp),
                  Container(
                    height: 70,
                    width: 70,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10.sp),
          ],
        ),
      ),
    );
  }
}
