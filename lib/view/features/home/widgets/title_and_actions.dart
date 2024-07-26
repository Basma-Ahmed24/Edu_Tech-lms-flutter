import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../helpers/constants/app_color_theme.dart';
import '../../../../helpers/constants/app_current_lang.dart';
import '../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import '../../../widgets/custom_text.dart';

Widget CustomTitleAndActions(String title,bool isShowAction,String actionTitle,Function() onTapAction ) =>
     Container(
      padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: title,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
          !isShowAction
              ? const SizedBox.shrink()
              : BlocBuilder<SaveItCubit, SaveItState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: onTapAction,
                child: Row(
                  children: [
                    CustomText(
                      text: actionTitle!,
                      color: AppColorTheme.grayTextColorTheme(context),
                      fontSize: 12.sp,
                    ),
                    SizedBox(width: 4.sp),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        textDirection: AppCurrentLang.isEn(context)
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        size: 16.sp,
                        color: AppColorTheme.grayTextColorTheme(context),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );

