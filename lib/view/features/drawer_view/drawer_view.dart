import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/extensions/navigation_extension.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/helpers/router/app_name_route.dart';
import 'package:lms_flutter/view/features/drawer_view/screens/change_lang_view.dart';
import 'package:lms_flutter/view/features/drawer_view/widgets/show_delete_account_dialog.dart';
import 'package:lms_flutter/view/features/drawer_view/widgets/show_log_out_dialog.dart';

import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_saved_key.dart';
import '../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import '../../widgets/custom_text.dart';
import 'widgets/custom_setting_options.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({super.key});

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.sp),
              Row(
                children: [
                   Icon(
                    Icons.settings_outlined,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: CustomText(
                      text: 'application_settings'.tr(context),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.sp),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: CustomSettingOptions(
                        title: 'change_language'.tr(context),


                        onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context)=>
    ChangeLangView()))  ;                      },
                      ),
                    ),
                    ListTile(
                      title: BlocBuilder<SaveItCubit, SaveItState>(
                        builder: (context, state) {
                          var cubit = SaveItCubit.get(context);
                          return CustomSettingOptions(
                            title: 'dark_mode'.tr(context),
                            trailing: SizedBox(
                              height: 20.sp,
                              width: 35.sp,
                              child: Switch(
                                activeColor: Theme.of(context).primaryColor,
                                value: cubit.getBool(AppSavedKey.isDarkMode),
                                onChanged: (v) {
                                  cubit.saveBool(AppSavedKey.isDarkMode, v);
                                  AppNameRoute.controllerScreen.goAndReplaceAll(context);

                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const ListTile(
                      title: Divider(thickness: 2),
                    ),
                    ListTile(
                      title: GestureDetector(
                        onTap: () {
                          showLogOutDialog(context);
                        },
                        child: Row(
                          children: [
                            BlocBuilder<SaveItCubit, SaveItState>(
                              builder: (context, state) {
                                var cubit = SaveItCubit.get(context);
                                return Directionality(
                                  textDirection: cubit.getLang() == 'en'
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                                  child: Icon(Icons.logout)
                                );
                              },
                            ),
                            SizedBox(width: 10.sp),
                            CustomText(
                              color: AppColors.red,
                              text: 'sign_out'.tr(context),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      title: GestureDetector(
                        onTap: () {
                          showDeleteAccountDialog(context);
                        },
                        child: Row(
                          children: [
                            BlocBuilder<SaveItCubit, SaveItState>(
                              builder: (context, state) {
                                var cubit = SaveItCubit.get(context);
                                return Directionality(
                                    textDirection: cubit.getLang() == 'en'
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                    child: const Icon(
                                      Icons.delete_forever_outlined,

                                    ));
                              },
                            ),
                            SizedBox(width: 10.sp),
                            CustomText(
                              color: AppColors.red,
                              text: 'Delete_Account'.tr(context),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
