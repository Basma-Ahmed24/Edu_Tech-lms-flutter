import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms_flutter/helpers/constants/app_colors.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/features/cources/screens/cource_content_screen.dart';
import '../../../../helpers/constants/app_sizes.dart';
import '../../../widgets/custom_text.dart';

Widget CourceCardContent(
    {Color? c,
      String? img,
      String? name,
      String? subject,
      String? year,
      String? specification,
      String? price,
      String? instructor,
      context,
      id,
      newlyadded,
     int? index,
      time}) {


  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CourseContent(id!)),
      );
    },
    child: 
    Padding(padding: EdgeInsets.all(10),
      child: Container(width: AppSize.width(context)/2.5,
        height: AppSize.height(context)/3,
decoration: BoxDecoration(
 image:   DecorationImage(
      image: NetworkImage("https://mark2.faheemacademy.online$img"),
      fit: BoxFit.fill, // Set the BoxFit.fill property
    ),
  color: AppColors.subMainAppColor,
  borderRadius:
  index==0||index==3? BorderRadius.only( topLeft: Radius.circular(50),topRight:Radius.circular(0),
  bottomRight: Radius.circular(50)):
  BorderRadius.only( topRight: Radius.circular(50),topLeft:Radius.circular(0) ,
      bottomLeft: Radius.circular(50))
),
       child: Stack(children:[  Positioned(
       bottom: 0,
       left: 0,
       right: 0,
       top:3,
       child: Container(
         height: AppSize.height(context) * 0.07,
         decoration: BoxDecoration(
             borderRadius:
             index==0||index==3? BorderRadius.only( topLeft: Radius.circular(50),topRight:Radius.circular(0),
                 bottomRight: Radius.circular(50)):
             BorderRadius.only( topRight: Radius.circular(50),topLeft:Radius.circular(0) ,
                 bottomLeft: Radius.circular(50)),
             gradient: LinearGradient(
                 begin: Alignment.bottomCenter,
                 end: Alignment.center,
                 colors: [
                   Colors.black.withOpacity(0.9),
                   Colors.transparent
                 ])),
       ),
       ),
       Positioned(
         bottom: 0,
         left: 0,
         right: 0,
         top: null,
         child: Column(
           children: [

             CustomText(
               text: name!,
               textAlign: TextAlign.center,
               color: Colors.white,
               fontWeight: FontWeight.bold,
               fontSize: 12.sp,
               isMultiLines: true,
               maxLines: 2,
             ),
             CustomText(
               text: '$price ${"pound".tr(context)}',
               textAlign: TextAlign.center,
               color: Colors.white,
               fontWeight: FontWeight.bold,
               fontSize: 12.sp,
               isMultiLines: true,
               maxLines: 2,
             ),

           ],
         ),
       )
       ],

       ), ),
  ));
}
