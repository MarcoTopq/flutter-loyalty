import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:warnakaltim/main.dart';

class Qrcode extends StatefulWidget {
  final String url;
  Qrcode({
    Key key,
    this.url,
  }) : super(key: key);

  @override
  _QrcodeState createState() => _QrcodeState();
}

class _QrcodeState extends State<Qrcode> {
  var gold = Color.fromRGBO(
    212,
    175,
    55,
    2,
  );
  @override
  Widget build(BuildContext context) {
    print(widget.url);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          'QR CODE',
          style: new TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black.withOpacity(0.5),
      ),
      backgroundColor: Colors.grey[850],
      body: new WebviewScaffold(
        url: widget.url,
      ),
    );
  }
}
