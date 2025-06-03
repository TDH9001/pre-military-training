import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:developer' as dev;

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: Container(
              height: 500,
              width: 400,
              child: MobileScanner(
                onDetect: (barcodes) {
                  dev.log(barcodes.barcodes.first.rawValue!.toString());
                  print(barcodes.barcodes.first.rawValue);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("تم فحص الكود")));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
