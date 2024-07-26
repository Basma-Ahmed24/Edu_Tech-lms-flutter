import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';

import '../../../widgets/custom_text.dart';
import '../../exam_questions_score_view/screens/exam_questions_view.dart';

showExamAlertDialog({BuildContext? context, examid, courseid}) {
  return showDialog(
    context: context!,
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
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20.h),
                const SizedBox(width: 20),
                CustomText(
                  text: "exam_alert".tr(context),
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
                          text: "exit".tr(context),
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExamQuestionsView(
                                      examId: examid,
                                      courseId: courseid,
                                    )),
                          );
                        },
                        child: CustomText(
                          text: "begin".tr(context),
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
        ),
      );
    },
  );
}
