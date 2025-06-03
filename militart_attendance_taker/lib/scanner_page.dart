import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:developer' as dev;
import 'package:encrypt/encrypt.dart' as enc;

import 'package:qr_reader/qr_data_model.dart';

class QRScannerPage extends StatefulWidget {
  QRScannerPage({super.key});
  final MobileScannerController crt = MobileScannerController(
    autoStart: true,
    detectionTimeoutMs: 1000,
    // detectionSpeed: DetectionSpeed.noDuplicates,
  );
  String? student_name = "";
  String? national_id = "";
  String? serial_number = "";
  String? student_phone_number = "";
  String? faculty = "";
  String? address = "";
  String? date = "";
  String? day = "";
  String? arrival_time = "";
  String? leave_time = "";

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 50),
          Center(
            child: Container(
              height: 300,
              width: 300,
              child: MobileScanner(
                controller: widget.crt,
                onDetect: (barcodes) {
                  dev.log(barcodes.barcodes.first.rawValue!.toString());
                  //logic for storing ther new QR ino the DB
                  //display snackbar only if 1.new QR  > 2. has about 30 mins of no scan
                  try {
                    var key = enc.Key.fromUtf8("8332767606048159");
                    "8332767606048159";
                    final iV = enc.IV.fromBase16(key.base16);
                    final encrypter = enc.Encrypter(enc.AES(key));
                    final decripted = encrypter.decrypt64(
                      barcodes.barcodes.first.rawValue!.toString(),
                      iv: iV,
                    );
                    dev.log(decripted);

                    List<String> obtained_data = decripted.split("|||");
                    dev.log(obtained_data.toString());
                    if (obtained_data.length == 6) {
                      QrDataModel qr = QrDataModel(
                        student_name: obtained_data[0],
                        national_id: obtained_data[1],
                        serial_number: obtained_data[2],
                        student_phone_number: obtained_data[3],
                        faculty: obtained_data[4],
                        address: obtained_data[5],
                        date: DateTime.now().toString().substring(0, 10),
                        day: DateTime.now().weekday.toString(),
                        arrival_time:
                            "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
                        leave_time: "TBD",
                      );
                      dev.log(qr.toString());
                      setState(() {
                        widget.student_name = qr.student_name;
                        widget.national_id = qr.national_id;
                        widget.serial_number = qr.serial_number;
                        widget.student_phone_number = qr.student_phone_number;
                        widget.faculty = qr.faculty;
                        widget.address = qr.address;
                        widget.date = qr.date;
                        widget.day = qr.day;
                        widget.arrival_time = qr.arrival_time;
                        widget.leave_time = qr.leave_time;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("تم فحص الكود"),
                          backgroundColor: Colors.greenAccent,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("الكود غير صحيح"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } on Exception catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("الكود غير صحيح"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 50),
          Center(child: Text("معلومات الطالب", style: TextStyle(fontSize: 20))),
          Center(child: Text("اسم الطالب: ${widget.student_name!}")),
          Center(child: Text("رقم الطالب القومي: ${widget.national_id!}")),
          Center(child: Text("رقم التسلسل: ${widget.serial_number!}")),
          Center(child: Text("رقم الهاتف: ${widget.student_phone_number!}")),
          Center(child: Text("الكلية: ${widget.faculty!}")),
          Center(child: Text("العنوان: ${widget.address!}")),
          Center(child: Text("التاريخ: ${widget.date!}")),
          Center(child: Text("اليوم: ${widget.day!}")),
          Center(child: Text("وقت الوصول: ${widget.arrival_time!}")),
          Center(child: Text("وقت الخروج: ${widget.leave_time!}")),
        ],
      ),
    );
  }
}
