import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/features/home/widgets/shimmer_teacher_card_list_view_loading.dart';
import 'package:lms_flutter/view/features/subscriptions/widgets/cources_content.dart';
import 'package:lms_flutter/view/widgets/custom_text.dart';
import '../../../../helpers/constants/app_sizes.dart';
import '../../home/widgets/app_bar.dart';
import '../../home/widgets/search.dart';
import '../logic/cubit/subscriptions_cubit.dart';
import '../logic/cubit/subscriptions_state.dart';

class Subscriptions extends StatefulWidget {
  @override
  State<Subscriptions> createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  dynamic cources;
  @override
  void initState() {
    SubscriptionsCubit.get(context)
        .getAllSubscriptions(context: context, type: "Course");
    super.initState();
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
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                CustomAppBar(isSubscription: true),
                SizedBox(height: 15.sp),
                CustomHomeFilterAndSearch(),
                SizedBox(height: 10.sp),
                BlocBuilder<SubscriptionsCubit, SubscriptionsState>(
                    builder: (context, state) {
                  dynamic cources;
                  if (state is SubscriptionsLoadingState) {
                    return ShimmerTeacherCardListViewLoading();
                  } else if (state is SubscriptionsLoadedState) {
                    cources = context.read<SubscriptionsCubit>().cources;
                    print(context.read<SubscriptionsCubit>().cources);
                    if (cources.length == 0) {
                      cources = null;
                    }

                    return Column(
                      children: [
                        SizedBox(height: 10.sp),
                        cources != null
                            ?  GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cources.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // number of columns
                            childAspectRatio: 1, // width/height ratio of each item
                          ),
                          itemBuilder: (context, index) {
                            return CourceCardContent(
                                      c: Colors.white,
                                      img: cources[index]["course"]["image"],
                                      name: cources[index]["course"]["name"],
                                      subject:
                                          "(${cources[index]["course"]["subject"]})",
                                      year:
                                          "${cources[index]["course"]["year"]} ",
                                      specification:
                                          "${cources[index]["course"]["specialization"]}",
                                      price:
                                          "${cources[index]["course"]["price"]}",
                                      instructor:
                                          "${cources[index]["course"]["instructor"]}",
                                      context: context,
                                      id: cources[index]["course"]["id"],
                                      time: cources[index]["course"]
                                          ["duration"]);
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
                    );
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
              ])
            ],
          )),
        ),
      ),
    );
  }
}
