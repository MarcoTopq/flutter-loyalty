import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
// import 'package:warnakaltim/src/model/profileDetailModel.dart';
// import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';


class CompanyDetail extends StatefulWidget {
  final url;
  final token;
  CompanyDetail({
    Key key,
    this.url,
    this.token,
  }) : super(key: key);

  @override
  _CompanyDetailState createState() => _CompanyDetailState();
}

class _CompanyDetailState extends State<CompanyDetail> {
  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    changePDF(2);
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    // document = await PDFDocument.fromAsset('assets/sample.pdf');

    setState(() => _isLoading = false);
  }

  changePDF(value) async {
    setState(() => _isLoading = true);
    if (value == 1) {
      document = await PDFDocument.fromAsset('assets/sample2.pdf');
    } else if (value == 2) {
      document = await PDFDocument.fromURL(
          "http://rpm.lensaborneo.id/uploads/profile/16036658023._BAB_II.pdf");
    } else {
      document = await PDFDocument.fromAsset('assets/sample.pdf');
    }
    setState(() => _isLoading = false);
  }

  var gold = Color.fromRGBO(
    212,
    175,
    55,
    2,
  );

  @override
  Widget build(BuildContext context) {
    // loadDocument();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          'Profile Company',
          style: new TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black.withOpacity(0.5),
      ),
      backgroundColor: Colors.grey[850],
      body: Center(
        child: Center(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : PDFViewer(document: document)),
      ),

    );
  }
}
