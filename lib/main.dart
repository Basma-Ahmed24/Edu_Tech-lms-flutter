import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lms_flutter/helpers/dio/dio_client.dart';
import 'package:lms_flutter/helpers/extensions/print_extention.dart';

import 'package:usb_serial/usb_serial.dart';
import 'package:vpn_check/vpn_check.dart';
import 'helpers/constants/app_endpoint.dart';
import 'helpers/provider/cubits/save_it_cubit/save_it_cubit.dart';
import 'helpers/router/app_name_route.dart';
import 'view/features/splash_view/splash_view.dart';
import 'helpers/app_notification.dart';
import 'helpers/constants/app_saved_key.dart';
import 'helpers/dio/http_overrides/http_override.dart';
import 'helpers/provider/app_providers.dart';
import 'helpers/provider/injection.dart';
import 'helpers/router/app_router.dart';
import 'helpers/theme/dark_theme.dart';
import 'helpers/theme/light_theme.dart';
import 'helpers/utils/app_local_helper.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await initGetIt();
  await MyNotification.initialise();
  FirebaseMessaging.onBackgroundMessage(MyNotification.onBackgroundMessage);

  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
  // disableCapture();
}

// disableCapture() async {
//   await FlutterWindowManager.addFlags(
//     FlutterWindowManager.FLAG_SECURE,
//   );
// }

class MyApp extends StatefulWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool isNotRealDevice = false;
  bool isJailBroken = false;
  bool isHasInternet = false;
  bool isVpnActive = false;
  bool isDevModeActive = false;
  bool isUsbConnected = false;

  _checkRealDevice() async {
    AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    setState(() {
      isNotRealDevice = !androidInfo.isPhysicalDevice;
    });
    return androidInfo.isPhysicalDevice;
  }

  _checkJailBreak() async {
    await FlutterJailbreakDetection.jailbroken.then((value) {
      setState(() {
        isJailBroken = value;
      });
    });
  }

  _checkUsbConnection() async {
    if (Platform.isAndroid) {
      await UsbSerial.listDevices().then((value) {
        if (value.isEmpty == isUsbConnected) {
          setState(() {
            isUsbConnected = value.isNotEmpty;
          });
        }
      });
    }
  }

  _getVpnState() async {
    var value = await VPNChecker().isVPNEnabled();
    setState(() {
      isVpnActive = value;
    });
  }

  _getCurrentConnection() async {
    var value = await InternetConnectionChecker().hasConnection;
    setState(() {
      isHasInternet = value;
    });
  }

  _getIsDevModeActive() async {
    await FlutterJailbreakDetection.developerMode.then((value) {
      setState(() {
        isDevModeActive = value;
      });
    });
  }

  @override
  void initState() {
    MyNotification.getInitialMessage();
    // _checkRealDevice();
    // _checkJailBreak();
    // _getCurrentConnection();
    // _getVpnState();
    // _getIsDevModeActive();
    // _checkUsbConnection();
    // Timer.periodic(const Duration(seconds: 30), (_) {
    //   _checkUsbConnection();
    // });
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    // _checkRealDevice();
    // _checkJailBreak();
    // _getCurrentConnection();
    // _getVpnState();
    // _getIsDevModeActive();
    // _checkUsbConnection();
  }

  @override
  Widget build(BuildContext context) {
    ' is not Real = $isNotRealDevice\n jail broken = $isJailBroken\n has internet = $isHasInternet\n devmode = $isDevModeActive\n vpn = $isVpnActive\n usb = $isUsbConnected'
        .dePrint;
    return MultiBlocProvider(
      providers: appProviders(),
      child: BlocBuilder<SaveItCubit, SaveItState>(
        builder: (context, state) {
          var cubit = SaveItCubit.get(context);
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: cubit.getBool(AppSavedKey.isDarkMode)
                  ? Brightness.light
                  : Brightness.dark,
            ),
          );
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: false,
            builder: (BuildContext context, Widget? child) {
              return MaterialApp(
                title: 'First Step',
                locale: Locale(cubit.getLang()),
                supportedLocales: AppLocalHelper.supportedLocales(),
                localizationsDelegates: AppLocalHelper.localizationsDelegates(),
                localeResolutionCallback: AppLocalHelper.resolutionCallback(),
                theme: cubit.getBool(AppSavedKey.isDarkMode) ? dark : light,
                debugShowCheckedModeBanner: false,
                onGenerateRoute: AppRouter.generatorRoutes,
                initialRoute: AppNameRoute.splashScreen,
              );
              // todo remove any !

              // return isNotRealDevice ||
              //         isUsbConnected ||
              //         isDevModeActive ||
              //         isJailBroken
              //     ? MaterialApp(
              //         title: 'First Step',
              //         locale: Locale(cubit.getLang()),
              //         supportedLocales: AppLocalHelper.supportedLocales(),
              //         localizationsDelegates:
              //             AppLocalHelper.localizationsDelegates(),
              //         localeResolutionCallback:
              //             AppLocalHelper.resolutionCallback(),
              //         theme:
              //             cubit.getBool(AppSavedKey.isDarkMode) ? dark : light,
              //         debugShowCheckedModeBanner: false,
              //         home: TempSplashScreen(
              //           message: isNotRealDevice
              //               ? 'Please use a real device'
              //               : isUsbConnected
              //                   ? "Please Remove the Usb"
              //                   : isDevModeActive
              //                       ? "Please Disable Developer Mode"
              //                       : isJailBroken
              //                           ? "Please unroot your device or use another device"
              //                           : "Please Fix your Device",
              //         ),
              //       )
              //     : StreamBuilder<bool>(
              //         stream: VPNChecker().vpnActivityStream,
              //         builder: (context, snapshot) {
              //           return isVpnActive || snapshot.data == true
              //               ? MaterialApp(
              //                   title: 'First Step',
              //                   locale: Locale(cubit.getLang()),
              //                   supportedLocales:
              //                       AppLocalHelper.supportedLocales(),
              //                   localizationsDelegates:
              //                       AppLocalHelper.localizationsDelegates(),
              //                   localeResolutionCallback:
              //                       AppLocalHelper.resolutionCallback(),
              //                   theme: cubit.getBool(AppSavedKey.isDarkMode)
              //                       ? dark
              //                       : light,
              //                   debugShowCheckedModeBanner: false,
              //                   home: const TempSplashScreen(isVpn: true),
              //                 )
              //               : StreamBuilder<ConnectivityResult>(
              //                   stream: Connectivity().onConnectivityChanged,
              //                   builder: (context, snapshot) {
              //                     return !isHasInternet ||
              //                             snapshot.data ==
              //                                 ConnectivityResult.none
              //                         ? MaterialApp(
              //                             title: 'First Step',
              //                             locale: Locale(cubit.getLang()),
              //                             supportedLocales:
              //                                 AppLocalHelper.supportedLocales(),
              //                             localizationsDelegates: AppLocalHelper
              //                                 .localizationsDelegates(),
              //                             localeResolutionCallback:
              //                                 AppLocalHelper
              //                                     .resolutionCallback(),
              //                             theme: cubit.getBool(
              //                                     AppSavedKey.isDarkMode)
              //                                 ? dark
              //                                 : light,
              //                             debugShowCheckedModeBanner: false,
              //                             home: NoInternetScreen(
              //                               callbak: () {
              //                                 _getCurrentConnection();
              //                               },
              //                             ),
              //                           )
              //                         : StreamBuilder<bool>(
              //                             stream:
              //                                 VPNChecker().vpnActivityStream,
              //                             builder: (context, snapshot) {
              //                               return MaterialApp(
              //                                 title: 'First Step',
              //                                 locale: Locale(cubit.getLang()),
              //                                 supportedLocales: AppLocalHelper
              //                                     .supportedLocales(),
              //                                 localizationsDelegates:
              //                                     AppLocalHelper
              //                                         .localizationsDelegates(),
              //                                 localeResolutionCallback:
              //                                     AppLocalHelper
              //                                         .resolutionCallback(),
              //                                 theme: cubit.getBool(
              //                                         AppSavedKey.isDarkMode)
              //                                     ? dark
              //                                     : light,
              //                                 debugShowCheckedModeBanner: false,
              //                                 onGenerateRoute:
              //                                     AppRouter.generatorRoutes,
              //                                 initialRoute:
              //                                     AppNameRoute.splashScreen,
              //                               );
              //                             },
              //                           );
              //                   },
              //                 );
              //         },
              //       );
            },
          );
        },
      ),
    );
  }
}