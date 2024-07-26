import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:usb_serial/usb_serial.dart';
import 'package:vpn_check/vpn_check.dart';

class AppSecurity {
  static bool isEmulator = false;
  static bool isJailBroken = false;
  static bool isDisconnected = false;
  static bool isVpnActive = false;
  static bool isDevModeActive = false;
  static bool isUsbConnected = false;

  static Future<void> checkRealDevice() async {
    AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    isEmulator = !androidInfo.isPhysicalDevice;
  }

  static Future<void> checkJailBreak() async {
    await FlutterJailbreakDetection.jailbroken.then((value) {
      isJailBroken = value;
    });
  }

  static Future<void> checkUsbConnection() async {
    if (Platform.isAndroid) {
      await UsbSerial.listDevices().then((value) {
        if (value.isEmpty == isUsbConnected) {
          isUsbConnected = value.isNotEmpty;
        }
      });
    }
  }

  static Future<void> getVpnState() async {
    var value = await VPNChecker().isVPNEnabled();
    isVpnActive = value;
  }

  static Future<void> getCurrentConnection() async {
    var value = await InternetConnectionChecker().hasConnection;
    isDisconnected = !value;
  }

  static Future<void> getIsDevModeActive() async {
    await FlutterJailbreakDetection.developerMode.then((value) {
      isDevModeActive = value;
    });
  }

  static checkSafety() async {
    getVpnState();
    checkJailBreak();
    checkRealDevice();
    getIsDevModeActive();
    getCurrentConnection();
    Timer.periodic(const Duration(seconds: 30), (_) {
      checkUsbConnection();
    });
  }

  static bool hasProblem() {
    return isEmulator || isJailBroken || isDevModeActive || isUsbConnected;
  }
}
