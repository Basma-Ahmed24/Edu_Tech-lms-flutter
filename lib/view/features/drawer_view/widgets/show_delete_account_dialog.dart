import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/extensions/navigation_extension.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import '../../../../helpers/constants/app_saved_key.dart';
import '../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import '../../../../helpers/router/app_name_route.dart';
import '../../../widgets/custom_text.dart';
import '../../Auth/logic/cubit/auth_cubit.dart';

showDeleteAccountDialog(BuildContext context) {
  callback() {
   // Navigator.pop(context);
    AppNameRoute.signInScreen.goAndReplaceAll(context);
  }

  errorCallback() {
    Navigator.pop(context);
  }

  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          // height: 120.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(''),
              SizedBox(height: 20.h),
              const SizedBox(width: 20),
              CustomText(
                text: 'Delete_Account_Warning'.tr(context),
                fontSize: 14.sp,
                isMultiLines: true,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              // const Spacer(),
              Divider(height: 10, color: Theme.of(context).hintColor),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: CustomText(
                        text: 'no'.tr(context),
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: VerticalDivider(
                      width: 5,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        AuthCubit.get(context).deleteAccount(
                          context,
                          callback,
                          errorCallback,
                        );


                        //AppNameRoute.signInScreen.goAndReplaceAll(context);

                      },
                      child: CustomText(
                        text: 'yes'.tr(context),
                        fontSize: 14,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
