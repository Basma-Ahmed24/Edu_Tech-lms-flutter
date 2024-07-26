import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../helpers/constants/app_saved_key.dart';
import '../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import '../../../widgets/custom_text.dart';


class CustomLangRowCard extends StatelessWidget {
  final String title;
  final String value;

  const CustomLangRowCard({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SaveItCubit.get(context).saveString(AppSavedKey.currentLang, value);
      },
      child: Row(
        children: [
          BlocBuilder<SaveItCubit, SaveItState>(
            builder: (context, state) {
              var cubit = SaveItCubit.get(context);
              return Container(
                width: 12.sp,
                height: 12.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black),
                  color: cubit.getLang() == value
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade100,
                ),
              );
            },
          ),
          SizedBox(width: 10.sp),
          CustomText(
            text: title,
            fontSize: 16.sp,
          ),
        ],
      ),
    );
  }
}
