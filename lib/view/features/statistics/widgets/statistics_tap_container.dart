import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../helpers/constants/app_color_theme.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../widgets/custom_text.dart';
import '../my_statistics_cubit/mystatistics_cubit.dart';

class StatisticsTapContainer extends StatelessWidget {
  final String title;
  final int index;

  const StatisticsTapContainer({
    Key? key,
    required this.title,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          MyStatisticsCubit.get(context).changeIndex(index);
        },
        child: BlocBuilder<MyStatisticsCubit, MyStatisticsState>(
            builder: (context, state) {
          var cubit = MyStatisticsCubit.get(context);
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: cubit.currentIndex == index?  BoxDecoration(
              border: Border.all(
                color: AppColors.mainAppColor,
                width: 1,
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              // selectedContainerIndex == value
              //     ?

              image:
              DecorationImage(image: AssetImage("assets/images/WhatsApp Image 2023-11-03 at 22.29.27_23a73831.jpg"),
                fit: BoxFit.fill, // Set the BoxFit.fill property
              ),
              // : AppColors.mainAppColor,
            ):
            BoxDecoration(
                border: Border.all(
                  color: AppColors.mainAppColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                // selectedContainerIndex == value
                //     ? color: Colors.white

                color: Colors.white
              // : AppColors.mainAppColor,
            ),
            alignment: Alignment.center,
            child: CustomText(
              text: title,
              color: cubit.currentIndex == index
                  ? Colors.white
                  : Theme.of(context).primaryColor,
            ),
          );
        }),
      ),
    );
  }
}
