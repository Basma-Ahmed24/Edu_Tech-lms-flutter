import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/features/home/screens/home_screen.dart';
import 'package:lms_flutter/view/features/profile/screens/profile_screen.dart';
import 'package:lms_flutter/view/features/subscriptions/screens/subscription_Screen.dart';

import '../../../helpers/constants/app_colors.dart';
import '../../widgets/custom_text.dart';
import '../statistics/screens/my_statistics_view.dart';

class MyNavigationBar extends StatefulWidget {
  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  var index = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics:
            NeverScrollableScrollPhysics(), // Prevent swiping between pages
        children: <Widget>[
          HomeScreen(),
          MyStatisticsView(),
          Subscriptions(),
          ProfileScreen(),
        ],
        onPageChanged: (int index) {
          setState(() {
            _pageController?.jumpToPage(index);
            this.index = index; // Update the index value
          });
        },
      ),
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.rtl,
        child: CurvedNavigationBar(
          index: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
           // Set the index to 0 for the home icon
          color:AppColors.mainAppColor,
          buttonBackgroundColor: AppColors.mainAppColor,
          animationDuration: const Duration(milliseconds: 300),
          animationCurve: Curves.easeInOut,
          height: MediaQuery.of(context).size.height / 15,
          items: [
            Icon(
              Icons.home_filled,
              size: 30,
              color: index == 0 ? AppColors.subMainAppColor  : Colors.white,
            ),
            //CustomText(text: "home".tr(context)),
            Icon(
              Icons.pie_chart,
              size: 30,
              color: index == 1 ? AppColors.subMainAppColor  : Colors.white,
            ),
           // CustomText(text: "my_statistics".tr(context)),
            Icon(
              Icons.list_alt,
              size: 30,
              color: index == 2 ? AppColors.subMainAppColor  : Colors.white,
            ),
           // CustomText(text: "my_subscriptions".tr(context)),
            Icon(
              Icons.person_outlined,
              size: 30,
              color: index == 3 ? AppColors.subMainAppColor : Colors.white,
            ),
            //CustomText(text: "my_profile".tr(context))
          ],
          onTap: (int index) {
            setState(() {
              _pageController?.jumpToPage(index);
              this.index = index; // Update the index value
            });
          },
        ),
      ),
    );
  }
}
