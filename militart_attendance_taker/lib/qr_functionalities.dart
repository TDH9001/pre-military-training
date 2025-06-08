import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:qr_reader/qr_data_model.dart';
import 'package:qr_reader/student_info_caching_service.dart';

class QrFunctionalities {
  //this class is responsible for managing the qr functionalities
  //1. check if user is attended but did not pass 30-mins
  Future<List> checkIfUserIsAttendedButDidNotPass30Mins(
    QrDataModel qr,
    BuildContext cont,
  ) async {
    var studentList = await StudentInfoCachingService.getStoredStudentsInfo();
    for (int i = 0; i < studentList.length; i++) {
      if (studentList[i].national_id == qr.national_id) {
        if (studentList[i].created_at!.difference(DateTime.now()).inMinutes <
            -30) //this means that user is already attended and passed 30-mins
        {
          QrDataModel newModdel = QrDataModel(
            student_name: studentList[i].student_name,
            national_id: studentList[i].national_id,
            serial_number: studentList[i].serial_number,
            student_phone_number: studentList[i].student_phone_number,
            faculty: studentList[i].faculty,
            address: studentList[i].address,
            date: studentList[i].date,
            day: studentList[i].day,
            arrival_time: studentList[i].arrival_time,
            leave_time:
                "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
            created_at: studentList[i].created_at,
          );

          studentList.removeAt(i);
          studentList.add(newModdel);
          await StudentInfoCachingService.saveStudentInfo(studentList);
          ScaffoldMessenger.of(cont).showSnackBar(
            SnackBar(
              content: Text("تم تسجيل الانصراف لهذا الطالب بنجاح"),
              backgroundColor: Colors.greenAccent,
            ),
          );
          return [
            2,
            newModdel,
          ]; //2 means user is already attended and passed 30-mins
        } else {
          ScaffoldMessenger.of(cont).showSnackBar(
            SnackBar(
              content: Text(
                "هذا الطالب مسجل الحضور بالفعل ولم يتجاوز 30 دقيقة",
              ),
              backgroundColor: Colors.red,
            ),
          );
          return [
            1,
          ]; //1 means user is already attended and not yet passed 30-mins
        }
      }
    }
    return [0]; // 0 means user is not yet attended > will be registed as new
  }
}
