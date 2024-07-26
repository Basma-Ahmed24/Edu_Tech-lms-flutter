import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_flutter/helpers/constants/app_sizes.dart';
import 'package:lms_flutter/helpers/extensions/tr_extension.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../Auth/widgets/states_handeling.dart';
import '../../subscriptions/logic/cubit/subscriptions_cubit.dart';
import '../../subscriptions/logic/cubit/subscriptions_state.dart';
import '../../subscriptions/screens/subscription_Screen.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({Key? key}) : super(key: key);

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  final GlobalKey _gLobalkey = GlobalKey();
  QRViewController? controller;
  Barcode? result;
  int count = 0;
  void qr(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      setState(() {
        result = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionsCubit, SubscriptionsState>(

     builder: (context, state) {
      if (result != null) count++;
      if (result != null && count == 1) {
        SubscriptionsCubit.get(context)
            .sendCode(context: context,code: result!.code.toString(),callback:callback,errorCallback: errorCallback );
        Navigator.pop(context);
      }
      return Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: AppSize.height(context) / 1.1,
              width: AppSize.width(context),
              child: QRView(key: _gLobalkey, onQRViewCreated: qr),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: result != null
                    ? Text('${result!.code}')
                    : const Text('Scan a code'),
              ),
            )
          ],
        ),
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
