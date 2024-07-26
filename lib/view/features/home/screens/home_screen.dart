import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/constants/app_colors.dart';
import 'package:lms_flutter/helpers/extensions/navigation_extension.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/features/Auth/logic/cubit/auth_cubit.dart';
import 'package:lms_flutter/view/features/home/widgets/app_bar.dart';
import 'package:lms_flutter/view/features/home/widgets/search.dart';
import 'package:lms_flutter/view/features/home/widgets/slider.dart';
import 'package:lms_flutter/view/features/home/widgets/title_and_actions.dart';
import 'package:lms_flutter/view/widgets/custom_text.dart';

import '../../../../helpers/constants/app_sizes.dart';
import '../../../../helpers/router/app_name_route.dart';
import '../../drawer_view/drawer_view.dart';
import '../../subscriptions/logic/cubit/subscriptions_cubit.dart';
import '../../subscriptions/widgets/cources_content.dart';
import '../logic/cubit/home_cubit.dart';
import '../logic/cubit/home_state.dart';
import '../widgets/banner.dart';
import '../widgets/shimmer_teacher_card_list_view_loading.dart';

class HomeScreen extends StatefulWidget {
  final GlobalKey<State<StatefulWidget>>? two;

  const HomeScreen({super.key, this.two});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    AuthCubit.get(context).FCMtoken(context);
    HomeCubit.get(context).getAllCourses(context: context, page: 1);
    SubscriptionsCubit.get(context).getAllSubscriptions(context: context,type: "course");
    super.initState();
  }

  final scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldkey,
        drawer: const DrawerView(),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: SizedBox(
                width: AppSize.width(context),
                height: AppSize.height(context),
                child:  RefreshIndicator(
                onRefresh: () async {
    await     HomeCubit.get(context).getAllCourses(context: context, page: 1);

    },child:SingleChildScrollView(
                  child: Column(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          CustomAppBar(
                            isHome: true,
                            two: scaffoldkey,
                          ),
                         // SizedBox(height: 10.sp),
                          // CustomHomeFilterAndSearch(
                          //   isFromHome: true,
                          // ),

                          //SizedBox(height: 10.sp),
                          Padding(
                            padding: EdgeInsets.only(left: 8, right: 8),
                            child: Divider(thickness: 1, color: Colors.black26),
                          ),
                          SizedBox(height: 10.sp),
                          OfferBannerWidget(),
                          Container(
                            padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "newly_added".tr(context),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ]),
                          ),
                          BlocBuilder<HomeCubit, HomeStates>(

                                  builder: (context, state) {
                                    if (state is LoadingState) {
                                      return ShimmerTeacherCardListViewLoading();
                                    } else if (state is LoadedState) {
                                      final courses =
                                          context.read<HomeCubit>().cources;

                                      return SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            courses.length != 0
                                                ? AutomaticSliderCard(
                                                  height: AppSize.height(context) * .15,
                                                  duration: Duration(seconds: 2),
                                                  children: [
                                                    for (int i = courses.length - 1; i >= 0; i--)
                                                      CourceCardContent(
                                                        c: AppColors.bestSellerBgColor,
                                                        img: courses[i]["image"],
                                                        name: courses[i]["name"],
                                                        price: "${courses[i]["price"]}",
                                                        context: context,
                                                        index: i,
                                                        id: courses[i]["id"],
                                                        newlyadded: true,
                                                        time: "",
                                                      ),
                                                  ],
                                                )
                                                : CustomText(
                                                    text:
                                                        "no-courses".tr(context)),
                                            SizedBox(height: 5.sp),
                                            ClipOval(
                                              child: Container(
                                                height: 7,
                                                width: 7,
                                                color: AppColors.mainAppColor,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            CustomTitleAndActions(
                                              "courses".tr(context),
                                              true,
                                              'see_all'.tr(context),
                                              () {
                                                AppNameRoute.allCoursesScreen
                                                    .go(context);
                                              },
                                            ),
                                            courses.length != 0
                                                ? GridView.builder(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: courses.length,
                                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2, // number of columns
                                                childAspectRatio: 1, // width/height ratio of each item
                                              ),
                                              itemBuilder: (context, index) {
                                                return CourceCardContent(
                                                  c: Colors.white,
                                                  img: courses[index]["image"],
                                                  name: courses[index]["name"],
                                                  price: "${courses[index]["price"]}",
                                                  instructor: "${courses[index]["instructor"]}",
                                                  context: context,
                                                  id: courses[index]["id"],
                                                  index: index,
                                                  time: "",
                                                );
                                              },
                                            )
                                                : Column(children: [
                                                    //Image.asset("assets/images/no_cources.png"),
                                                    SizedBox(height: 10.sp),
                                                    CustomText(
                                                      text: "no-courses"
                                                          .tr(context),
                                                      fontSize: 16.sp,
                                                    ),
                                                  ]),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Column(children: [
                                        SizedBox(height: 50.sp),
                                        CustomText(
                                          text: "wrong".tr(context),
                                          fontSize: 16.sp,
                                        ),
                                      ]);
                                    }
                                  })
                        ])
                  ]),
                )))));
  }
}
