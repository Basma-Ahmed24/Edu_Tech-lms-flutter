import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_flutter/helpers/constants/app_colors.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:lms_flutter/view/features/Auth/widgets/text_field.dart';
import 'package:lms_flutter/view/widgets/custom_text.dart';

import '../../../../helpers/constants/app_sizes.dart';
import '../../Auth/widgets/states_handeling.dart';
import '../../subscriptions/logic/cubit/subscriptions_cubit.dart';
import '../../subscriptions/logic/cubit/subscriptions_state.dart';
import '../../subscriptions/screens/subscription_Screen.dart';
import 'QRCodeScannerPage.dart';

class PaymentDialog extends StatefulWidget {
  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  @override
  TextEditingController code = TextEditingController();
  var result;
  bool done = false;
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionsCubit, SubscriptionsState>(
        builder: (context, state) {
      return AlertDialog(
        title: Center(child: CustomText(text: "buy_course".tr(context))),
        content: SingleChildScrollView(
          child: Form(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextField(
                    hintText: "enter_code".tr(context),
                    isBuyCourse: true,
                    validator: (v) {},
                    controller: code,
                    onSendTap: () {
                      if (code.text != "") {
                        SubscriptionsCubit.get(context).sendCode(
                            context: context,
                            code: code.text,
                            callback: callback,
                            errorCallback: errorCallback);
                      } else {
                        CustomToast(
                            "please_enter_code".tr(context), Colors.red);
                      }
                    },
                  ),
                  SizedBox(height: 10.sp),
                  CustomText(
                    text: "scan_code_dialog".tr(context),
                    maxLines: 3,
                    fontSize: 13.sp,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QrCodeScreen()));
                    },
                    child: CustomText(text: "scan_code".tr(context)),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      fixedSize: Size(AppSize.width(context) / 4,
                          AppSize.height(context) / 30),
                      backgroundColor: AppColors.mainAppColor,
                    ),
                  )
                ]),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: CustomText(text: "exit".tr(context)),
          ),
        ],
      );
    });
  }

  callback() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Subscriptions()));
  }

  errorCallback() {
    Navigator.pop(context);
  }
}
