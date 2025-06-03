import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:encrypt/encrypt.dart' as enc;

class QrImageScreen extends StatelessWidget {
  const QrImageScreen({super.key, required this.s});
  final String s;
  //encryprtion key : 8332767606048159

  @override
  Widget build(BuildContext context) {
    //  List<String> list = s.split("|||");
    //using ARS symetric encryption
    var key = enc.Key.fromUtf8("8332767606048159");
    "8332767606048159";
    final iV = enc.IV.fromBase16(key.base16);
    final encrypter = enc.Encrypter(enc.AES(key));

    final encrypted = encrypter.encrypt(s, iv: iV);
    // final decripted = encrypter.decrypt64(encrypted.base64, iv: iV);
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            SizedBox(height: 100),

            // RepaintBoundary(
            //   child: Center(
            //     child: QrImageView(
            //       data: s,
            //       version: QrVersions.auto,
            //       size: 300,
            //     ),
            //   ),
            // ),
            RepaintBoundary(
              child: Center(
                child: QrImageView(
                  data: encrypted.base64,
                  version: QrVersions.auto,
                  size: 300,
                ),
              ),
            ),
            SizedBox(height: 50),
            Center(
              child: Text(
                "برجاء الاحتفاظ بصوره من الكود للطباعه",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),

            // RepaintBoundary(
            //   child: Center(
            //     child: QrImageView(
            //       data: decripted,
            //       version: QrVersions.auto,
            //       size: 300,
            //     ),
            //   ),
            // ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
