import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/constants/app_colors.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/features/cources/screens/cource_content_screen.dart';
import 'package:lms_flutter/view/features/search/widgets/custom_search.dart';
import '../../../helpers/constants/app_color_theme.dart';
import '../../../helpers/constants/app_sizes.dart';
import '../../../helpers/utils/handel_user_data_.dart';
import '../../widgets/custom_text.dart';
import 'logic/cubit/search_cubit.dart';
import 'logic/cubit/search_state.dart';

class SearchView extends StatefulWidget {
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  dynamic data;

  TextEditingController name = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
          width: AppSize.width(context),
          height: AppSize.height(context),
          child: Column(
            children: [
              SizedBox(height: 30.sp),
              Row(
                children: [
                  Expanded(
                    child: CustomSearch(
                      controller: name,
                      onTapSearch: () async {
                        if (SearchCubit.get(context).data != null)
                          SearchCubit.get(context).data.clear();
                        SearchCubit.get(context).searchCourse(context, name);
                      },
                      onChanged: (v) {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.sp),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  bloc: SearchCubit.get(context),
                  builder: (context, state) {
                    return state is SearchLoadingState
                        ? Center(
                            child: const CircularProgressIndicator(
                              color: AppColors.mainAppColor,
                            ),
                          )
                        : state is SearchLoadedState
                            ? SearchCubit.get(context).data.length > 0
                                ? RefreshIndicator(
                                    onRefresh: () async {
                                      SearchCubit.get(context)
                                          .searchCourse(context, name);
                                    },
                                    child: ListView.builder(
                                      padding:
                                          const EdgeInsets.only(bottom: 40),
                                      itemCount:
                                          SearchCubit.get(context).data!.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CourseContent(SearchCubit
                                                              .get(context)
                                                          .data[index]["id"])),
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                              top: 10.sp,
                                              bottom: 10.sp,
                                            ),
                                            width: AppSize.width(context),
                                            decoration: const BoxDecoration(),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                          "https://markbackend.faheemacademy.online${SearchCubit.get(context).data![index]["image"]}",
                                                        ),
                                                        radius: 30.sp,
                                                      ),
                                                      SizedBox(width: 10.sp),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                                height: 5.sp),
                                                            CustomText(
                                                              text:
                                                                  ' ${SearchCubit.get(context).data![index]["name"] ?? "no name"}',
                                                              fontSize: 14.sp,
                                                              color: AppColorTheme
                                                                  .grayTextColorTheme(
                                                                      context),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            SizedBox(
                                                                height: 5.sp),
                                                            // CustomText(
                                                            //   text: GetUserSpecialization.get(
                                                            //       context,
                                                            //       SearchCubit.get(context)
                                                            //                   .data![index]
                                                            //               [
                                                            //               "subject"] ??
                                                            //           ""),
                                                            //   fontSize: 10.sp,
                                                            // ),
                                                            // CustomText(
                                                            //   text:
                                                            //       '${SearchCubit.get(context).data![index]["year"]!}',
                                                            //   color: Theme.of(
                                                            //           context)
                                                            //       .primaryColor,
                                                            //   fontSize: 12.sp,
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CustomText(
                                                      text:
                                                          '${SearchCubit.get(context).data![index]["price"]!}',
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 12.sp,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : CustomText(
                                    text: 'not_found'.tr(context),
                                  )
                            : CustomText(
                                text: "",
                              );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
