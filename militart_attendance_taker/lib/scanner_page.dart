import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:developer' as dev;
import 'package:encrypt/encrypt.dart' as enc;
import 'package:qr_reader/json_storage_service.dart';

import 'package:qr_reader/qr_data_model.dart';
import 'package:qr_reader/qr_functionalities.dart';
import 'package:qr_reader/student_info_caching_service.dart';

class QRScannerPage extends StatefulWidget {
  QRScannerPage({super.key});
  final MobileScannerController crt = MobileScannerController(
    autoStart: true,
    detectionTimeoutMs: 1000,
    // detectionSpeed: DetectionSpeed.noDuplicates,
  );

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
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

  //this value is used to determine if the QR is valid or not or if used or not
  //do not feel like using state managment
  bool is_valid = true;
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
                onDetect: (barcodes) async {
                  // dev.log(barcodes.barcodes.first.rawValue!.toString());
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
                    //  dev.log(decripted);

                    List<String> obtained_data = decripted.split("|||");

                    if (obtained_data.length == 6) {
                      QrDataModel qr = QrDataModel(
                        created_at: DateTime.now(),
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
                        leave_time: "لم يسجل بعد",
                      );

                      //  dev.log(qr.toString());
                      var studentList =
                          await StudentInfoCachingService.getStoredStudentsInfo();
                      // dev.log(studentList.toString());

                      List result = await QrFunctionalities()
                          .checkIfUserIsAttendedButDidNotPass30Mins(
                            qr,
                            context,
                          );
                      if (result == [0]) {
                        studentList.add(qr);
                        await StudentInfoCachingService.saveStudentInfo(
                          studentList,
                        );
                        //  dev.log("added the user to the box");
                        setState(() {
                          student_name = qr.student_name;
                          national_id = qr.national_id;
                          serial_number = qr.serial_number;
                          student_phone_number = qr.student_phone_number;
                          faculty = qr.faculty;
                          address = qr.address;
                          date = qr.date;
                          day = qr.day;
                          arrival_time = qr.arrival_time;
                          leave_time = qr.leave_time;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("تم تسجيل حضور الطالب الكود"),
                            backgroundColor: Colors.greenAccent,
                          ),
                        );
                      } else if (result[0] == 2) {
                        QrDataModel attendedStudent = result[1] as QrDataModel;
                        setState(() {
                          student_name = attendedStudent.student_name;
                          national_id = attendedStudent.national_id;
                          serial_number = attendedStudent.serial_number;
                          student_phone_number =
                              attendedStudent.student_phone_number;
                          faculty = attendedStudent.faculty;
                          address = attendedStudent.address;
                          date = attendedStudent.date;
                          day = attendedStudent.day;
                          arrival_time = attendedStudent.arrival_time;
                          leave_time = attendedStudent.leave_time;
                        });
                      }
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

                  //to pause the taking of scanningfs > as scanner will take as much scans of 1 code as it can
                },
              ),
            ),
          ),
          SizedBox(height: 50),
          Center(child: Text("معلومات الطالب", style: TextStyle(fontSize: 20))),
          Center(child: Text("اسم الطالب: ${student_name!}")),
          Center(child: Text("رقم الطالب القومي: ${national_id!}")),
          Center(child: Text("رقم التسلسل: ${serial_number!}")),
          Center(child: Text("رقم الهاتف: ${student_phone_number!}")),
          Center(child: Text("الكلية: ${faculty!}")),
          Center(child: Text("العنوان: ${address!}")),
          Center(child: Text("التاريخ: ${date!}")),
          Center(child: Text("اليوم: ${day!}")),
          Center(child: Text("وقت الوصول: ${arrival_time!}")),
          Center(child: Text("وقت الخروج: ${leave_time!}")),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: JsonStorageService.exportAttendanceDataToJson,
            child: Text("data to json"),
          ),
        ],
      ),
    );
  }
}
