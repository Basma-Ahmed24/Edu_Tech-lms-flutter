import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view/widgets/custom_text.dart';

class ErrorMessageDialog {
  static Future<void> show(BuildContext context, String message,
          {bool isOkDialog = false, bool isSuccess = false}) async =>
      await showDialog(
        context: context,
        builder: (context) {
          return isOkDialog
              ? Dialog(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            /// close icon
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.sp),
                        CustomText(
                          text: message,
                          textAlign: TextAlign.center,
                          color: isSuccess ? null : Colors.red,
                          fontSize: 14.sp,
                          isMultiLines: true,
                        ),
                        SizedBox(height: 15.sp),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 70,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const CustomText(
                                  text: 'ok',
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              : AlertDialog(
                  content: CustomText(
                    isMultiLines: true,
                    text: message,
                    color: Theme.of(context).primaryColor,
                  ),
                );
        },
      );
}
