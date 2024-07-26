import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import 'package:lms_flutter/view/features/Auth/widgets/states_handeling.dart';
import 'package:lms_flutter/view/features/module/screens/modules_screen.dart';
import 'package:lms_flutter/view/features/lessons/screens/lesson_screen.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_endpoint.dart';
import '../../../widgets/custom_text.dart';
import '../../lessons/widgets/open_pdf_file_widget.dart';
import '../../lessons/widgets/pdf_view.dart';
import '../../module/cubit/cubit.dart';

Widget CustomFileHomeWork(
        {String? fileNumber,
        String? name,
        file_url,
        context,
        index}) =>
    Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),
        topLeft: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.sp,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                    text: "${index}",
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
                    text: name!,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 12,
            ),
            OpenPdfFile(onTap: () {
              //controller.pause();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfView(
                      fileUrl: '${AppEndPoint.baseUrl}${file_url}',
                    ),
                  ));
            })
          ]),
          //
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );

Widget CustomModule(
        {String? title,
        String? overview,
        String? num1,
        index,
        context,
          url,
        purched}) =>
    InkWell(
      onTap: () async {
        if (purched == false)
          CustomToast("subscribe_cource".tr(context), Colors.red);
        if (purched != false) {

          var issubmitted = "false";
          if (SaveItCubit.get(context).getList("is_submitted") != null) {
            for (int i = 0;
            i < SaveItCubit.get(context).getList("is_submitted")!.length;
            i++) {
              if (SaveItCubit.get(context).getList("is_submitted")![i] ==
                  index.toString())
                issubmitted =
                SaveItCubit.get(context).getList("is_submitted")![i + 1];
            }
          }
          ModuleCubit.get(context).getModuleInfo(context: context, id: index);
          if (ModuleCubit
              .get(context)
              .moduleDetails["id"]==index)
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ModuleContent(index, issubmitted,
                          SaveItCubit.get(context).getList("draft"))),
            );
        }
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),
          topLeft: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: 10.sp,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height: 35,
                    width: 35,
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
                        text: "${num1}",
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
                        text: title!,
                        color: Colors.grey,
                        fontSize: 12.sp,
                      ),
                      Row(children: [
                        Flexible(
                          child: CustomText(
                            text: overview!,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ]),
                    ],
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Center(child:Icon(Icons.arrow_forward_ios,color: AppColors.announcementBgColor,) ),

              ],
            ),

          ],
        ),
      ),
    );
Widget CustomLesson(
    {String? title,
      String? overview,
      String? num1,
      index,
      context,
      url,
      purched}) =>
    InkWell(
      onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LessonScreen(index,url)),
          );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),topLeft: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.subMainAppColor,
                    ),
                    child: Center(
                        child: Icon(Icons.play_arrow,color: AppColors.mainAppColor,)),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(children: [
                        Flexible(
                          child: CustomText(
                            text: title!,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ]),
                    ],
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Center(child:CustomText(
                  text: overview!,
                  fontSize: 13.sp,
                  color: Colors.grey,

                ), ),
              ],
            ),
          ],
        ),
      ),
    );

