import 'package:hive/hive.dart';
import 'package:qr_reader/qr_data_model.dart';
import 'dart:developer' as dev;

class StudentInfoCachingService {
  static late Box box;
  static Future<void> initHive() async {
    box = await Hive.openBox('studentInfo');
  }

  static Future<void> saveStudentInfo(List<QrDataModel> studentsInfo) async {
    var studentsJson = studentsInfo.map((e) => e.toMap()).toList();
    await box.put('attendance_records', studentsJson);
    dev.log("added the user to the box");
    dev.log(studentsJson.toString());
  }

  static Future<void> clearBox() async {
    await box.clear();
  }

  static Future<List<QrDataModel>> getStoredStudentsInfo() async {
    final data = await box.get('attendance_records');
    if (data != null && data is List) {
      dev.log(data.toString());
      return data.map((e) => QrDataModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
