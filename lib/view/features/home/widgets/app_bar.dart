import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lms_flutter/helpers/extensions/navigation_extension.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/features/home/widgets/payment_dialog.dart';
import 'package:lms_flutter/view/features/home/widgets/search.dart';
import '../../../../helpers/constants/app_color_theme.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_images.dart';
import '../../../../helpers/constants/app_sizes.dart';
import '../../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import '../../../../helpers/router/app_name_route.dart';
import '../../../widgets/custom_text.dart';
import '../../search/search_screen.dart';
class CustomAppBar extends StatelessWidget {
  final GlobalKey<State<StatefulWidget>>? two;

  final String? title;
  final bool isText;
  final bool isNoPadding;
  final bool isGoBack;
  final bool isWhite;
  final bool isHome;
  final bool isTab;
  final bool isSubscription;
  final bool isNotLeading;

  const CustomAppBar({
    super.key,
    this.title,
    this.isNoPadding = false,
    this.isNotLeading = false,
    this.isGoBack = false,
    this.isText = false,
    this.isWhite = false,
    this.isHome = false,
    this.isTab = false,
    this.isSubscription = false,
    this.two,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaveItCubit, SaveItState>(
      builder: (context, state) {
        return Container(
          padding: isNoPadding
              ? const EdgeInsets.all(0)
              : EdgeInsets.only(left: 16.sp, right: 16.sp),
          height: 50.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isNotLeading
                  ? Container()
                  : !isGoBack
                  ? SizedBox(
                width: AppSize.width(context) * .3,
                child: isHome?
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Icon(Icons.sort,size: 30,
                        // ignore: deprecated_member_use
                        color: isWhite
                            ? Colors.white
                            : AppColorTheme.blackAndWhiteSwitchTheme(
                            context),
                      ),
                    ),
                  ],
                ):Container(),
              )
                  : GestureDetector(
                onTap: () {
                  if (isTab) {
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: isWhite
                      ? Colors.white
                      : AppColorTheme.blackAndWhiteSwitchTheme(
                      context),
                ),
              ),

              !isText
                  ? isSubscription?
                  Flexible(
                    child: CustomText(
                      text: "${"my_subscriptions".tr(context)}                 " ?? "",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      isMultiLines: true,
                    ),
                  ):
              Expanded(
                child: GestureDetector(onTap: (){
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchView()));
                },
                  child: CustomHomeFilterAndSearch(
                    isFromHome: true,
                  ),
                ),
              )
                  : Flexible(
                    child: CustomText(
                      text: "${title}                           " ?? "",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: isWhite
                          ? Colors.white
                          : AppColorTheme.blackAndWhiteSwitchTheme(context),
                    ),
                  ),

              !isHome
                  ? Container()
                  : Container(
                alignment: Alignment.centerRight,
                width: AppSize.width(context) * .3,
                child:  InkWell(onTap: (){

                  showDialog(
                      context: context,
                      builder: (context) {
                        return PaymentDialog();
    }
                   );

                },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.qr_code_scanner,size: 35,),

                      // Hero(
                      //   tag: 'search_hero',
                      //   child: SvgPicture.asset(
                      //     AppImages.search,
                      //   ),
                      // ),
                     // CustomText(text: "scan_code".tr(context))
                    ],
                  ),
                ),
              )

            ],
          ),
        );
      },
    );
  }
}


