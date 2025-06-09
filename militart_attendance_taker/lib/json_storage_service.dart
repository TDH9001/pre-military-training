import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:external_path/external_path.dart';
import 'dart:convert';
import 'dart:io';
import 'package:qr_reader/student_info_caching_service.dart';
import 'package:qr_reader/qr_data_model.dart';
import 'dart:developer' as dev;

class JsonStorageService {
  static Future<String?> exportAttendanceDataToJson(
    BuildContext context,
  ) async {
    try {
      List<QrDataModel> records =
          await StudentInfoCachingService.getStoredStudentsInfo();

      Map<String, dynamic> wrappedJson = {
        'attendance_records':
            records.map((e) => e.toMapWithoutDateTime()).toList(),
      };

      String jsonString = jsonEncode(wrappedJson);

      String downloadsPath =
          await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOWNLOAD,
          );
      String targetDir = "$downloadsPath/millitary_attendance/";
      await Directory(targetDir).create(recursive: true);
      //  Directory dir = await ExternalPath.getExternalStoragePublicDirectory().;
      String nameOfFile = DateTime.now()
          .toIso8601String()
          .replaceAll(":", "-")
          .replaceAll(" ", "_")
          .replaceAll(".", "-");
      String pathToStoreIn = "$targetDir/${p.basename(nameOfFile)}.json";

      File initialFile = await File(pathToStoreIn).writeAsString(jsonString);

      dev.log("file created");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(" تم استخراج البيانات بنجاح و حذف البيانات المخزنه"),
          backgroundColor: Colors.green,
        ),
      );
      StudentInfoCachingService.clearBox();

      return pathToStoreIn;
    } catch (e) {
      dev.log("Error exporting JSON: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("حدث خطأ في استخراج البيانات"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return null;
    }
  }
}
