import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/constants/app_images.dart';
import 'package:lms_flutter/helpers/constants/app_sizes.dart';
import 'package:lms_flutter/helpers/extensions/navigation_extension.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/router/app_name_route.dart';
import '../../../widgets/custom_text.dart';
import '../logic/cubit/profile_cubit.dart';
import '../logic/cubit/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  dynamic user;
  @override
  void initState() {
    ProfileCubit.get(context).getUserInfo(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.mainAppColor,
            ),
          );
        } else if (state is ProfileSucessState) {
          user = ProfileCubit.get(context).user;
          print(user["year"]);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(children: [
              Container(
              padding: EdgeInsets.only(
              top: 30.sp,
                bottom: 20.sp,
                left: 10.sp,  // Decrease the left padding
                right: 10.sp,  // Increase the right padding
              ),
              height: AppSize.height(context) * .32,
              decoration: BoxDecoration(
borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50)),
               image: DecorationImage(image: AssetImage("assets/images/WhatsApp Image 2023-11-03 at 22.29.27_23a73831.jpg"),fit:
               BoxFit.fill),

              ),

                  child: SingleChildScrollView(
                    child: Column(children: [
                      Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'my_profile'.tr(context),
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          SizedBox(height: 5),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: SaveItCubit.get(context).getBool("male") ==
                                      false
                                  ? Image.asset(AppImages.female)
                                  : Image.asset(AppImages.male),
                            ),
                          ),
                          SizedBox(
                            height: 5.sp,
                          ),
                          CustomText(
                            text: user["name"],
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 5.sp,
                          )
                        ],
                      ),
                      InkWell(
                          onTap: () {
                            AppNameRoute.profileEditScreen
                                .goAndReplaceAll(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: "edit".tr(context),
                                color: Colors.white,
                              ),
                              Image.asset(AppImages.edit)
                            ],
                          ))
                    ]),
                  ),
                ),

                SizedBox(
                  height: 20.sp,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 10.sp),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileBody('students_triple_name'.tr(context),
                            user["name"], context),
                        ProfileBody('student_number'.tr(context), user["phone"],
                            context),
                        ProfileBody('parent_number'.tr(context),
                            user["parent_phone"], context),
                        ProfileBody(
                            'Email'.tr(context), user["email"], context),

                      ],
                    ),
                  ],
                ),
              ]),
            ),
          );
        } else {
          return Center(child: Text("wrong".tr(context)));
        }
      },
    );
  }

  Widget ProfileBody(String title1, String title2, context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [

            title1=='students_triple_name'.tr(context)?
            Icon(Icons.person_outline,color: AppColors.announcementBgColor,):
            title1== 'Email'.tr(context)?   Icon(Icons.email_outlined,color: AppColors.announcementBgColor,):
            Icon(Icons.phone_enabled,color: AppColors.announcementBgColor,) ,
            SizedBox(width: 5.sp,),
            CustomText(
              text: title1,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        SizedBox(height: 8.sp),
        Container(width: AppSize.width(context)/2.5,height: 30,decoration: BoxDecoration(border: Border.all(color: AppColors.subMainAppColor,width: 2),
        borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: CustomText(
              text: title2,
              fontSize: 13.sp,
              color: AppColors.grayTextColor,
            ),
          ),
        ),
        SizedBox(height: 2.sp),
        Divider()
      ],
    );
  }
}
