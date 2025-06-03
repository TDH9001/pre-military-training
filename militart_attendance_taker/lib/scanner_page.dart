import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:developer' as dev;

class QRScannerPage extends StatefulWidget {
  QRScannerPage({super.key});
  final MobileScannerController crt = MobileScannerController(
    autoStart: true,
    detectionTimeoutMs: 1000,
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

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
              width: 300,
              child: MobileScanner(
                controller: widget.crt,
                onDetect: (barcodes) {
                  dev.log(barcodes.barcodes.first.rawValue!.toString());
                  print(barcodes.barcodes.first.rawValue);
                  //logic for storing ther new QR ino the DB
                  //display snackbar only if 1.new QR  > 2. has about 30 mins of no scan
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("تم فحص الكود"),
                      backgroundColor: Colors.greenAccent,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
