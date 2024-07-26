
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/extensions/navigation_extension.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/features/cources/widgets/show_exam_alert_dialog.dart';
import 'package:lms_flutter/view/features/exam_questions_score_view/screens/exam_questions_view.dart';

import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/router/app_name_route.dart';
import '../../../widgets/custom_text.dart';

Widget ExamsCardContent(  text2, text3, text4, num,answers,context,examid,courseid,examtime,color)=>
  Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),topLeft:
      Radius.circular(20)
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.sp,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),topLeft:
                  Radius.circular(15)
                   ),
                  image:
                  DecorationImage(image: AssetImage("assets/images/WhatsApp Image 2023-11-03 at 22.29.27_23a73831.jpg"),
                    fit: BoxFit.fill, // Set the BoxFit.fill property
                  ),
                ),
                child: Center(
                  child: CustomText(
                    text: "${num}",
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  CustomText(
                    text: text2,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    text: "$examtime m",
                    color: Colors.grey,
                    fontSize: 12.sp,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:[
                answers.length!=0?
                CustomText(
                  text: text3,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ):Container(),
                answers.length!=0?

                CustomText(
                  text:text4,
                  fontSize: 16.sp,
                  color: color,

                ):InkWell(onTap: (){
                  showExamAlertDialog(context: context,examid: examid,courseid: courseid);

                },
                  child: CustomText(
                    text:"open_exam".tr(context),
                    fontSize: 14.sp,
                    color: AppColors.mainAppColor,
isUserLine: true,
                  ),
                ),
              ],
            ),
            SizedBox(width: 10,),
          ],
        ),
        SizedBox(height: 10.sp,),   ],
    ),
  );


Widget NotificationsCardContent(String text1,String text2,String text3,String num)=>
    Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.sp,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.bestSellerBgColor,
                  ),
                  child: Center(
                    child: CustomText(
                      text: num,
                      color: AppColors.mainAppColor,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: text1,
                      color: Colors.grey,
                      fontSize: 12.sp,
                    ),
                    CustomText(
                      text: text2,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12,),
              TextButton(onPressed: (){}, child:
CustomText(
  text: text3,
  fontSize: 12.sp,
  fontWeight: FontWeight.bold,
  color: AppColors.mainAppColor,
  isUserLine: true,
), ),
              //
              SizedBox(width: 10,),
            ],
          ),
          SizedBox(height: 10.sp,),   ],
      ),
    );
