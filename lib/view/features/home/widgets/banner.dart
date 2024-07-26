import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/view/features/home/widgets/shimmer_banner.dart';

import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_images.dart';
import '../../../../helpers/constants/app_sizes.dart';
import '../../../widgets/custom_text.dart';
import '../logic/cubit/home_cubit.dart';
import '../logic/cubit/home_state.dart';

class OfferBannerWidget extends StatefulWidget {
  const OfferBannerWidget({super.key});

  @override
  State<OfferBannerWidget> createState() => _OfferBannerWidgetState();
}

class _OfferBannerWidgetState extends State<OfferBannerWidget> {
  @override
  void initState() {
    HomeCubit.get(context).getAllBars(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return state is LoadingState
            ? const ShimmerOfferBannerWidget()
            : cubit.Bars.isEmpty
            ? Container()
            : Container(
          margin: EdgeInsets.only(
            left: 16.sp,
            right: 16.sp,
            bottom: 10.sp,
          ),
          padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
          height: AppSize.height(context) * .15,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/WhatsApp Image 2023-11-03 at 22.29.27_23a73831.jpg"),fit:
            BoxFit.fill),
           // color: AppColors.mainAppColor,
            borderRadius: BorderRadius.circular(20.sp),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 5,
            ),
            alignment: Alignment.center,
            child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
              ),
              items: cubit.Bars.map<Widget>( // Explicitly cast to List<Widget>
                    (item) => Center(
                      child: CustomText(
                  text: item['body'].toString(), // Changed from 'item.body.toString()' to 'item['body'].toString()'
                 isMultiLines: true,
                  color: Colors.white,
                ),
                    ),
              ).toList(),
            ),
          ),
        );
      },
    );
  }
}