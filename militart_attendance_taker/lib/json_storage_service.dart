import 'package:path/path.dart' as p;
import 'package:external_path/external_path.dart';
import 'dart:convert';
import 'dart:io';
import 'package:qr_reader/student_info_caching_service.dart';
import 'package:qr_reader/qr_data_model.dart';
import 'dart:developer' as dev;

class JsonStorageService {
  static Future<String?> exportAttendanceDataToJson() async {
    try {
      // // Request storage permission (important for Android)
      // final status = await Permission.storage.request();
      // if (!status.isGranted) {
      //   dev.log("Storage permission denied.");
      //   return null;
      // }

      // Step 1: Get attendance records
      List<QrDataModel> records =
          await StudentInfoCachingService.getStoredStudentsInfo();

      // Step 2: Convert to List<Map>
      Map<String, dynamic> wrappedJson = {
        'attendance_records':
            records.map((e) => e.toMapWithoutDateTime()).toList(),
      };

      // Step 3: Encode json to JSON string
      String jsonString = jsonEncode(wrappedJson);

      // Step 4: Get directory to store the file
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

      // Step 5: Write to file
      File initialFile = await File(pathToStoreIn).writeAsString(jsonString);
   
      dev.log("file created");
      

      //  dev.log("Exported JSON to $filePath");
      return pathToStoreIn;
    } catch (e) {
      dev.log("Error exporting JSON: $e");
      return null;
    }
  }
}
