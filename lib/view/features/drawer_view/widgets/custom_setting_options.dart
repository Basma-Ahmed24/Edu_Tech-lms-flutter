import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import '../../../widgets/custom_text.dart';


class CustomSettingOptions extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final Widget? leading;
  final bool isNoTrailing;
  final void Function()? onTap;

  const CustomSettingOptions({
    Key? key,
    required this.title,
    this.trailing,
    this.leading,
    this.isNoTrailing = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        ///! to make all the row clickable
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
            isNoTrailing
                ? const SizedBox.shrink()
                : trailing ??
                    BlocBuilder<SaveItCubit, SaveItState>(
                      builder: (context, state) {
                        var cubit = SaveItCubit.get(context);
                        return Icon(
                          Icons.arrow_back_ios,
                          textDirection: cubit.getLang() == 'en'
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          size: 14.sp,
                        );
                      },
                    ),
          ],
        ),
      ),
    );
  }
}
