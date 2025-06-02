import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrImageScreen extends StatelessWidget {
  QrImageScreen({super.key, required this.s});
  final String s;

  @override
  Widget build(BuildContext context) {
    List<String> list = s.split("|||");

    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            SizedBox(height: 100),

            RepaintBoundary(
              child: Center(
                child: QrImageView(
                  data: s,
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

            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
