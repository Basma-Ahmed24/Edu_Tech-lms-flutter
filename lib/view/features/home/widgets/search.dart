import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';

import '../../../../helpers/constants/app_color_theme.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_images.dart';
import '../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import '../../../widgets/custom_text.dart';
import '../../search/search_screen.dart';

class CustomHomeFilterAndSearch extends StatelessWidget {
  final bool isFromHome;

  const CustomHomeFilterAndSearch({
    super.key,
    this.isFromHome = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
      child: BlocBuilder<SaveItCubit, SaveItState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchView()));
            },
            child: Container(
              padding: EdgeInsets.all(6.sp),
              height: 35.sp,
              decoration: BoxDecoration(
                color: AppColorTheme.homeFilterAndSearchBgTheme(context),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Hero(
                    tag: 'search_hero',
                    child: SvgPicture.asset(
                      AppImages.search,
                    ),
                  ),
                  SizedBox(width: 8.sp),
                  Expanded(
                    child: CustomText(
                      text: 'search_by_the_name_of_the_teacher_or_course'
                          .tr(context),
                      fontSize: 10.sp,
                    ),
                  ),
                  // Container(
                  //     height: 100.sp,
                  //     width: 30.sp,
                  //     padding: const EdgeInsets.all(2),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(4),
                  //       color: AppColors.mainAppColor,
                  //     ),
                  //     child: Icon(
                  //       Icons.arrow_forward_ios_outlined,
                  //       color: Colors.white,
                  //       size: 12.sp,
                  //     ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
