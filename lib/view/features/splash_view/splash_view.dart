import 'package:flutter/material.dart';

import '../../../helpers/constants/app_saved_key.dart';
import '../../../helpers/constants/app_sizes.dart';
import '../../../helpers/extensions/navigation_extension.dart';
import '../../../helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import '../../../helpers/router/app_name_route.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    var isLoggedIn =
        SaveItCubit.get(context).sharedPreferences.getString(AppSavedKey.token);
    print(isLoggedIn);
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        if (isLoggedIn != null && isLoggedIn.isNotEmpty) {
          AppNameRoute.controllerScreen.goAndReplaceAll(context);
        } else {
          AppNameRoute.signInScreen.goAndReplaceAll(context);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: AppSize.width(context),
        height: AppSize.height(context),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/app_icon.png",
            ),
          ),
        ),
      ),
    );
  }
}
