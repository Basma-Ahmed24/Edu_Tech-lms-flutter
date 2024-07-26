import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';

import '../../../../helpers/constants/app_color_theme.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_images.dart';
import '../../../../helpers/constants/app_sizes.dart';

class CustomSearch extends StatelessWidget {
  final void Function(String)? onChanged;
  final bool isNoSuffix;
  final void Function()? onTapSearch;
  final TextEditingController? controller;
  final double? width;

  const CustomSearch({
    Key? key,
    this.width,
    this.onChanged,
    this.controller,
    this.onTapSearch,
    this.isNoSuffix = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? AppSize.width(context) * .9,
      height: 35.sp,
      child: TextField(
        controller: controller,
        autofocus: false,
        onChanged: (v) {
          onChanged!(v);
        },
        decoration: InputDecoration(
          fillColor: AppColorTheme.homeFilterAndSearchBgTheme(context),
          filled: true,
          suffixIcon: isNoSuffix
              ? null
              : GestureDetector(
            onTap: onTapSearch,
            child: Container(
                margin: const EdgeInsets.all(6),
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.mainAppColor,
                ),
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.white,
                  size: 12.sp,
                )),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Hero(
              tag: 'search_hero',
              child: SvgPicture.asset(
                AppImages.search,
              ),
            ),
          ),
          isDense: true,
          hintText: 'search_by_the_name_of_the_teacher_or_course'.tr(context),
          hintStyle: TextStyle(fontSize: 10.sp),
          contentPadding: const EdgeInsets.all(0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
