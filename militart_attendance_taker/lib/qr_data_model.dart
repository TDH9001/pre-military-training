class QrDataModel {
  String? student_name;
  String? national_id;
  String? serial_number;
  String? student_phone_number;
  String? faculty;
  String? address;
  String? date;
  String? day;
  String? arrival_time;
  String? leave_time;

  QrDataModel({
    this.student_name,
    this.national_id,
    this.serial_number,
    this.student_phone_number,
    this.faculty,
    this.address,
    this.date,
    this.day,
    this.arrival_time,
    this.leave_time,
  });
  @override
  String toString() {
    return "$student_name ||| $national_id ||| $serial_number |||  $student_phone_number |||  $faculty |||  $address |||  $date |||  $day |||  $arrival_time |||  $leave_time";
  }

  Map<String, dynamic> toMap() => {
    'student_name': student_name,
    'national_id': national_id,
    'serial_number': serial_number,
    'student_phone_number': student_phone_number,
    'faculty': faculty,
    'address': address,
    'date': date,
    'day': day,
    'arrival_time': arrival_time,
    'leave_time': leave_time,
  };
}
