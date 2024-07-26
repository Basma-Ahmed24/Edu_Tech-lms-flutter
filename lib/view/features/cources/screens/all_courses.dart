import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/constants/app_colors.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/features/subscriptions/widgets/cources_content.dart';
import 'package:lms_flutter/view/widgets/custom_text.dart';
import '../../../../helpers/constants/app_sizes.dart';
import '../../home/logic/cubit/home_cubit.dart';
import '../../home/logic/cubit/home_state.dart';
import '../../home/widgets/app_bar.dart';
import '../../home/widgets/search.dart';

class AllCources extends StatefulWidget {
  @override
  @override
  State<AllCources> createState() => _AllCourcesState();
}

class _AllCourcesState extends State<AllCources> {
  final scrollController = ScrollController();
  int page = 1;
  bool isloadingMore = false;
  dynamic cources;
  @override
  void initState() {
    HomeCubit.get(context).getAllCourses(context: context, page: page);
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          width: AppSize.width(context),
          height: AppSize.height(context),
          child: SingleChildScrollView(
              child: Column(
            children: [
              BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
                if (state is LoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.mainAppColor,
                    ),
                  );
                } else if (state is LoadedState) {
                  cources = context.read<HomeCubit>().cources;
                  if (cources.length == 0) {
                    cources = null;
                  }

                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomAppBar(
                          isText: true,
                          title: "courses".tr(context),
                        ),
                        SizedBox(height: 15.sp),
                        CustomHomeFilterAndSearch(
                          isFromHome: false,
                        ),
                        SizedBox(height: 10.sp),
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                SizedBox(height: 10.sp),
                                cources != null
                                    ? ListView.builder(
                                        controller: scrollController,
                                        itemCount: isloadingMore
                                            ? cources!.length + 1
                                            : cources!.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          if (index < cources!.length) {
                                            return CourceCardContent(
                                                c: Colors.white,
                                                img:
                                                    "${cources[index]["image"]}",
                                                name: cources[index]["name"],

                                                price:
                                                    "${cources[index]["price"]}",
                                                instructor:
                                                    "${cources[index]["instructor"]}",
                                                context: context,
                                                id: cources[index]["id"],
                                                time: "");
                                          } else {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.mainAppColor,
                                              ),
                                            );
                                          }
                                        },
                                      )
                                    : Column(children: [
                                        SizedBox(height: 10.sp),
                                        CustomText(
                                          text: "no-courses".tr(context),
                                          fontSize: 16.sp,
                                        ),
                                      ]),
                              ],
                            ))
                      ]);
                } else {
                  return Column(children: [
                    SizedBox(height: 10.sp),
                    CustomText(
                      text: "wrong".tr(context),
                      fontSize: 16.sp,
                    ),
                  ]);
                }
              })
            ],
          )),
        ),
      ),
    );
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (!isloadingMore) {
        setState(() {
          isloadingMore = true;
        });
        page = page + 1;
        final cubit = HomeCubit.get(context);
        await cubit.getAllCourses(context: context, page: page);
        if (cubit.cources != null) {
          setState(() {
            cources.addAll(cubit.cources!);
            isloadingMore = false;
          });
        } else {
          setState(() {
            isloadingMore = false;
          });
        }
      }
    } else {}
  }
}
