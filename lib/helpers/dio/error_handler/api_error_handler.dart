// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:lms_flutter/helpers/extensions/navigation_extension.dart';
// import 'package:lms_flutter/helpers/extensions/print_extention.dart';
// import 'package:quickalert/models/quickalert_type.dart';
// import 'package:quickalert/widgets/quickalert_dialog.dart';
//
// import '../../router/app_name_route.dart';
// import '../../utils/error_message_dialog.dart';
//
// class ApiErrorHandler {
//   static String getMessage(
//       BuildContext context,
//       Exception error, {
//         bool isSignIn = false,
//         bool isRegister = false,
//         bool isQuickAlert = false,
//       }) {
//     callback() {
//       Navigator.pop(context);
//       AppNameRoute.signInScreen.goAndReplaceAll(context);
//     }
//
//     errorCallback() {
//       Navigator.pop(context);
//     }
//
//     dynamic errorDescription = "";
//
//     // ignore: unnecessary_type_check
//     if (error is Exception) {
//       '**ERROR:** $error'.dePrint;
//       try {
//         if (error is DioException) {
//           switch (error.type) {
//             case DioExceptionType.sendTimeout:
//               errorDescription = "Send timeout with server";
//               break;
//             case DioExceptionType.badCertificate:
//               errorDescription = "bad certificate";
//               break;
//             case DioExceptionType.connectionError:
//               errorDescription = "connection Error";
//               break;
//             case DioExceptionType.cancel:
//               errorDescription = "Request to API server was cancelled";
//               break;
//             case DioExceptionType.connectionTimeout:
//               errorDescription = "Connection timeout with API server";
//               break;
//             case DioExceptionType.unknown:
//               errorDescription =
//               "Connection to API server failed due to internet connection";
//               break;
//             case DioExceptionType.receiveTimeout:
//               errorDescription =
//               "Receive timeout in connection with API server";
//               break;
//             case DioExceptionType.badResponse:
//               switch (error.response!.statusCode) {
//                 case 404:
//                 case 500:
//                 case 503:
//                   errorDescription = error.response!.statusMessage;
//                   break;
//                 default:
//                   if (isRegister) {
//                     var theError = error.response!.data['errors'];
//                     if (theError != null) {
//                       var firstError = theError.keys.toList().first;
//                       var errorMessage = theError[firstError][0].toString();
//                       errorDescription = errorMessage;
//                     }
//                   } else if (isSignIn) {
//                     if (error.response!.data['errors'] != null &&
//                         error.response!.data['errors']['phone'] != null) {
//                       var phoneErrorMessage =
//                       error.response!.data['errors']['phone'];
//                       errorDescription = phoneErrorMessage;
//                     } else if (error.response!.data['errors'] != null &&
//                         error.response!.data['errors']['deviceId'] != null) {
//                       var deviceIdErrorMessage =
//                       error.response!.data['errors']['deviceId'][0];
//                       errorDescription = deviceIdErrorMessage;
//                     } else if (error.response!.data['message'] != null) {
//                       var theMessage = error.response!.data['message'];
//                       errorDescription = theMessage;
//                     }
//                   } else if (error.response!.data['message'] != null) {
//                     errorDescription = error.response!.data['message'];
//                     if (errorDescription == 'unauthenticated') {
//                       AuthCubit.get(context)
//                           .logOut(context, callback, errorCallback);
//                     }
//                   } else {
//                     errorDescription = error.response!.statusMessage;
//                   }
//               // var firstError = theError.keys.toList().first;
//               // var errorMessage = theError[firstError][0].toString();
//               // errorDescription = error.response!;
//               // if()
//
//               // errorDescription =
//               //     "Failed to load data - status code: ${error.response!.statusCode}";
//               }
//           }
//         } else {
//           errorDescription = "Unexpected error occured";
//         }
//       } on FormatException catch (e) {
//         errorDescription = e;
//       }
//     } else {
//       errorDescription = "is not a subtype of exception";
//     }
//
//     if (error is DioException) {
//       'eokgogkeropm ${error.requestOptions.path}'.dePrint;
//       'eokgogkeropm ${error.message}'.dePrint;
//       'eokgogkeropm ${error.response}'.dePrint;
//     } else {
//       'eokgogkeropm $error'.dePrint;
//     }
//     if (isSignIn || isRegister) {
//       ErrorMessageDialog.show(
//         context,
//         errorDescription,
//         isOkDialog: true,
//       );
//     } else if (isQuickAlert) {
//       QuickAlert.show(
//         confirmBtnColor: const Color(0xffDE0239),
//         customAsset: 'assets/gifs/error.gif',
//         context: context,
//         type: QuickAlertType.error,
//         title: 'Oops...',
//         text: errorDescription,
//       );
//     } else {
//       ErrorMessageDialog.show(
//         context,
//         errorDescription,
//         isOkDialog: true,
//       ).whenComplete(() {
//         if (errorDescription == 'unauthenticated') {
//           AuthCubit.get(context).logOut(context, () {
//             Navigator.pop(context);
//             AppNameRoute.signInScreen.goAndReplaceAll(context);
//           }, () {
//             Navigator.pop(context);
//           });
//         }
//       });
//       // SnackBarMessage.get(context, errorDescription);
//     }
//
//     return errorDescription;
//   }
// }
