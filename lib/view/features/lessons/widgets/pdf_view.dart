import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../helpers/constants/app_sizes.dart';

class PdfView extends StatefulWidget {
  const PdfView({super.key, required this.fileUrl});

  final String fileUrl;
  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: AppSize.width(context),
            height: AppSize.height(context),
            child: SfPdfViewer.network(
              widget.fileUrl,
            ),
          ),
        ),
      ),
    );
  }
}
