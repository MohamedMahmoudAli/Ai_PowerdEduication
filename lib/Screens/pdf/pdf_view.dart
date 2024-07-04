import 'package:flutter/material.dart';
import 'package:hieroglyphic_app/compenets/constant/colors.dart';
import "package:syncfusion_flutter_pdfviewer/pdfviewer.dart";

class PdfViewer extends StatefulWidget {
  static const String routeName = 'pdf2';

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<PdfViewer> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pdfUrl = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text(' PDF Viewer'),
        centerTitle: true,
      ),
      body: SfPdfViewer.network(
        pdfUrl,
        key: _pdfViewerKey,
      ),
    );
  }
}
