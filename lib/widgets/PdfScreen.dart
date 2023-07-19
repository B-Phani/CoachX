import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:ui' as ui;
import 'dart:html';

class DisplayPdf extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DisplayPdfState();
}

class _DisplayPdfState extends State<DisplayPdf> {
  _DisplayPdfState() {}

  @override
  void initState() {
    super.initState();
  }

  // Widget _pdf() {
  //   return Scaffold(
  //     body: Container(
  //       child: SfPdfViewer.asset('assets/one.pdf'),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // return _pdf();
    return Scaffold();
  }
}

class DisplayWebsite extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DisplayWebsite();
}

class _DisplayWebsite extends State<DisplayWebsite> {
  _DisplayWebsite() {
    ui.platformViewRegistry.registerViewFactory('CoachX', (int viewId) {
      var CoachX = IFrameElement();
      CoachX.width = '640';
      CoachX.height = '360';
      CoachX.src = 'https://coachx.live/';
      return CoachX;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Widget CoachX() {
    return Scaffold(
      body: Container(
        child: HtmlElementView(viewType: 'CoachX'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CoachX();
  }
}
